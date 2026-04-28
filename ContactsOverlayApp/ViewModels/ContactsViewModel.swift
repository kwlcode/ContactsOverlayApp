import Foundation
import Contacts
import SwiftData
import os

/// Transforms and merges data from Apple's Contacts store and our local SwiftData storage.
@MainActor
@Observable
final class ContactsViewModel {
    
    var contacts: [ContactItem] = []
    var isLoading = false
    var errorMessage: String? = nil
    var sortOption: SortOption = .dateAddedDescending
    
    private let logger = Logger(subsystem: "com.contactsoverlay.app", category: "ContactsViewModel")
    private let modelContext: ModelContext
    
    enum SortOption: String, CaseIterable, Identifiable {
        case nameAtoZ = "Name (A-Z)"
        case dateAddedDescending = "Newest First"
        case dateAddedAscending = "Oldest First"
        
        var id: String { rawValue }
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func loadContacts() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let nativeContacts = try await ContactsManager.shared.fetchAllContacts()
            
            // Sync with local DB to get metadata like "Date Added"
            try mergeWithSwiftData(nativeContacts: nativeContacts)
            
            // Apply current sort
            applySort()
            
        } catch {
            logger.error("Error loading contacts: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func mergeWithSwiftData(nativeContacts: [CNContact]) throws {
        // Fetch existing metadata
        let descriptor = FetchDescriptor<AppContact>()
        let existingMetadata = (try? modelContext.fetch(descriptor)) ?? []
        let metadataDict = Dictionary(uniqueKeysWithValues: existingMetadata.map { ($0.identifier, $0) })
        
        // Check if this is first launch (no existing metadata)
        let isFirstLaunch = existingMetadata.isEmpty && !nativeContacts.isEmpty
        
        var mergedItems: [ContactItem] = []
        var newlyAddedCount = 0
        
        for native in nativeContacts {
            let identifier = native.identifier
            
            let appData: AppContact
            if let existing = metadataDict[identifier] {
                // Contact already tracked
                appData = existing
            } else {
                // New contact discovered
                let dateToUse: Date
                let isPreExisting: Bool
                
                if isFirstLaunch {
                    // First launch: Set contacts to a past date to avoid showing all as "added today"
                    // Distribute them randomly over the past year to create a realistic timeline
                    let daysAgo = Int.random(in: 0...365)
                    dateToUse = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
                    isPreExisting = true
                    logger.info("First launch: Setting contact \(identifier) to historical date: \(dateToUse)")
                } else {
                    // Normal operation: This is genuinely a new contact
                    dateToUse = Date()
                    isPreExisting = false
                }
                
                let newAppData = AppContact(
                    identifier: identifier,
                    dateAdded: dateToUse,
                    tags: [],
                    isPreExisting: isPreExisting
                )
                modelContext.insert(newAppData)
                appData = newAppData
                newlyAddedCount += 1
            }
            
            let item = ContactItem(id: identifier, nativeContact: native, appData: appData)
            mergedItems.append(item)
        }
        
        // Remove orphaned AppContact records that no longer exist in the device's contact store
        let currentIdentifiers = Set(nativeContacts.map { $0.identifier })
        var removedCount = 0
        for metadata in existingMetadata {
            if !currentIdentifiers.contains(metadata.identifier) {
                modelContext.delete(metadata)
                removedCount += 1
            }
        }
        
        // Save the context if anything changed
        if newlyAddedCount > 0 || removedCount > 0 {
            try? modelContext.save()
            logger.info("Synced contacts: \(newlyAddedCount) added, \(removedCount) removed (isFirstLaunch: \(isFirstLaunch))")
        }
        
        self.contacts = mergedItems
    }
    
    func applySort() {
        switch sortOption {
        case .nameAtoZ:
            contacts.sort { $0.fullName.localizedStandardCompare($1.fullName) == .orderedAscending }
        case .dateAddedDescending:
            contacts.sort { $0.dateAdded > $1.dateAdded }
        case .dateAddedAscending:
            contacts.sort { $0.dateAdded < $1.dateAdded }
        }
    }
    
    func updateSort(_ option: SortOption) {
        self.sortOption = option
        applySort()
    }
    
    func clearError() {
        self.errorMessage = nil
    }
}
