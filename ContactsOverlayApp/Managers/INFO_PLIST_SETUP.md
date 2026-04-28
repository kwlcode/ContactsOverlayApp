# Info.plist Quick Setup

## CRITICAL: Your app WILL CRASH without this configuration!

### What You Need to Add

Add this key-value pair to your Info.plist or in Xcode's Info tab:

**Key:** `NSContactsUsageDescription`  
**Type:** String  
**Value:** `This app needs access to your contacts to display them with custom organization features and track when contacts were added.`

---

## Method 1: Using Xcode Info Tab (Easiest)

```
1. Select Project → Target → Info Tab
2. Click [+] button
3. Type "Privacy - Contacts" 
4. Select "Privacy - Contacts Usage Description"
5. Paste the value from above
```

---

## Method 2: Direct XML (If you have Info.plist file)

Add this inside the `<dict>` tags:

```xml
<key>NSContactsUsageDescription</key>
<string>This app needs access to your contacts to display them with custom organization features and track when contacts were added.</string>
```

---

## Why This Matters

- Without this, iOS **will crash your app** when requesting contacts
- Apple requires explanation of WHY you need contacts access
- This message appears in the system permission dialog
- Required for App Store approval

---

## What the User Sees

When your app first runs, iOS shows:

```
┌─────────────────────────────────────┐
│  "Contact Timeline" Would Like to   │
│      Access Your Contacts           │
│                                     │
│  This app needs access to your      │
│  contacts to display them with      │
│  custom organization features and   │
│  track when contacts were added.    │
│                                     │
│    [Don't Allow]    [OK]            │
└─────────────────────────────────────┘
```

Your NSContactsUsageDescription value appears in this dialog!

---

## Verification

After adding:
1. Clean build (⇧⌘K)
2. Run on device (⌘R)
3. You should see the permission dialog
4. ✅ No crash = Success!

---

**Status:** 🔴 NOT YET CONFIGURED - Do this in Xcode now!
