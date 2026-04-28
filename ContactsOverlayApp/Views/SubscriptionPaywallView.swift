import SwiftUI
import StoreKit

struct SubscriptionPaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var subscriptionManager = SubscriptionManager.shared
    @State private var showingError = false
    @State private var showingTrialStarted = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.accentColor.opacity(0.1), Color.accentColor.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.accent)
                        
                        Text("Unlock Premium")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Get unlimited access to all features")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)
                    
                    // Features
                    VStack(alignment: .leading, spacing: 20) {
                        FeatureRow(
                            icon: "infinity.circle.fill",
                            title: "Unlimited Contacts",
                            description: "Track as many contacts as you need"
                        )
                        
                        FeatureRow(
                            icon: "chart.line.uptrend.xyaxis",
                            title: "Advanced Analytics",
                            description: "See insights about your network growth"
                        )
                        
                        FeatureRow(
                            icon: "tag.fill",
                            title: "Custom Tags",
                            description: "Organize contacts with custom categories"
                        )
                        
                        FeatureRow(
                            icon: "icloud.fill",
                            title: "iCloud Sync",
                            description: "Access your data across all devices"
                        )
                        
                        FeatureRow(
                            icon: "calendar.badge.clock",
                            title: "Contact Reminders",
                            description: "Never forget to follow up"
                        )
                        
                        FeatureRow(
                            icon: "lock.shield.fill",
                            title: "Premium Support",
                            description: "Priority email support"
                        )
                    }
                    .padding(.horizontal)
                    
                    // Pricing Card
                    VStack(spacing: 16) {
                        VStack(spacing: 12) {
                            // **BILLED AMOUNT — MOST PROMINENT** per App Store guidelines
                            if let product = subscriptionManager.subscriptionProduct {
                                Text(product.displayPrice)
                                    .font(.system(size: 56, weight: .bold))
                                    .foregroundColor(.primary)
                            } else {
                                // Fallback pricing display when product not loaded
                                Text("$19.99")
                                    .font(.system(size: 56, weight: .bold))
                                    .foregroundColor(.primary)
                            }

                            Text("per year")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)

                            if let product = subscriptionManager.subscriptionProduct {
                                Text("Just \(formattedMonthlyPrice(product)) per month")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            } else {
                                // Fallback monthly price
                                Text("Just $1.67 per month")
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            }

                            Divider()
                                .padding(.horizontal, 40)
                                .padding(.vertical, 4)

                            // Free trial — subordinate, smaller, less prominent
                            Text("7-day free trial included")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 20)
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)

                    // **CLEAR TRIAL BILLING DISCLOSURE** — Required by App Store
                    VStack(spacing: 8) {
                        Text("Free Trial Terms")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        if let product = subscriptionManager.subscriptionProduct {
                            Text("Your 7-day free trial starts today. After the trial ends, you will be automatically charged \(product.displayPrice) per year unless you cancel at least 24 hours before the trial period ends. Your subscription renews automatically each year unless cancelled.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        } else {
                            // Fallback disclosure when product not loaded
                            Text("Your 7-day free trial starts today. After the trial ends, you will be automatically charged $19.99 per year unless you cancel at least 24 hours before the trial period ends. Your subscription renews automatically each year unless cancelled.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Subscribe Button
                    Button {
                        Task {
                            let success = await subscriptionManager.purchaseAnnualSubscription()
                            if success {
                                showingTrialStarted = true
                            } else if subscriptionManager.purchaseError != nil {
                                showingError = true
                            }
                        }
                    } label: {
                        HStack {
                            if subscriptionManager.isPurchasing {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                VStack(spacing: 4) {
                                    Text("Start Free Trial")
                                        .fontWeight(.bold)
                                        .font(.headline)
                                    if let product = subscriptionManager.subscriptionProduct {
                                        Text("Then \(product.displayPrice)/year")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                    } else {
                                        // Fallback button pricing
                                        Text("Then $19.99/year")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(subscriptionManager.isPurchasing || subscriptionManager.subscriptionProduct == nil)
                    .padding(.horizontal)

                    // Restore Button
                    Button("Restore Purchases") {
                        Task {
                            await subscriptionManager.restorePurchases()
                            if subscriptionManager.isSubscribed {
                                dismiss()
                            }
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)

                    // **LEGAL LINKS — REQUIRED** by App Store guidelines
                    VStack(spacing: 12) {
                        Divider()
                            .padding(.horizontal)
                        
                        VStack(spacing: 8) {
                            Text("Subscription Information")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("Cancel anytime in your Apple ID settings. No charges during the free trial period.")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)

                            HStack(spacing: 12) {
                                Link("Privacy Policy", destination: URL(string: "https://gist.github.com/kwlcode/1b80ff11b4835abd6c5ddbbc58958301")!)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                
                                Text("•")
                                    .foregroundColor(.secondary)
                                
                                Link("Terms of Use", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .alert("Purchase Error", isPresented: $showingError) {
            Button("OK") {
                subscriptionManager.purchaseError = nil
            }
        } message: {
            Text(subscriptionManager.purchaseError ?? "Unknown error")
        }
        .alert("Trial Started!", isPresented: $showingTrialStarted) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your free trial has started and will last 7 days. Enjoy full access to all premium features!")
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Maybe Later") {
                    dismiss()
                }
            }
        }
    }
    
    private func formattedMonthlyPrice(_ product: Product) -> String {
        let yearlyPrice = product.price
        let monthlyPrice = yearlyPrice / 12
        return monthlyPrice.formatted(.currency(code: product.priceFormatStyle.currencyCode))
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.accent)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SubscriptionPaywallView()
    }
}
