import SwiftUI

struct OverlaySheetView: View {
    @Bindable var viewModel: ContactsViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // Drag Indicator styling for visual feedback
            Capsule()
                .fill(Color.secondary.opacity(0.5))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            Text("Sort & Filter")
                .font(.headline)
                .padding(.bottom, 4)
            
            // Interactive sorting selection
            HStack {
                Text("Sort By")
                    .foregroundColor(.secondary)
                Spacer()
                
                Picker("Sort", selection: $viewModel.sortOption) {
                    ForEach(ContactsViewModel.SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: viewModel.sortOption) { _, newValue in
                    withAnimation {
                        viewModel.updateSort(newValue)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Info text
            VStack(alignment: .leading, spacing: 8) {
                Text("About This App")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("This app tracks when you first added each contact. Sort by name or date to organize your contacts.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.accentColor.opacity(0.08))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // What's New / Changelog
            NavigationLink {
                ChangelogView()
            } label: {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundColor(.accentColor)
                    Text("What's New")
                        .font(.subheadline)
                    Spacer()
                    Text("v\(appVersion)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color.primary.opacity(0.05).edgesIgnoringSafeArea(.all))
    }
    
    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        return "\(version) (\(build))"
    }
}
