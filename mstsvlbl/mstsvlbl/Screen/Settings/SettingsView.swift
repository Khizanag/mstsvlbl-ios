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
    @AppStorage("autoAdvanceEnabled") private var autoAdvanceEnabled = false
    @AppStorage("showTimerEnabled") private var showTimerEnabled = true
    @AppStorage("confirmBeforeExit") private var confirmBeforeExit = true
    @AppStorage("darkModePreference") private var darkModePreference = "system"
    
    private let darkModeOptions = [
        ("system", "System", "gear"),
        ("light", "Light", "sun.max"),
        ("dark", "Dark", "moon")
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: DesignBook.Spacing.xl) {
                headerSection
                
                VStack(spacing: DesignBook.Spacing.lg) {
                    gameplaySection
                    feedbackSection
                    appearanceSection
                    aboutSection
                }
            }
            .padding(DesignBook.Spacing.xl)
        }
        .navigationTitle("Settings")
    }
}

// MARK: - Components
private extension SettingsView {
    var headerSection: some View {
        HeaderView(
            icon: "gear.circle.fill",
            title: "Settings",
            subtitle: "Customize your quiz experience"
        )
        .padding(.bottom, DesignBook.Spacing.lg)
    }
    
    var gameplaySection: some View {
        settingsCard(title: "Gameplay", icon: "gamecontroller") {
            VStack(spacing: DesignBook.Spacing.md) {
                settingRow(
                    title: "Auto-advance questions",
                    description: "Automatically move to next question after answering",
                    icon: "forward.fill"
                ) {
                    Toggle("", isOn: $autoAdvanceEnabled)
                        .toggleStyle(.switch)
                }
                
                Divider()
                
                settingRow(
                    title: "Show timer",
                    description: "Display remaining time during timed quizzes",
                    icon: "timer"
                ) {
                    Toggle("", isOn: $showTimerEnabled)
                        .toggleStyle(.switch)
                }
                
                Divider()
                
                settingRow(
                    title: "Confirm before exit",
                    description: "Ask for confirmation when leaving a quiz",
                    icon: "exclamationmark.triangle"
                ) {
                    Toggle("", isOn: $confirmBeforeExit)
                        .toggleStyle(.switch)
                }
            }
        }
    }
    
    var feedbackSection: some View {
        settingsCard(title: "Feedback", icon: "speaker.wave.2") {
            VStack(spacing: DesignBook.Spacing.md) {
                settingRow(
                    title: "Haptic feedback",
                    description: "Feel vibrations for correct and incorrect answers",
                    icon: "iphone.radiowaves.left.and.right"
                ) {
                    Toggle("", isOn: $hapticsEnabled)
                        .toggleStyle(.switch)
                }
                
                Divider()
                
                settingRow(
                    title: "Sound effects",
                    description: "Play sounds for quiz interactions",
                    icon: "speaker.2"
                ) {
                    Toggle("", isOn: $soundEnabled)
                        .toggleStyle(.switch)
                }
            }
        }
    }
    
    var appearanceSection: some View {
        settingsCard(title: "Appearance", icon: "paintbrush") {
            VStack(spacing: DesignBook.Spacing.md) {
                HStack {
                    HStack(spacing: DesignBook.Spacing.sm) {
                        Image(systemName: "circle.lefthalf.filled")
                            .foregroundStyle(DesignBook.Color.Text.secondary)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Theme")
                                .font(DesignBook.Font.body())
                                .fontWeight(.medium)
                            Text("Choose your preferred appearance")
                                .font(DesignBook.Font.caption())
                                .foregroundStyle(DesignBook.Color.Text.secondary)
                        }
                    }
                    
                    Spacer()
                }
                
                HStack(spacing: DesignBook.Spacing.sm) {
                    ForEach(darkModeOptions, id: \.0) { option in
                        themeOptionButton(
                            value: option.0,
                            title: option.1,
                            icon: option.2,
                            isSelected: darkModePreference == option.0
                        )
                    }
                }
            }
        }
    }
    
    var aboutSection: some View {
        settingsCard(title: "About", icon: "info.circle") {
            VStack(spacing: DesignBook.Spacing.md) {
                aboutRow(title: "Version", value: "1.0.0", icon: "number.circle")
                
                Divider()
                
                aboutRow(title: "Build", value: "2024.08.29", icon: "hammer")
                
                Divider()
                
                aboutRow(title: "Platform", value: "iOS • macOS", icon: "laptopcomputer.and.iphone")
                
                Divider()
                
                HStack {
                    HStack(spacing: DesignBook.Spacing.sm) {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(DesignBook.Color.Status.error)
                        Text("Made with love")
                            .font(DesignBook.Font.body())
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    Text("🚀")
                        .font(DesignBook.Font.title2())
                }
            }
        }
    }
    
    func settingsCard<Content: View>(title: String, icon: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
            HStack(spacing: DesignBook.Spacing.sm) {
                Image(systemName: icon)
                    .foregroundStyle(DesignBook.Color.Text.primary)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(DesignBook.Font.headline())
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            content()
        }
        .padding(DesignBook.Spacing.lg)
        .background(DesignBook.Color.Background.muted)
        .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
        .shadow(DesignBook.Shadow.s)
    }
    
    func settingRow<Content: View>(
        title: String,
        description: String,
        icon: String,
        @ViewBuilder control: () -> Content
    ) -> some View {
        HStack {
            HStack(spacing: DesignBook.Spacing.sm) {
                Image(systemName: icon)
                    .foregroundStyle(DesignBook.Color.Text.secondary)
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(DesignBook.Font.body())
                        .fontWeight(.medium)
                    Text(description)
                        .font(DesignBook.Font.caption())
                        .foregroundStyle(DesignBook.Color.Text.secondary)
                }
            }
            
            Spacer()
            
            control()
        }
    }
    
    func aboutRow(title: String, value: String, icon: String) -> some View {
        HStack {
            HStack(spacing: DesignBook.Spacing.sm) {
                Image(systemName: icon)
                    .foregroundStyle(DesignBook.Color.Text.secondary)
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(DesignBook.Font.body())
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            Text(value)
                .font(DesignBook.Font.body())
                .foregroundStyle(DesignBook.Color.Text.secondary)
        }
    }
    
    func themeOptionButton(value: String, title: String, icon: String, isSelected: Bool) -> some View {
        Button {
            darkModePreference = value
        } label: {
            VStack(spacing: DesignBook.Spacing.xs) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? DesignBook.Color.Generic.white : DesignBook.Color.Text.primary)
                
                Text(title)
                    .font(DesignBook.Font.caption())
                    .fontWeight(.medium)
                    .foregroundStyle(isSelected ? DesignBook.Color.Generic.white : DesignBook.Color.Text.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignBook.Spacing.sm)
            .background(isSelected ? DesignBook.Color.Text.primary : DesignBook.Color.Background.muted)
            .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.sm, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        SettingsView()
    }
}
