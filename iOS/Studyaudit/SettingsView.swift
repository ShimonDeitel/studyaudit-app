import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) var dismiss
    @AppStorage("studyaudit_notifEnabled") private var notifEnabled = true
    @AppStorage("studyaudit_iCloudSync") private var iCloudSync = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Reminders", isOn: $notifEnabled)
                    Toggle("iCloud Backup (coming soon)", isOn: $iCloudSync)
                        .disabled(true)
                }
                Section("Studyaudit Pro") {
                    if purchases.isPro {
                        Label("Pro Unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    } else {
                        Text("Multi-week variance chart")
                            .font(Theme.captionFont)
                            .foregroundStyle(Theme.inkMuted)
                        Button("Upgrade to Pro") {
                            dismiss()
                        }
                    }
                    Button("Restore Purchases") {
                        Task { await purchases.restore() }
                    }
                    .accessibilityIdentifier("restoreButton")
                }
                Section("Legal") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/studyaudit-app/privacy.html")!)
                    Link("Terms of Service", destination: URL(string: "https://shimondeitel.github.io/studyaudit-app/terms.html")!)
                }
                Section {
                    Text("Version 1.0")
                        .foregroundStyle(Theme.inkMuted)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
        }
    }
}
