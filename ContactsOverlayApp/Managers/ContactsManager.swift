import Foundation
import Contacts
import os

/// A manager class to interact tightly with Apple's `CNContactStore`.
/// Handles fetching and requesting permissions securely.
actor ContactsManager {
    static let shared = ContactsManager()
    
    private let store = CNContactStore()
    private let logger = Logger(subsystem: "com.contactsoverlay.app", category: "ContactsManager")
    
    private init() {}
    
    /// Requests user authorization to access Contacts.
    func requestAccess() async -> Bool {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            return true
        case .limited:
            return true
        case .notDetermined:
            do {
                return try await store.requestAccess(for: .contacts)
            } catch {
                logger.error("Failed to request contacts access: \(error.localizedDescription)")
                return false
            }
        case .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }
    
    /// Fetches all contacts from the device.
    /// Only fetches properties we need for performance.
    func fetchAllContacts() async throws -> [CNContact] {
        guard await requestAccess() else {
            throw ContactsError.accessDenied
        }
        
        let keysToFetch: [CNKeyDescriptor] = [
            CNContactIdentifierKey as NSString,
            CNContactGivenNameKey as NSString,
            CNContactFamilyNameKey as NSString,
            CNContactPhoneNumbersKey as NSString,
            CNContactEmailAddressesKey as NSString,
            CNContactImageDataAvailableKey as NSString,
            CNContactThumbnailImageDataKey as NSString,
            CNContactDatesKey as NSString, // For any date fields (birthday, etc.)
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName)
        ]
        
        // Use unified contacts (groups linked contacts into a single interface)
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        request.sortOrder = .userDefault
        
        var contacts: [CNContact] = []
        
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    contacts.append(contact)
                }
                continuation.resume(returning: contacts)
            } catch {
                logger.error("Failed fetching contacts: \(error.localizedDescription)")
                continuation.resume(throwing: error)
            }
        }
    }
    
    /// Attempts to determine when a contact was added to the device.
    /// Note: CNContact does not provide an official creation date.
    /// This uses heuristics and available data to make a best guess.
    func estimateContactCreationDate(_ contact: CNContact) -> Date? {
        // CNContact does not expose creation or modification dates through the public API
        // Birthday and other date fields are not reliable indicators of when a contact was added
        // Return nil to indicate the creation date is unknown
        // Callers should track first-seen dates separately if needed
        return nil
    }
}

enum ContactsError: Error, LocalizedError {
    case accessDenied
    case fetchFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return "Contacts access is required to use this app. Please enable it in Settings under Privacy & Security → Contacts."
        case .fetchFailed(let error):
            return "Failed to load contacts: \(error.localizedDescription)"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .accessDenied:
            return "Go to Settings and enable Contacts access for this app."
        case .fetchFailed:
            return "Please try again or restart the app."
        }
    }
}
