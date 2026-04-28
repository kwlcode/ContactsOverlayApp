import Foundation
import SwiftData

/// Persistent model to store custom metadata about a contact
/// since Apple's `CNContact` does not expose a creation date.
@Model
final class AppContact {
    /// The unique identifier from CNContact (e.g., CNContact.identifier)
    @Attribute(.unique) var identifier: String
    
    /// The timestamp this contact was first discovered by our app.
    /// Note: For contacts that existed before app install, this is set to
    /// a reasonable historical date to avoid showing all contacts as "added today"
    var dateAdded: Date
    
    /// Optional stretch feature: Tagging or grouping contacts
    var tags: [String]
    
    /// Flag to indicate if this is a pre-existing contact (added before app install)
    /// Defaults to false for backward compatibility
    var isPreExisting: Bool = false
    
    init(identifier: String, dateAdded: Date = Date(), tags: [String] = [], isPreExisting: Bool = false) {
        self.identifier = identifier
        self.dateAdded = dateAdded
        self.tags = tags
        self.isPreExisting = isPreExisting
    }
}
