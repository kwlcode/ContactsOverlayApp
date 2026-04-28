import Foundation
import Contacts

/// A domain-specific model bridging a native `CNContact` with our custom `AppContact` metadata.
/// This makes our views clean and ensures they don't have to merge data themselves.
struct ContactItem: Identifiable, Hashable {
    let id: String
    let nativeContact: CNContact
    let appData: AppContact
    
    var fullName: String {
        return CNContactFormatter.string(from: nativeContact, style: .fullName) ?? "Unknown Contact"
    }
    
    var phoneNumber: String {
        return nativeContact.phoneNumbers.first?.value.stringValue ?? "No phone"
    }
    
    var dateAdded: Date {
        return appData.dateAdded
    }
    
    /// Indicates if this contact existed before the app was installed
    var isPreExisting: Bool {
        // Safe access with fallback in case of migration issues
        return appData.isPreExisting
    }
    
    /// Formatted date string for display
    var formattedDateAdded: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: dateAdded, relativeTo: Date())
    }
    
    /// Label for the date - includes context about whether it's estimated or actual
    var dateLabel: String {
        if isPreExisting {
            return "Estimated: \(formattedDateAdded)"
        } else {
            return "Added \(formattedDateAdded)"
        }
    }
    
    // Conformance to Hashable for easy SwiftUI list rendering
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ContactItem, rhs: ContactItem) -> Bool {
        lhs.id == rhs.id
    }
}

