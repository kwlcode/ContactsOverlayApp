# 🔧 Xcode Configuration Steps (Do These Now!)

## 🌐 Multi-Platform Support (macOS + iOS + iPadOS)

✅ Your app code is **already configured** to work on macOS, iOS, and iPadOS!

The steps below work for **all platforms**. See `MULTIPLATFORM_GUIDE.md` for platform-specific details.

---

## ⚠️ CRITICAL STEPS - DO IN ORDER

### Step 1: Add PrivacyInfo.xcprivacy to Target

1. Open your project in Xcode
2. In Project Navigator (left sidebar), **right-click** on your project folder
3. Select **"Add Files to [Project Name]..."**
4. Navigate to and select `PrivacyInfo.xcprivacy`
5. ✅ **IMPORTANT**: Check the box "Add to targets: [Your App]"
6. Click **"Add"**

**Verify**: Click the file → File Inspector (⌘⌥1) → "Target Membership" should be checked

---

### Step 2: Add Contacts Privacy Description (WILL CRASH WITHOUT THIS!)

**IMPORTANT: Works the same for iOS, iPadOS, AND macOS!**

The key `NSContactsUsageDescription` is **universal** across all Apple platforms.

**In Xcode Info Tab (Recommended for All Platforms):**
1. Select your **project** in Project Navigator
2. Select your **app target**
3. Go to **Info** tab
4. You'll see either:
   - "Custom iOS Target Properties" (for iOS)
   - "Custom macOS Application Target Properties" (for macOS)
   - Or both if multi-platform
5. Click the **+** button
6. Start typing: `Privacy - Contacts Usage Description` (it will auto-complete)
7. Set value: `This app needs access to your contacts to display them with custom organization features and track when contacts were added.`

**The key name is:** `NSContactsUsageDescription` (same for all platforms!)

**Alternative: Direct Info.plist Edit**
If you have an Info.plist file in your project:
1. Open Info.plist
2. Right-click → Add Row
3. Key: `NSContactsUsageDescription`
4. Type: String
5. Value: `This app needs access to your contacts to display them with custom organization features and track when contacts were added.`

**For Multi-Platform Apps:**
- If you have ONE target for iOS + macOS: Add it once
- If you have SEPARATE targets: Add to EACH target's Info section

✅ **This works for iPhone, iPad, and Mac!**

---

### Step 3: Set Up App Icon

1. Go to **Assets.xcassets** in Project Navigator
2. Click **AppIcon**
3. You'll see placeholder slots for different sizes
4. Add your app icon images (at minimum 1024x1024)

**Don't have an icon?** Use these free tools:
- [AppIcon.co](https://appicon.co) - Upload 1024x1024, get all sizes
- [MakeAppIcon](https://makeappicon.com)
- Or use SF Symbols temporarily: Right-click AppIcon → "App Icon Type" → SF Symbol

---

### Step 4: Configure Signing & Bundle ID

1. Select your **target** → **Signing & Capabilities** tab
2. Under "Signing":
   - Team: **Select your Apple Developer Team**
   - Enable: ✅ **"Automatically manage signing"**
3. Under "Bundle Identifier":
   - Change to something unique: `com.yourname.contacttimeline`
   - This must be unique across the App Store!

---

### Step 5: Set Version Numbers

1. Select your **target** → **General** tab
2. Under "Identity":
   - **Display Name**: `Contact Timeline` (or your chosen name)
   - **Version**: `1.0`
   - **Build**: `1`

---

### Step 6: Build & Test

1. Select a **real device** as destination (not simulator for best testing)
2. Press **⌘B** to build
3. Fix any errors that appear
4. Press **⌘R** to run
5. Grant contacts permission when prompted
6. Test all features!

---

## ✅ Verification Checklist

After completing the steps above, verify:

- [ ] PrivacyInfo.xcprivacy shows in Project Navigator with target membership
- [ ] Info tab shows "Privacy - Contacts Usage Description" with your message
- [ ] AppIcon is set (or placeholder SF Symbol)
- [ ] Signing shows green checkmark with your team
- [ ] Bundle ID is unique (no red warnings)
- [ ] Version is 1.0, Build is 1
- [ ] App builds without errors (⌘B)
- [ ] App runs on device without crashing (⌘R)
- [ ] Contacts permission prompt appears
- [ ] After granting permission, contacts load

---

## 🚨 Common Issues & Fixes

### "App crashes immediately"
→ You forgot NSContactsUsageDescription! Go back to Step 2.

### "Code signing error"
→ Make sure you selected your team in Step 4.

### "Bundle ID already exists"
→ Change it to something unique (add your name or random numbers).

### "Missing compliance"
→ Make sure PrivacyInfo.xcprivacy is in your target (Step 1).

---

## ⏭️ After These Steps

Once everything above is complete:
1. **Product** → **Clean Build Folder** (⇧⌘K)
2. **Product** → **Archive**
3. Proceed to App Store Connect submission

---

**Need help?** Check APP_STORE_GUIDE.md for more details!
