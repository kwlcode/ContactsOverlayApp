import SwiftUI
import SwiftData

@main
struct ContactsOverlayApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            AppContact.self
        ])
        
        // Configure with lightweight migration enabled
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // Migrate old data if needed
            Task {
                await migrateOldDataIfNeeded(container: container)
            }
            
            return container
        } catch {
            // Log the error for debugging
            print("❌ ModelContainer creation failed: \(error)")
            print("Error details: \(error.localizedDescription)")
            
            // For development: Try to get more info
            if let decodingError = error as? DecodingError {
                print("Decoding error: \(decodingError)")
            }
            
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // Migrate old AppContact records to add the isPreExisting field
    @MainActor
    static func migrateOldDataIfNeeded(container: ModelContainer) async {
        let context = container.mainContext
        
        do {
            let descriptor = FetchDescriptor<AppContact>()
            let allContacts = try context.fetch(descriptor)
            
            // Check if any contacts have isPreExisting = false (default)
            // and dateAdded is NOT from today - these are likely old records
            let today = Calendar.current.startOfDay(for: Date())
            
            for contact in allContacts {
                if !contact.isPreExisting {
                    let contactDate = Calendar.current.startOfDay(for: contact.dateAdded)
                    
                    // If the contact was added before today and isn't marked as pre-existing,
                    // it's from a previous version of the app
                    if contactDate < today {
                        // This is old data, mark as pre-existing
                        contact.isPreExisting = true
                    }
                }
            }
            
            try context.save()
            print("✅ Migration complete: Updated \(allContacts.count) contacts")
        } catch {
            print("⚠️ Migration warning: \(error)")
            // Don't crash - just log the error
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.modelContext, sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
