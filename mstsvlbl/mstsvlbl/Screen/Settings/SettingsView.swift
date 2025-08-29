//
//  SettingsView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    @AppStorage("soundEnabled") private var soundEnabled = true

    var body: some View {
        NavigationView {
            Form {
                Section("Feedback") {
                    Toggle("Haptics", isOn: $hapticsEnabled)
                    Toggle("Sound", isOn: $soundEnabled)
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundStyle(DesignBook.Color.textSecondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}


