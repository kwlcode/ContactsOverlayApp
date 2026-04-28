import Foundation

/// Represents a single version entry in the app's changelog.
struct ChangelogEntry: Identifiable {
    let id = UUID()
    let version: String
    let date: String
    let changes: [String]
}

/// All changelog entries, newest first.
/// Add a new entry at the top of this array for each release.
let appChangelog: [ChangelogEntry] = [
    ChangelogEntry(
        version: "1.1",
        date: "2026-04-24",
        changes: [
            "Added What's New changelog view",
            "Added version display in app settings",
            "Trial confirmation popup when starting free trial",
            "Improved contact data cleanup on fresh installs",
            "Fixed subscription product loading",
        ]
    ),
    ChangelogEntry(
        version: "1.0",
        date: "2026-04-24",
        changes: [
            "Initial release",
            "Track when contacts were first added to your device",
            "Sort contacts by name or date added",
            "View detailed contact information",
            "Premium subscription with 7-day free trial",
        ]
    ),
]
