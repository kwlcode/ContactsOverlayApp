import SwiftUI

struct ContactDetailView: View {
    let item: ContactItem
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    VStack {
                        Circle()
                            .fill(Color.accentColor.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text(String(item.fullName.prefix(1)).uppercased())
                                    .font(.system(size: 40, weight: .semibold))
                                    .foregroundColor(.accentColor)
                            )
                        
                        Text(item.fullName)
                            .font(.title2)
                            .bold()
                            .padding(.top, 8)
                    }
                    Spacer()
                }
                .padding(.vertical)
                .listRowBackground(Color.clear)
            }
            
            Section("Contact Info") {
                HStack {
                    Text("Phone")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(item.phoneNumber)
                }
            }
            
            Section("App Metadata (Custom)") {
                HStack {
                    Text("Date First Discovered")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(item.dateAdded.formatted(date: .long, time: .shortened))
                }
                
                HStack {
                    Text("Tags")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(item.appData.tags.isEmpty ? "None" : item.appData.tags.joined(separator: ", "))
                }
            }
        }
        .navigationTitle(item.fullName)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
