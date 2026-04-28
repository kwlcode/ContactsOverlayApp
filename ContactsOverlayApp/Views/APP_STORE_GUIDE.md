# Contacts Overlay App - App Store Submission Guide

## ✅ Pre-Submission Checklist

### 1. **Add Privacy Usage Description in Info.plist or Project Settings**

You MUST add this to your app's Info.plist or in Xcode under **Target → Info → Custom iOS Target Properties**:

**Key:** `NSContactsUsageDescription`  
**Value:** `"This app needs access to your contacts to display them with custom organization features and track when contacts were added."`

### Steps in Xcode:
1. Select your project in the Project Navigator
2. Select your app target
3. Go to the **Info** tab
4. Click the **+** button under "Custom iOS Target Properties"
5. Type: `Privacy - Contacts Usage Description`
6. Add the value: `"This app needs access to your contacts to display them with custom organization features and track when contacts were added."`

**⚠️ Without this, your app will CRASH when requesting contacts access!**

---

### 2. **Add PrivacyInfo.xcprivacy to Your Target**

The file `PrivacyInfo.xcprivacy` has been created. Make sure it's added to your app target:

1. In Xcode, select the file in the Project Navigator
2. Open the File Inspector (⌘⌥1)
3. Under "Target Membership", ensure your app target is checked

---

### 3. **Configure App Icons**

Create an app icon set with all required sizes:
- Go to **Assets.xcassets**
- Select **AppIcon**
- Add images for all sizes (1024x1024 is required for App Store)

You can use tools like:
- [AppIcon.co](https://appicon.co)
- [MakeAppIcon](https://makeappicon.com)

---

### 4. **Update Bundle Identifier**

1. Select your project → Target → **Signing & Capabilities**
2. Set a unique Bundle Identifier (e.g., `com.yourcompany.contactsoverlay`)
3. Select your Apple Developer Team
4. Enable **Automatically manage signing**

---

### 5. **Set Marketing Version and Build Number**

1. Go to Target → **General** tab
2. Set **Version** (e.g., `1.0`)
3. Set **Build** (e.g., `1`)

---

### 6. **Test on Physical Device**

1. Connect your iPhone/iPad
2. Select it as the run destination
3. Build and run the app
4. Test contacts access permission flow
5. Test all sorting options
6. Verify the sheet/overlay functionality

---

### 7. **Create App Store Connect Entry**

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Click **My Apps** → **+** → **New App**
3. Fill in:
   - **Platform:** iOS
   - **Name:** Your app name
   - **Primary Language:** English (or your choice)
   - **Bundle ID:** Select the one you configured
   - **SKU:** A unique identifier (e.g., `contacts-overlay-001`)
4. Create the app

---

### 8. **Prepare App Store Screenshots**

Required screenshots for at least one device size:
- **6.7" Display (iPhone 15 Pro Max)** - Recommended
- **6.5" Display** 
- **5.5" Display**

Use the Simulator to take screenshots (⌘S while simulator is running).

---

### 9. **Archive and Upload**

1. In Xcode: **Product** → **Archive**
2. Once complete, **Distribute App**
3. Choose **App Store Connect**
4. Follow the wizard to upload

---

### 10. **Fill Out App Information**

In App Store Connect, complete:
- **App Privacy** (declare that you access Contacts)
- **Description** (explain what your app does)
- **Keywords**
- **Screenshots**
- **App Category** (suggest: Productivity or Utilities)
- **Age Rating**
- **Pricing** (Free or Paid)

---

### 11. **Submit for Review**

Once everything is ready:
1. Select your version
2. Click **Add for Review**
3. Answer all questions honestly
4. Click **Submit**

---

## 📝 App Description Template

### Name Ideas:
- "Contact Timeline"
- "Contact Tracker"
- "My Contacts Plus"

### Description Template:

```
Track When You Added Contacts

Keep track of when each contact was added to your phone. Sort your contacts by name or by the date they were first discovered.

FEATURES:
• See when each contact was added
• Sort by name (A-Z)
• Sort by newest or oldest first
• Search contacts quickly
• Clean, modern interface

Perfect for:
• Tracking new connections
• Organizing your contact list
• Remembering when you met someone

Your contacts never leave your device. All data is stored locally and privately.
```

---

## 🛡️ Privacy & Security Notes

This app:
- ✅ Requests contacts permission (required for functionality)
- ✅ Stores metadata locally using SwiftData
- ✅ Does NOT upload any data to servers
- ✅ Does NOT track users
- ✅ Follows Apple's privacy guidelines

---

## 🐛 Common Issues

### App crashes when accessing contacts
→ Make sure you added `NSContactsUsageDescription` to Info.plist

### PrivacyInfo.xcprivacy not found during build
→ Ensure the file is added to your target (check Target Membership)

### Sheet won't dismiss
→ Fixed in the latest code update

---

## 📞 Need Help?

If you encounter issues during submission:
1. Check Apple's [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
2. Review the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
3. Contact Apple Developer Support

---

Good luck with your submission! 🚀
