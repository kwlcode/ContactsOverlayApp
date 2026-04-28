import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: ContactsViewModel?
    @State private var isShowingOverlay: Bool = false
    @State private var showingPaywall: Bool = false
    @State private var subscriptionManager = SubscriptionManager.shared
    
    var body: some View {
        NavigationStack {
            Group {
                if let viewModel = viewModel {
                    ContactListView(viewModel: viewModel)
                        .alert("Contacts Access Required", isPresented: Binding(
                            get: { viewModel.errorMessage != nil },
                            set: { if !$0 { viewModel.clearError() } }
                        )) {
                            Button("Open Settings") {
                                openSettings()
                            }
                            Button("Cancel", role: .cancel) {
                                viewModel.clearError()
                            }
                        } message: {
                            Text(viewModel.errorMessage ?? "")
                        }
                } else {
                    ProgressView("Initializing...")
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingOverlay.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if !subscriptionManager.isSubscribed {
                        Button {
                            showingPaywall = true
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                Text("Pro")
                            }
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(20)
                        }
                    }
                }
            }
            .task {
                if viewModel == nil {
                    viewModel = ContactsViewModel(modelContext: modelContext)
                    await viewModel?.loadContacts()
                    
                    // Check subscription status
                    await subscriptionManager.checkSubscriptionStatus()
                    
                    // Show paywall after 3 seconds if not subscribed
                    if !subscriptionManager.isSubscribed {
                        try? await Task.sleep(for: .seconds(3))
                        showingPaywall = true
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingOverlay) {
            if let viewModel = viewModel {
                NavigationStack {
                    OverlaySheetView(viewModel: viewModel, isPresented: $isShowingOverlay)
                }
                #if os(iOS)
                .presentationDetents([.medium, .large])
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                .presentationCornerRadius(24)
                #endif
            }
        }
        .sheet(isPresented: $showingPaywall) {
            NavigationStack {
                SubscriptionPaywallView()
            }
        }
    }
    
    // Multi-platform Settings opener
    private func openSettings() {
        #if os(iOS)
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
        #elseif os(macOS)
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Contacts") {
            NSWorkspace.shared.open(url)
        }
        #endif
    }
}

#Preview {
    MainView()
}
