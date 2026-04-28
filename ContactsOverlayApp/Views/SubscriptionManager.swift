import Foundation
import StoreKit

/// Manages in-app purchases and subscriptions
@MainActor
@Observable
final class SubscriptionManager {
    
    // Subscription product ID (you'll configure this in App Store Connect)
    private let annualSubscriptionID = "com.nowmediaagency.contactsoverlay.annual"
    
    // Current subscription status
    var isSubscribed: Bool = false
    var currentSubscription: Product.SubscriptionInfo.Status?
    var subscriptionProduct: Product?
    
    // Purchase state
    var isPurchasing: Bool = false
    var purchaseError: String?
    
    static let shared = SubscriptionManager()
    
    private init() {
        // Start listening for transaction updates
        Task {
            await observeTransactionUpdates()
            await loadProducts()
            await checkSubscriptionStatus()
        }
    }
    
    /// Load available subscription products
    func loadProducts() async {
        do {
            let products = try await Product.products(for: [annualSubscriptionID])
            self.subscriptionProduct = products.first
        } catch {
            print("Failed to load products: \(error)")
            self.purchaseError = "Failed to load subscription options."
        }
    }
    
    /// Check current subscription status
    func checkSubscriptionStatus() async {
        guard let product = subscriptionProduct else {
            isSubscribed = false
            return
        }
        
        do {
            let statuses = try await product.subscription?.status ?? []
            
            for status in statuses {
                switch status.state {
                case .subscribed, .inGracePeriod:
                    isSubscribed = true
                    currentSubscription = status
                    return
                case .expired, .revoked:
                    isSubscribed = false
                default:
                    break
                }
            }
            
            isSubscribed = false
        } catch {
            print("Failed to check subscription: \(error)")
            isSubscribed = false
        }
    }
    
    /// Purchase annual subscription
    func purchaseAnnualSubscription() async -> Bool {
        guard let product = subscriptionProduct else {
            purchaseError = "Subscription not available"
            return false
        }
        
        isPurchasing = true
        purchaseError = nil
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                // Verify the transaction
                let transaction = try checkVerified(verification)
                
                // Update subscription status
                await checkSubscriptionStatus()
                
                // Finish the transaction
                await transaction.finish()
                
                isPurchasing = false
                return true
                
            case .userCancelled:
                isPurchasing = false
                purchaseError = "Purchase cancelled"
                return false
                
            case .pending:
                isPurchasing = false
                purchaseError = "Purchase pending approval"
                return false
                
            @unknown default:
                isPurchasing = false
                purchaseError = "Unknown purchase result"
                return false
            }
        } catch {
            isPurchasing = false
            purchaseError = "Purchase failed: \(error.localizedDescription)"
            return false
        }
    }
    
    /// Restore purchases
    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await checkSubscriptionStatus()
        } catch {
            purchaseError = "Failed to restore purchases: \(error.localizedDescription)"
        }
    }
    
    /// Observe transaction updates
    private func observeTransactionUpdates() async {
        for await result in Transaction.updates {
            do {
                let transaction = try checkVerified(result)
                await checkSubscriptionStatus()
                await transaction.finish()
            } catch {
                print("Transaction verification failed: \(error)")
            }
        }
    }
    
    /// Verify transaction authenticity
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    /// Get formatted price string
    var formattedPrice: String {
        subscriptionProduct?.displayPrice ?? "$19.99"
    }
    
    /// Get subscription display name
    var subscriptionDisplayName: String {
        subscriptionProduct?.displayName ?? "Annual Subscription"
    }
}

enum StoreError: Error {
    case failedVerification
}
