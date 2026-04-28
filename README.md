# ContactsOverlayApp

A native iOS/macOS/visionOS app built with **SwiftUI** and **SwiftData** that enhances Apple's Contacts by tracking when each contact was first added to your device — something Apple's own Contacts app doesn't provide.

## Features

- **Contact Date Tracking** — Automatically detects and records when each contact first appears on the device, using SwiftData for persistent metadata storage
- **Smart First-Launch Handling** — Distinguishes between pre-existing contacts and genuinely new ones by applying historical date distribution on first install
- **Orphaned Data Cleanup** — Automatically removes stale metadata for contacts that no longer exist on the device, ensuring data integrity across users and reinstalls
- **Search & Sort** — Real-time search filtering with multiple sort options (A-Z, newest first, oldest first)
- **Contact Detail View** — Displays phone numbers, custom metadata (date discovered, tags), and avatar initials
- **In-App Subscription** — StoreKit 2 integration with annual subscription, 7-day free trial, paywall, and purchase restoration
- **In-App Changelog** — Version history view accessible from settings, with dynamic version/build number display from `Bundle.main`
- **Multi-Platform** — Single codebase targeting iOS, macOS, and visionOS with platform-conditional compilation

## Architecture

```
ContactsOverlayApp/
├── ContactsOverlayApp.swift          # @main App entry, SwiftData ModelContainer setup, migration logic
├── Managers/
│   └── ContactsManager.swift         # Actor-isolated CNContactStore wrapper, permission handling
├── Models/
│   ├── AppContact.swift              # @Model (SwiftData) — persistent contact metadata
│   ├── ContactItem.swift             # Bridge struct merging CNContact + AppContact
│   └── ChangelogEntry.swift          # Changelog data model and static version entries
├── ViewModels/
│   └── ContactsViewModel.swift       # @Observable VM — fetches, merges, sorts contacts
└── Views/
    ├── MainView.swift                # Root NavigationStack, toolbar, sheet presentations
    ├── ContactListView.swift         # Searchable List with avatar initials and date labels
    ├── ContactDetailView.swift       # Detail view with contact info and app metadata
    ├── OverlaySheetView.swift        # Sort/filter controls, about section, changelog link
    ├── ChangelogView.swift           # Version history display
    ├── SubscriptionPaywallView.swift # StoreKit 2 paywall with trial confirmation
    └── SubscriptionManager.swift     # @Observable singleton managing purchases and status
```

## Technical Highlights

| Area | Implementation |
|------|---------------|
| **Persistence** | SwiftData with `@Model`, `ModelContainer`, `ModelContext`, lightweight migration |
| **Concurrency** | Swift structured concurrency (`async`/`await`), `actor` isolation for `ContactsManager`, `@MainActor` view models |
| **State Management** | `@Observable` (Observation framework), `@Bindable`, `@State`, `@Environment` — no Combine |
| **Contacts Framework** | `CNContactStore`, `CNContactFetchRequest`, unified contacts, permission handling with graceful degradation |
| **StoreKit 2** | `Product.products(for:)`, `Product.purchase()`, `Transaction.updates`, `VerificationResult`, `AppStore.sync()` |
| **UI Patterns** | `NavigationStack`, `.searchable`, `ContentUnavailableView`, `.sheet` with `presentationDetents`, conditional `#if os()` compilation |
| **Data Integrity** | Orphaned record cleanup on every sync, first-launch vs. incremental detection, unique `@Attribute` constraints |
| **Versioning** | Auto-incrementing build number on archive via `agvtool`, in-app version display from `Bundle.main.infoDictionary` |

## Requirements

- Xcode 26+
- iOS 26.2+ / macOS 26.2+ / visionOS 26.2+
- Swift 5.0+

## Setup

1. Clone the repository
2. Open `ContactsOverlayApp.xcodeproj` in Xcode
3. Select your development team under Signing & Capabilities
4. Build and run on a device or simulator

For StoreKit testing in the simulator, the project includes a `Configuration.storekit` file with a pre-configured annual subscription product.

## License

All rights reserved.
