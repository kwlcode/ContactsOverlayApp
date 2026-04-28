# 🌐 Multi-Platform Configuration (macOS + iOS + iPadOS)

## ✅ Code Already Updated for Multi-Platform

Your Swift code now supports all three platforms with platform-specific adaptations:

- ✅ **MainView.swift** - Uses `#if os(iOS)` for iOS-specific presentation detents
- ✅ **Settings opener** - Handles both iOS and macOS system preferences
- ✅ **Info.plist** - Includes settings for all platforms

---

## 🔧 Xcode Multi-Platform Setup

### Step 1: Configure Supported Platforms

1. Select your **project** in Project Navigator
2. Select your **target**
3. Go to **General** tab
4. Under **"Supported Destinations"**, ensure checked:
   - ✅ iPhone
   - ✅ iPad  
   - ✅ Mac (Designed for iPad)
   
   OR for native Mac app:
   - ✅ iPhone
   - ✅ iPad
   - ✅ Mac

---

### Step 2: Add Privacy Description (ALL PLATFORMS)

**The same key works for iOS, iPadOS, AND macOS:**

#### In Xcode Info Tab:
1. Select **target** → **Info** tab
2. Click **+** under "Custom [Platform] Target Properties"
3. Type: `Privacy - Contacts Usage Description`
4. Value: `This app needs access to your contacts to display them with custom organization features and track when contacts were added.`

**Key name:** `NSContactsUsageDescription`

This appears as:
- **iOS/iPadOS:** "Privacy - Contacts Usage Description"
- **macOS:** Same, but under "Custom macOS Application Target Properties"

---

### Step 3: Platform-Specific Settings

#### For macOS:
1. **Minimum macOS Version**
   - Target → General → "Minimum Deployments"
   - Set macOS: **14.0** (Sonoma) or later

2. **App Category** (macOS)
   - Target → General → Category
   - Choose: **Productivity** or **Utilities**

3. **Sandbox** (if publishing to Mac App Store)
   - Target → Signing & Capabilities
   - Click **+** → Add "App Sandbox"
   - Enable: ✅ **Contacts** (under "Hardware" or "User Data Access")

#### For iOS/iPadOS:
1. **Minimum iOS Version**
   - Target → General → "Minimum Deployments"  
   - Set iOS: **17.0** (for SwiftData support)

2. **Device Orientations**
   - Already configured in Info.plist
   - iPhone: Portrait, Landscape
   - iPad: All orientations

---

### Step 4: PrivacyInfo.xcprivacy (ALL PLATFORMS)

The same PrivacyInfo.xcprivacy file works for all platforms:

1. Right-click project → "Add Files to..."
2. Select `PrivacyInfo.xcprivacy`
3. ✅ Check **ALL targets** (iOS, macOS if separate)
4. Click Add

---

### Step 5: App Icons (Per Platform)

#### Option A: Single Target (Catalyst or Multiplatform)
1. Assets.xcassets → AppIcon
2. Add icons for:
   - iOS sizes (60pt, 76pt, 83.5pt, etc.)
   - macOS sizes (16pt, 32pt, 128pt, 256pt, 512pt, 1024pt)

#### Option B: Separate Targets
- Add AppIcon-iOS for iOS target
- Add AppIcon-macOS for macOS target

Use [AppIcon.co](https://appicon.co) and select "All Platforms"

---

### Step 6: Signing (Per Platform)

#### If Same Target for All Platforms:
1. Target → Signing & Capabilities
2. Select Team for **all platforms**
3. Bundle ID: `com.yourname.contacttimeline`
4. ✅ Enable auto-signing for each platform tab

#### If Separate Targets:
Configure signing individually for:
- iOS/iPadOS target
- macOS target

---

## 🧪 Testing Multi-Platform

### Test on iOS:
1. Select **iPhone** or **iPad** destination
2. Press **⌘R**
3. Grant contacts permission
4. Verify presentation detents work (sheet can be dragged)

### Test on macOS:
1. Select **My Mac** destination
2. Press **⌘R**
3. Grant contacts permission  
4. Verify sheet works (standard macOS sheet, no detents)

---

## 📤 App Store Submission (Multi-Platform)

### Option 1: Universal App (One Listing)
Submit as **one app** that supports iPhone, iPad, and Mac:
- One App Store listing
- Users get all platforms with one purchase
- Easier to maintain

**In App Store Connect:**
- Platforms: Select all (iOS, iPadOS, macOS)
- Screenshots needed for each platform
- One app bundle

### Option 2: Separate Apps
Submit **separate apps** for iOS and macOS:
- Two App Store listings
- Can have different names/pricing
- More flexibility but more work

**In App Store Connect:**
- Create two apps
- One for iOS (includes iPad)
- One for macOS

---

## ✅ Multi-Platform Checklist

- [ ] Code uses `#if os(iOS)` / `#if os(macOS)` where needed
- [ ] NSContactsUsageDescription added for ALL platforms
- [ ] PrivacyInfo.xcprivacy added to ALL targets
- [ ] App icons for iOS (1024x1024) and macOS (512x512, 1024x1024)
- [ ] Minimum deployment targets set (iOS 17.0, macOS 14.0)
- [ ] Signing configured for each platform
- [ ] Tested on iPhone
- [ ] Tested on iPad
- [ ] Tested on Mac
- [ ] All permission dialogs appear correctly
- [ ] Contacts load on all platforms

---

## 🚨 Platform-Specific Gotchas

### macOS Sandbox (Mac App Store)
If submitting to Mac App Store, you MUST:
1. Enable App Sandbox capability
2. Request "Contacts" entitlement
3. Include NSContactsUsageDescription

### iOS Presentation Detents
The code uses `#if os(iOS)` so:
- ✅ iOS: Interactive sheet with detents
- ✅ macOS: Standard sheet (detents not supported)

### Settings URL
The code opens:
- **iOS:** Settings app → Your app
- **macOS:** System Settings → Privacy & Security → Contacts

---

## 📱 Current Support Status

| Platform | Supported | Notes |
|----------|-----------|-------|
| iPhone | ✅ Yes | iOS 17.0+ |
| iPad | ✅ Yes | iPadOS 17.0+ |
| Mac | ✅ Yes | macOS 14.0+ (Sonoma) |
| Apple Watch | ❌ No | Not supported (Contacts framework limited) |
| Apple Vision Pro | ✅ Possible | visionOS uses same iOS code |

---

## 🎯 Recommended Approach

For **fastest App Store submission:**

1. **Start with iOS + iPadOS only**
   - Simpler approval process
   - Single platform to test
   - Can add macOS later

2. **Then add macOS**
   - Update target to include Mac
   - Add macOS app icons
   - Enable sandbox + Contacts entitlement
   - Test thoroughly

**Why?** macOS App Store has additional requirements (sandbox, entitlements) that can slow review.

---

## 💡 Next Steps

1. Decide: Universal app or separate apps?
2. Configure platforms in Xcode (Step 1 above)
3. Add privacy description (Step 2)
4. Test on each platform (iOS, iPad, Mac)
5. Submit to App Store

---

**Your code is ready for all three platforms!** 🎉  
Just configure Xcode and test on each device.
