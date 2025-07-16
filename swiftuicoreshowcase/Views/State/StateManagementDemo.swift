//
//  StateManagementDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct StateManagementDemo: View {
    @State private var stateValue = 0
    @State private var bindingText = "Hello"
    @State private var isToggled = false
    @StateObject private var demoModel = DemoStateModel()
    @AppStorage("user_preference") private var userPreference = "default"
    @SceneStorage("scene_data") private var sceneData = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // @State Demo
                stateSection
                
                // @Binding Demo
                bindingSection
                
                // @StateObject/@ObservedObject Demo
                observableObjectSection
                
                // @AppStorage Demo
                appStorageSection
                
                // @SceneStorage Demo
                sceneStorageSection
                
                // @FocusState Demo
                focusStateSection
                
                // @Environment Demo
                environmentSection
            }
            .padding()
        }
        .navigationTitle("State Management")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("State Management")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Property wrappers, bindings, and data flow patterns in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var stateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("@State")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Text("State Value: \(stateValue)")
                    .font(.headline)
                
                HStack {
                    Button("Decrease") {
                        stateValue -= 1
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Increase") {
                        stateValue += 1
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Reset") {
                        stateValue = 0
                    }
                    .buttonStyle(.bordered)
                }
                
                Text("@State is used for simple local state that belongs to a specific view")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var bindingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("@Binding")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Text("Current Text: \(bindingText)")
                    .font(.headline)
                
                BindingChildView(text: $bindingText)
                
                Text("@Binding allows child views to read and write parent state")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var observableObjectSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("@StateObject / @ObservedObject")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Text("Counter: \(demoModel.counter)")
                    .font(.headline)
                
                Text("Name: \(demoModel.name)")
                    .font(.headline)
                
                HStack {
                    Button("Increment") {
                        demoModel.increment()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Change Name") {
                        demoModel.changeName()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Reset") {
                        demoModel.reset()
                    }
                    .buttonStyle(.bordered)
                }
                
                Text("@StateObject creates and owns an ObservableObject instance")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var appStorageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("@AppStorage")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Text("User Preference: \(userPreference)")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    Button("Set to 'Option A'") {
                        userPreference = "Option A"
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Set to 'Option B'") {
                        userPreference = "Option B"
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Reset to Default") {
                        userPreference = "default"
                    }
                    .buttonStyle(.bordered)
                }
                
                Text("@AppStorage automatically persists data to UserDefaults")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var sceneStorageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("@SceneStorage")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Text("Scene Data: \(sceneData.isEmpty ? "Empty" : sceneData)")
                    .font(.headline)
                
                TextField("Enter scene data", text: $sceneData)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Clear Scene Data") {
                    sceneData = ""
                }
                .buttonStyle(.bordered)
                
                Text("@SceneStorage persists data per scene (useful for multi-window apps)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var focusStateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("@FocusState")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Text("Text Field is \(isTextFieldFocused ? "Focused" : "Not Focused")")
                    .font(.headline)
                
                TextField("Focus me!", text: $bindingText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isTextFieldFocused)
                
                HStack {
                    Button("Focus") {
                        isTextFieldFocused = true
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Unfocus") {
                        isTextFieldFocused = false
                    }
                    .buttonStyle(.bordered)
                }
                
                Text("@FocusState manages keyboard focus for text fields")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var environmentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("@Environment")
                .font(.title2)
                .fontWeight(.semibold)
            
            EnvironmentDemo()
            
            Text("@Environment provides access to system-wide values like color scheme, locale, etc.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Supporting Views and Models

class DemoStateModel: ObservableObject {
    @Published var counter = 0
    @Published var name = "Demo"
    
    private let names = ["Demo", "SwiftUI", "State", "Model", "Object"]
    
    func increment() {
        counter += 1
    }
    
    func changeName() {
        name = names.randomElement() ?? "Demo"
    }
    
    func reset() {
        counter = 0
        name = "Demo"
    }
}

struct BindingChildView: View {
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Enter text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Set Hello") {
                    text = "Hello"
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Set World") {
                    text = "World"
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Clear") {
                    text = ""
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
}

struct EnvironmentDemo: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.locale) private var locale
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Environment Values:")
                .font(.headline)
            
            Text("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")")
            Text("Locale: \(locale.identifier)")
            Text("H Size Class: \(horizontalSizeClass == .compact ? "Compact" : "Regular")")
            Text("V Size Class: \(verticalSizeClass == .compact ? "Compact" : "Regular")")
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    NavigationView {
        StateManagementDemo()
    }
}
