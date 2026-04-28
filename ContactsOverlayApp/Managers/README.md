# Contact Timeline

A modern iOS app that helps you track when you added each contact to your phone, with powerful sorting and organization features.

## Features

- 📅 **Track Contact Dates**: See when each contact was first discovered by the app
- 🔤 **Multiple Sort Options**: Sort by name (A-Z), newest first, or oldest first
- 🔍 **Fast Search**: Quickly find contacts by name
- 🎨 **Modern Interface**: Clean SwiftUI design with interactive sheets
- 🔒 **Privacy First**: All data stored locally on device using SwiftData

## Technical Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Data Persistence**: SwiftData
- **Contacts Integration**: Contacts framework (CNContactStore)
- **Concurrency**: Swift Concurrency (async/await, actors)
- **Architecture**: MVVM pattern with Observable objects

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Project Structure

```
ContactsOverlay/
├── ContactsOverlayApp.swift    # App entry point with SwiftData setup
├── MainView.swift              # Main navigation and coordinator
├── ContactListView.swift       # Contact list with search
├── ContactDetailView.swift     # Individual contact details
├── OverlaySheetView.swift      # Sorting controls sheet
├── ContactsViewModel.swift     # Business logic and state management
├── ContactsManager.swift       # Contacts framework integration (actor)
├── AppContact.swift           # SwiftData model for contact metadata
├── ContactItem.swift          # View model combining CNContact + metadata
└── PrivacyInfo.xcprivacy      # Privacy manifest
```

## Setup Instructions

1. **Clone the repository**
2. **Open in Xcode 15+**
3. **Add Privacy Usage Description**:
   - Target → Info → Add Custom Property
   - Key: `Privacy - Contacts Usage Description`
   - Value: `"This app needs access to your contacts to display them with custom organization features and track when contacts were added."`
4. **Configure Signing**:
   - Select your development team
   - Update bundle identifier
5. **Run on device or simulator**

## Privacy & Permissions

This app requires access to Contacts to function. The app:

- ✅ Requests permission before accessing contacts
- ✅ Stores contact metadata locally using SwiftData
- ✅ Never uploads contact data to external servers
- ✅ Includes required privacy manifest (PrivacyInfo.xcprivacy)
- ✅ Follows Apple's privacy best practices

## App Store Submission

See [APP_STORE_GUIDE.md](APP_STORE_GUIDE.md) for detailed submission instructions.

Quick checklist: [SUBMISSION_CHECKLIST.md](SUBMISSION_CHECKLIST.md)

## Key Implementation Details

### SwiftData Schema
- `AppContact`: Stores custom metadata (identifier, dateAdded, tags)
- Synced with native `CNContact` objects from Contacts framework

### Concurrency
- `ContactsManager` is an `actor` for thread-safe contacts access
- ViewModel uses `@MainActor` to ensure UI updates on main thread
- Uses Swift's modern async/await patterns

### UI Features
- Presentation detents for floating sheet overlay
- Background interaction enabled for better UX
- Search integration with `.searchable` modifier
- `ContentUnavailableView` for empty states

## License

[Add your license here]

## Author

[Add your information here]

## Version History

### 1.0 (Current)
- Initial release
- Contact tracking by date added
- Multiple sort options
- Search functionality
- Modern SwiftUI interface
