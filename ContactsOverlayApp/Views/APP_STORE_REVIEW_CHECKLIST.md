# 🚀 App Store Review Success Checklist

## Purpose
This document ensures we configure everything correctly from the start to pass App Store Review on the **first submission**. Use this checklist for every new iOS app project.

---

## ⚠️ CRITICAL: Before First Submission

### 1. App Store Connect Metadata (REQUIRED)

#### ✅ App Description Field
**Location:** App Store Connect → My Apps → [Your App] → App Store → Localization → Description

**MUST Include for Subscription Apps:**

```
[Your app description and features here]

SUBSCRIPTION INFORMATION

[Subscription Name]: $[Price]/[period] with [X]-day free trial

• Payment charged to iTunes Account at confirmation of purchase
• Subscription automatically renews unless auto-renew is turned off at least 24 hours before the end of the current period
• Account charged for renewal within 24 hours prior to the end of the current period
• Subscriptions managed by the user; auto-renewal can be turned off in Account Settings after purchase
• Any unused portion of free trial forfeited when subscription purchased

Privacy Policy: [YOUR_PRIVACY_POLICY_URL]

Terms of Use (EULA): [YOUR_TERMS_OF_USE_URL]

[Closing text]
```

**🚨 COMMON REJECTION REASON:** Missing Terms of Use (EULA) link in App Description

---

### 2. In-App Subscription Screen (REQUIRED)

#### ✅ Paywall/Subscription View Must Display:

**Before showing purchase dialog, your app MUST show:**

1. **Price** - Large, most prominent element (e.g., "$19.99" in 56pt font)
2. **Billing Period** - "per year", "per month", etc.
3. **Price Breakdown** - e.g., "Just $1.67 per month" for annual
4. **Auto-Renewal Terms** - "Renews automatically unless cancelled"
5. **Trial Information** - If applicable: "7-day free trial"
6. **Trial Billing Disclosure** - When they'll be charged after trial
7. **Privacy Policy Link** - Functional, tappable link
8. **Terms of Use Link** - Functional, tappable link

**Example SwiftUI Implementation:**

```swift
// ✅ CORRECT - Price is most prominent
VStack {
    // Price - largest element
    Text(product.displayPrice)
        .font(.system(size: 56, weight: .bold))
    
    Text("per year")
        .font(.title3)
        .fontWeight(.semibold)
    
    // Monthly breakdown
    Text("Just $1.67 per month")
        .font(.callout)
    
    // Trial - smaller, less prominent
    Text("7-day free trial included")
        .font(.caption)
        .foregroundColor(.secondary)
}

// Trial terms disclosure
Text("Your 7-day free trial starts today. After the trial ends, you will be automatically charged \(product.displayPrice) per year unless you cancel at least 24 hours before the trial period ends.")
    .font(.caption)

// Legal links
HStack {
    Link("Privacy Policy", destination: URL(string: "YOUR_URL")!)
    Link("Terms of Use", destination: URL(string: "YOUR_URL")!)
}
```

**🚨 COMMON REJECTION REASON:** 
- Price not visible (loading spinner shows instead)
- Trial period more prominent than actual price
- Missing legal links in the app

---

### 3. Required URLs (MUST HAVE BEFORE SUBMISSION)

#### ✅ Privacy Policy URL
**Required for ALL apps**

**Where to Add:**
1. App Store Connect → App Privacy → Privacy Policy URL
2. In your app's subscription screen
3. In App Description (for subscription apps)

**Options:**
- Host on your website: `https://yourapp.com/privacy`
- GitHub Gist: `https://gist.github.com/username/your-gist-id`
- Apple's template generator (if using)

**Must Include:**
- What data you collect (or state "no data collected")
- How data is used
- Third-party services (analytics, etc.)
- Contact information

#### ✅ Terms of Use (EULA) URL
**Required for subscription apps**

**Where to Add:**
1. App Store Connect → App Description (include the link)
2. OR App Store Connect → App Information → EULA field
3. In your app's subscription screen

**Options:**
- Use Apple's Standard EULA: `https://www.apple.com/legal/internet-services/itunes/dev/stdeula/`
- Create custom EULA and host it

**🚨 COMMON REJECTION REASON:** Using Standard Apple EULA but forgetting to link it in App Description

#### ✅ Support URL
**Required for ALL apps**

**Where to Add:**
- App Store Connect → App Information → Support URL

**Options:**
- Email: `mailto:support@yourapp.com` (less professional)
- Website: `https://yourapp.com/support`
- Help center or FAQ page

---

### 4. Subscription Configuration (StoreKit)

#### ✅ In-App Purchase Setup
**Location:** App Store Connect → Features → In-App Purchases

**For Each Subscription:**

1. **Reference Name:** Internal name (e.g., "Annual Premium Subscription")
2. **Product ID:** Bundle ID format (e.g., `com.yourcompany.yourapp.premium.annual`)
3. **Subscription Group:** Create one (e.g., "Premium Access")
4. **Duration:** 1 week, 1 month, 1 year, etc.
5. **Price:** Select from price tiers or custom
6. **Free Trial:** Configure if applicable
7. **Localization:** Add display name and description
   - Display Name: What users see (e.g., "Premium Subscription")
   - Description: What they get (e.g., "Unlock all premium features")

#### ✅ StoreKit Configuration File (for testing)

**Create:** File → New → StoreKit Configuration File

**Add your products matching App Store Connect:**
```json
{
  "id": "com.yourcompany.yourapp.premium.annual",
  "type": "auto-renewable",
  "familyShareable": false,
  "subscriptionGroupId": "premium",
  "subscriptionDuration": "P1Y",
  "price": 19.99,
  "locale": "en_US",
  "displayName": "Premium Subscription",
  "description": "Unlock all premium features",
  "groupNumber": 1,
  "trialDuration": "P7D"
}
```

**🚨 COMMON ISSUE:** Product IDs don't match between StoreKit file and App Store Connect

---

### 5. App Privacy Questionnaire

#### ✅ Complete Privacy Questionnaire
**Location:** App Store Connect → App Privacy → Get Started

**Answer ALL questions accurately:**

**For a typical contacts app:**
- ✅ Do you collect data? **No** (if processing locally only)
- ✅ Contact Info access? **Yes** - but state "not collected by app"
- ✅ Usage Data? **No** (unless using analytics)
- ✅ Diagnostics? **No** (unless using crash reporting)

**If using third-party services:**
- Analytics (Firebase, Mixpanel): **Declare usage data collection**
- Crash reporting (Crashlytics): **Declare diagnostics data**
- Ads: **Declare advertising data**

**🚨 COMMON REJECTION REASON:** Privacy nutrition label doesn't match actual data collection

---

### 6. Screenshots & Previews

#### ✅ Screenshot Requirements

**Required Sizes:**
- iPhone 6.7" Display: **1290 × 2796 pixels** (iPhone 15 Pro Max, 15 Plus, 14 Pro Max)

**Minimum:** 1 screenshot (recommend 3-5)

**Must Show:**
- ✅ Actual app functionality
- ✅ Representative of current version
- ✅ No placeholder content (use realistic data)
- ✅ Proper status bar (9:41 AM is Apple convention)
- ✅ Good signal/battery indicators

**For Subscription Apps:**
- Include screenshot of paywall showing pricing
- Ensures transparency about costs

**🚨 COMMON REJECTION REASON:** Screenshots don't match current app version

#### ✅ App Previews (Optional)
- Video previews are optional but recommended
- 15-30 seconds maximum
- Must show actual app (no animations/mockups)

---

### 7. App Information Fields

#### ✅ Required Fields Checklist

**App Store Connect → App Information:**

- [ ] **Name:** App name (30 characters max)
- [ ] **Subtitle:** Brief description (30 characters max)
- [ ] **Bundle ID:** Must match Xcode project
- [ ] **SKU:** Unique identifier (any format)
- [ ] **Primary Language:** English (U.S.) or your language
- [ ] **Category:** Primary and secondary
- [ ] **Content Rights:** Who owns content
- [ ] **Age Rating:** Complete questionnaire accurately
- [ ] **Copyright:** Year and company name

**App Store → Version Information:**

- [ ] **Version Number:** 1.0 for first submission
- [ ] **Copyright:** © 2026 Your Company Name
- [ ] **Description:** With subscription terms (see #1)
- [ ] **Keywords:** Comma-separated (100 characters max)
- [ ] **Support URL:** Valid, functional URL
- [ ] **Marketing URL:** Optional
- [ ] **Promotional Text:** Optional (170 characters)

---

### 8. Pricing & Availability

#### ✅ Configuration

**App Store Connect → Pricing and Availability:**

- [ ] **Price:** Free (if offering IAP) or Paid
- [ ] **Availability:** Select countries/regions
- [ ] **Pre-Order:** Optional
- [ ] **App Store Distribution:** On (usually)

**For Subscription Apps:**
- Base app should typically be **Free**
- Revenue from subscriptions, not upfront cost

---

### 9. TestFlight & App Review Information

#### ✅ TestFlight Beta Testing (Recommended)

**Before submitting to App Review:**

1. Upload build to TestFlight
2. Test on real devices (not just simulator)
3. Verify subscription purchase flow works
4. Test with sandbox Apple ID
5. Check all links (Privacy, Terms, Support)
6. Test on oldest supported iOS version

#### ✅ App Review Information

**App Store Connect → App Review Information:**

- [ ] **Sign-in required?** If yes, provide test account
- [ ] **Contact Information:** Valid email and phone
- [ ] **Notes:** Explain any complex features
  - For subscription apps: "Subscription screen visible after 3 seconds or by tapping Pro badge"
  - Test account info if needed
  - Special instructions for reviewers

**🚨 CRITICAL:** Provide working test account if login required

---

### 10. Export Compliance

#### ✅ Export Compliance Questions

**After uploading build:**

App Store Connect will ask:
- "Is your app designed to use cryptography or does it contain encryption?"

**Most apps:** Answer **No** unless:
- Using custom encryption (not Apple's standard HTTPS)
- Implementing cryptographic features
- Using third-party encryption libraries

**Standard HTTPS/TLS:** Does NOT require export compliance documentation

---

## 📋 Pre-Submission Final Checklist

### Before Clicking "Submit for Review":

- [ ] ✅ All metadata fields completed
- [ ] ✅ Description includes subscription terms + EULA link
- [ ] ✅ Privacy Policy URL is valid and functional
- [ ] ✅ Terms of Use URL is valid and functional
- [ ] ✅ Support URL is valid and functional
- [ ] ✅ Screenshots uploaded (minimum 1, recommend 3-5)
- [ ] ✅ App Privacy questionnaire completed accurately
- [ ] ✅ Subscription products created in App Store Connect
- [ ] ✅ In-app subscription screen shows pricing prominently
- [ ] ✅ Privacy Policy and Terms links in app are functional
- [ ] ✅ Tested on real device with TestFlight
- [ ] ✅ Verified subscription purchase flow works
- [ ] ✅ App Review Information filled out (contact, notes)
- [ ] ✅ Age rating completed
- [ ] ✅ Export compliance answered
- [ ] ✅ Copyright information correct
- [ ] ✅ Version number is 1.0

---

## 🚨 Top 5 Rejection Reasons (and How to Avoid)

### 1. **Guideline 3.1.2 - Missing Subscription Information**

**Problem:** Terms of Use (EULA) link not in App Description

**Solution:**
- ✅ Add Privacy Policy URL to App Description
- ✅ Add Terms of Use (EULA) URL to App Description
- ✅ Include full subscription terms in description

---

### 2. **Guideline 3.1.2 - Pricing Not Displayed in App**

**Problem:** Subscription screen doesn't show price before purchase

**Solution:**
- ✅ Display price as MOST PROMINENT element (largest font)
- ✅ Show billing period (per year, per month)
- ✅ Show trial information (but less prominent than price)
- ✅ Include Privacy Policy and Terms links in the app
- ✅ Use fallback pricing if StoreKit hasn't loaded yet

**❌ WRONG:** Loading spinner with no price
**✅ CORRECT:** $19.99 in 56pt font, always visible

---

### 3. **Guideline 5.1.1 - Privacy Policy Required**

**Problem:** No Privacy Policy URL provided

**Solution:**
- ✅ Create Privacy Policy (even if "no data collected")
- ✅ Add URL to App Store Connect → App Privacy
- ✅ Include link in app (subscription screen)
- ✅ Include link in App Description for subscription apps

---

### 4. **Guideline 2.1 - App Completeness**

**Problem:** App crashes, broken features, placeholder content

**Solution:**
- ✅ Test on real devices before submission
- ✅ Test with TestFlight first
- ✅ No placeholder images or "Lorem ipsum" text
- ✅ All features functional
- ✅ No crashes on launch or basic navigation

---

### 5. **Guideline 2.3.1 - Accurate Metadata**

**Problem:** Screenshots don't match app, description is misleading

**Solution:**
- ✅ Screenshots from current version only
- ✅ Description accurately reflects features
- ✅ Don't promise features not yet implemented
- ✅ Price in screenshots matches actual price

---

## 🔄 Responding to Rejections

### If You Get Rejected:

1. **Read the rejection carefully** - Apple specifies exact guideline
2. **Check Resolution Center** - App Store Connect → App Review messages
3. **Fix the issues** - Update metadata or resubmit build
4. **Reply to Apple** - Acknowledge changes made
5. **Resubmit** - Usually reviewed within 1-2 days

### Reply Template:

```
Hello,

Thank you for your feedback regarding [specific guideline].

I have made the following changes:
✅ [Change 1]
✅ [Change 2]
✅ [Change 3]

[If metadata change only:]
No new build was required. The App Description and metadata have been updated with the required information.

[If new build:]
A new build ([version number]) has been uploaded addressing these issues.

All requirements are now met per Guideline [X.X.X].

Thank you for your review!
```

---

## 📚 Essential Resources

### Apple Documentation:
- App Store Review Guidelines: https://developer.apple.com/app-store/review/guidelines/
- Subscription Best Practices: https://developer.apple.com/app-store/subscriptions/
- StoreKit 2 Documentation: https://developer.apple.com/storekit/

### Tools:
- App Store Connect: https://appstoreconnect.apple.com
- TestFlight: Built into App Store Connect
- Xcode Organizer: For uploading builds

### Support:
- Contact App Review: App Store Connect → Contact Us
- Developer Forums: https://developer.apple.com/forums/
- Technical Support: https://developer.apple.com/support/

---

## 🎯 Success Metrics

### First Submission Success Checklist:

If you follow this guide completely, you should have:
- ✅ 90%+ chance of approval on first submission
- ✅ No metadata rejections
- ✅ No subscription guideline violations
- ✅ No privacy policy issues
- ✅ Faster review times (1-2 days typical)

### Time Investment:
- Setting up correctly from start: **2-3 hours**
- Fixing rejections after the fact: **1-2 weeks** (multiple submission cycles)

**Invest the time upfront to save weeks later!**

---

## 📝 Project-Specific Notes

### For This Project (Contacts Overlay):

**What We Did Right:**
- ✅ Created subscription paywall with prominent pricing
- ✅ Added Privacy Policy and Terms links in app
- ✅ Used fallback pricing for better UX

**What We Fixed:**
- ❌ Initially missing Terms of Use link in App Description
- ✅ Added EULA link to metadata
- ✅ Updated description with full subscription terms

**Lessons Learned:**
- Even with perfect in-app implementation, metadata must also be complete
- Apple checks both the app AND App Store Connect metadata
- Terms of Use link in description is non-negotiable for subscriptions
- Reply promptly to App Review to expedite resubmission

---

## 🚀 Quick Start Template

### Copy this for every new project:

```markdown
# [App Name] - App Store Submission Checklist

## Pre-Launch Setup

- [ ] Privacy Policy created and hosted
- [ ] Terms of Use created and hosted (or using Apple's)
- [ ] Support URL/email configured
- [ ] Subscription products created in App Store Connect
- [ ] StoreKit configuration file in project
- [ ] App icons (all required sizes)
- [ ] Launch screen configured

## In-App Implementation

- [ ] Subscription screen shows price prominently
- [ ] Privacy Policy link functional
- [ ] Terms of Use link functional  
- [ ] Pricing displays even if StoreKit hasn't loaded
- [ ] Trial terms clearly explained
- [ ] Purchase flow tested with sandbox account

## App Store Connect

- [ ] App Description includes subscription terms
- [ ] Description includes Privacy Policy link
- [ ] Description includes Terms of Use link
- [ ] Privacy Policy URL field completed
- [ ] Support URL field completed
- [ ] Screenshots uploaded (3-5 recommended)
- [ ] App Privacy questionnaire completed
- [ ] Age rating completed
- [ ] Pricing configured
- [ ] App Review Information filled out

## Testing

- [ ] Tested on real device via TestFlight
- [ ] Verified subscription purchase works
- [ ] All links tested (Privacy, Terms, Support)
- [ ] Tested on oldest supported iOS version
- [ ] No crashes on basic functionality

## Final Review

- [ ] Read through entire app description
- [ ] Clicked all URLs to verify they work
- [ ] Checked screenshots match current version
- [ ] Reviewed App Privacy answers for accuracy
- [ ] Verified subscription pricing matches everywhere

## Submit!

Date Submitted: ___________
Expected Review: 1-2 days
Status: ___________
```

---

## 💡 Pro Tips

1. **Use TestFlight extensively** - Catch issues before App Review does
2. **Set up StoreKit testing** - Test subscriptions without spending money
3. **Keep URLs permanent** - Don't use temporary links for Privacy/Terms
4. **Save reviewer time** - Clear notes, working test accounts
5. **Be honest** - Privacy questionnaire accuracy matters
6. **Stay updated** - Apple updates guidelines regularly
7. **Use App Store Connect API** - Automate screenshots and metadata if building multiple apps

---

## 📞 Need Help?

If you get stuck:
1. Check this document first
2. Review Apple's guidelines (link above)
3. Search Developer Forums for similar issues
4. Contact App Review through App Store Connect
5. Request phone call with App Review (available Tue/Thu)

---

**Last Updated:** April 2026  
**Next Review:** Before next app submission  
**Maintained By:** Development Team

---

## Appendix: Common URLs

### Privacy Policy Hosting Options:
- Website: `https://yourapp.com/privacy`
- GitHub Gist: `https://gist.github.com/username/[gist-id]`
- GitHub Pages: `https://username.github.io/app-privacy`
- PrivacyPolicies.com (paid)
- TermsFeed (paid)

### Terms of Use Options:
- Apple Standard: `https://www.apple.com/legal/internet-services/itunes/dev/stdeula/`
- Custom hosted: `https://yourapp.com/terms`

### Example Privacy Policy (Minimal):

```markdown
# Privacy Policy for [App Name]

Last Updated: [Date]

## Data Collection
[App Name] does not collect, store, or transmit any personal data. All data remains on your device.

## Contacts Access
The app requests access to your contacts solely to display them within the app. Contact data never leaves your device.

## Third-Party Services
[App Name] does not use any third-party analytics, advertising, or tracking services.

## Contact
For questions: support@yourapp.com

## Changes
We may update this policy. Changes will be posted at this URL.
```

---

**END OF CHECKLIST**

✅ Use this document for EVERY new iOS app to ensure first-time approval success!
