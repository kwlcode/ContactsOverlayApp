# 💰 Subscription Pricing Information

## Your Subscription Details

**Product:** Premium Annual Subscription  
**Price:** $20.00 USD per year  
**Monthly equivalent:** $1.67 per month  
**Free trial:** 7 days  
**Billing:** After trial ends, $20.00 charged annually  
**Auto-renewal:** Yes, unless cancelled 24 hours before period ends  

---

## 📱 How It Displays in Your App

When users see your paywall, they'll see:

```
┌─────────────────────────────────┐
│                                 │
│      $20.00                     │ ← LARGEST (56pt bold)
│                                 │
│     per year                    │ ← Prominent (title3)
│                                 │
│  Just $1.67 per month           │ ← Secondary info
│                                 │
│  ─────────────────────          │
│                                 │
│  7-day free trial included      │ ← Small gray text
│                                 │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│  Free Trial Terms               │
│                                 │
│  Your 7-day free trial starts   │
│  today. After the trial ends,   │
│  you will be automatically      │
│  charged $20.00 per year...     │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│    Start Free Trial             │
│    Then $20.00/year             │ ← Shows price on button
└─────────────────────────────────┘
```

---

## 🌍 Regional Pricing

StoreKit automatically converts your USD price to local currencies:

| Region | Approximate Price |
|--------|------------------|
| 🇺🇸 USA | $20.00 USD |
| 🇬🇧 UK | £17.99 GBP |
| 🇪🇺 EU | €19.99 EUR |
| 🇨🇦 Canada | $25.99 CAD |
| 🇦🇺 Australia | $29.99 AUD |
| 🇯🇵 Japan | ¥2,400 JPY |

*Note: Apple determines these prices based on currency exchange rates and regional pricing tiers*

---

## 💡 Value Proposition

At $20/year, users are getting:

- **Daily cost:** $0.05 per day (less than a pack of gum!)
- **Weekly cost:** $0.38 per week
- **Monthly cost:** $1.67 per month

**Great comparison lines for marketing:**
- "Less than $2 per month"
- "Only $20 for a full year of unlimited access"
- "Just $0.05 per day to stay connected"
- "The cost of one coffee per month"

---

## 📝 App Store Connect Settings

### Where to Find Your Subscription in App Store Connect:

1. **App Store Connect** → **My Apps** → **[Your App]**
2. **Subscriptions** tab (left sidebar)
3. Click on your subscription product
4. **Subscription Pricing** section

### Verify These Settings:

```
✅ Subscription Name: [Your product name - e.g., "Premium Annual"]
✅ Subscription Duration: 1 Year
✅ Price: $20.00 USD (Tier 10 or custom)
✅ Free Trial: 7 Days
✅ Introductory Offer: Free Trial selected
✅ Auto-renewable: ON
✅ Available in all territories: ✓
```

---

## 🧪 Testing with $20 Price

When testing in Xcode with StoreKit Configuration file:

**Your .storekit file should have:**

```json
{
  "identifier" : "com.yourapp.premium.annual",
  "reference_name" : "Premium Annual",
  "type" : "auto-renewable",
  "duration" : "P1Y",
  "price" : 20.00,
  "family_sharable" : false,
  "subscription_group" : "your_group",
  "introductory_offer" : {
    "type" : "free",
    "duration" : "P7D",
    "payment_mode" : "free"
  }
}
```

### Testing Checklist:

```
□ Sandbox user created in App Store Connect
□ Logged into sandbox account on test device
□ Launch app → view subscription screen
□ Verify shows "$20.00" (or regional equivalent)
□ Verify shows "per year"
□ Verify shows "$1.67 per month" calculation
□ Tap Subscribe button
□ Sandbox prompt shows $20.00 and 7-day trial
□ Subscription processes successfully
```

---

## 📊 Revenue Calculations

### Annual Revenue Per Subscriber:

```
Gross Revenue:           $20.00
Apple Commission (30%):  -$6.00
Your Net (70%):          $14.00 per year per user
```

### After Year 1 (15% commission):

```
Gross Revenue:           $20.00
Apple Commission (15%):  -$3.00
Your Net (85%):          $17.00 per year per user
```

### User Lifetime Value Examples:

| Retention | Year 1 | Year 2 | Year 3 | Total |
|-----------|--------|--------|--------|-------|
| 1 year | $14.00 | - | - | $14.00 |
| 2 years | $14.00 | $17.00 | - | $31.00 |
| 3 years | $14.00 | $17.00 | $17.00 | $48.00 |

*Note: Commission drops to 15% after user's first year of subscription*

---

## 🎯 Marketing Copy Suggestions

### For App Store Description:

```
"Premium Annual Subscription - $20/year"
• Unlimited contacts and tags
• Advanced analytics and insights  
• Priority support
• iCloud sync across devices
• 7-day free trial - cancel anytime

Just $1.67 per month when billed annually. Try free for 7 days!
```

### For In-App Messaging:

```
"Unlock Premium for $20/year"
✨ Full access to all features
📊 Advanced analytics
☁️ Sync across devices
⏰ Contact reminders
🎯 Custom tags

Try free for 7 days, then only $20/year ($1.67/month)
```

### For Social Media:

```
"Our app is now available! 
Premium features for just $20/year - that's less than $2/month!
🎉 7-day free trial included
✨ [Key features]
📲 Download now: [Link]"
```

---

## ✅ App Review Requirements Met

With $20/year pricing, your paywall shows:

| Requirement | Your Implementation |
|-------------|-------------------|
| Subscription title | ✅ "Premium Annual" |
| Length | ✅ "per year" |
| Price | ✅ **$20.00** (56pt bold - most prominent) |
| Price per unit | ✅ "$1.67 per month" |
| Privacy link | ✅ Functional link |
| Terms link | ✅ Functional link |
| Free trial disclosed | ✅ "7-day free trial included" |
| Billing disclosed | ✅ "After trial ends, charged $20.00/year" |
| Billed amount prominent | ✅ YES - largest element |

**Result:** Meets all App Store guidelines ✅

---

## 🔄 If You Ever Need to Change the Price

### In App Store Connect:

1. **My Apps** → **[Your App]** → **Subscriptions**
2. Click your subscription
3. Click **Subscription Pricing**
4. Click **Add Pricing** or **Edit**
5. Select new price tier
6. Set effective date
7. Save

**Important:** 
- Existing subscribers keep their current price (grandfathered)
- New subscribers get the new price
- You can preserve pricing for existing users
- Price changes require App Store review

---

## 💬 Customer Support - Price FAQs

### Common Questions:

**Q: How much is the subscription?**  
A: $20.00 USD per year, which is just $1.67 per month. We also offer a 7-day free trial.

**Q: When will I be charged?**  
A: You won't be charged during your 7-day free trial. After the trial, you'll be charged $20.00 annually.

**Q: Can I cancel?**  
A: Yes! Cancel anytime in Settings → [Your Name] → Subscriptions. No charges if you cancel during the free trial.

**Q: Do I have to pay monthly?**  
A: No, it's an annual subscription. You pay $20 once per year (much cheaper than monthly!).

**Q: What happens after the first year?**  
A: Your subscription auto-renews at $20.00 unless you cancel at least 24 hours before renewal.

**Q: Is the trial really free?**  
A: Yes! No charges for 7 days. Cancel anytime during the trial at no cost.

---

## 🎉 Summary

**Your Subscription:**
- 💰 **Price:** $20.00 USD per year
- 📅 **Trial:** 7 days free
- 💳 **Billing:** Annual ($1.67/month equivalent)
- 🔄 **Renewal:** Automatic unless cancelled
- 🌍 **Availability:** Worldwide with regional pricing

**App Store Status:**
- ✅ Price clearly displayed (56pt bold)
- ✅ Trial terms clearly disclosed
- ✅ Legal links prominent
- ✅ Meets all guidelines
- ✅ Ready for approval

**Value:**
- Less than $2 per month
- Less than $0.05 per day
- Great value for users
- Competitive pricing for contact management apps

---

Good luck with your submission! 🚀

