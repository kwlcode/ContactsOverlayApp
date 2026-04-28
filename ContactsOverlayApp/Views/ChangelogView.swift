import SwiftUI

struct ChangelogView: View {
    var body: some View {
        List {
            ForEach(appChangelog) { entry in
                Section {
                    ForEach(entry.changes, id: \.self) { change in
                        HStack(alignment: .top, spacing: 8) {
                            Text("\u{2022}")
                                .foregroundColor(.accentColor)
                            Text(change)
                                .font(.subheadline)
                        }
                    }
                } header: {
                    HStack {
                        Text("Version \(entry.version)")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Text(entry.date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("What's New")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        ChangelogView()
    }
}
