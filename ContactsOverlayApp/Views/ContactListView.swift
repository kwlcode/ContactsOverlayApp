import SwiftUI
import Contacts

struct ContactListView: View {
    @Bindable var viewModel: ContactsViewModel
    @State private var searchText: String = ""
    
    var filteredContacts: [ContactItem] {
        if searchText.isEmpty {
            return viewModel.contacts
        }
        return viewModel.contacts.filter { $0.fullName.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        List(filteredContacts) { item in
            NavigationLink(destination: ContactDetailView(item: item)) {
                HStack(spacing: 16) {
                    // Placeholder for Avatar
                    Circle()
                        .fill(Color.accentColor.opacity(0.2))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Text(String(item.fullName.prefix(1)).uppercased())
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.fullName)
                            .font(.headline)
                        
                        HStack(spacing: 4) {
                            if item.isPreExisting {
                                Image(systemName: "clock.arrow.circlepath")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            Text(item.dateLabel)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
        .overlay {
            if viewModel.isLoading {
                ProgressView("Syncing Contacts...")
            } else if viewModel.contacts.isEmpty {
                ContentUnavailableView(
                    "No Contacts",
                    systemImage: "person.crop.circle.badge.questionmark",
                    description: Text("Please grant contacts permission or add a new contact.")
                )
            } else if filteredContacts.isEmpty {
                ContentUnavailableView.search(text: searchText)
            }
        }
        .searchable(text: $searchText, prompt: "Search Names...")
    }
}
