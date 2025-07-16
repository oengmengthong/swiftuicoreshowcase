//
//  ButtonDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ButtonDemo: View {
    @State private var counter = 0
    @State private var isEnabled = true
    @State private var showingAlert = false
    @State private var selectedRole: ButtonRole? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Button Variations Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Explore different button styles, roles, and configurations")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Basic Button Styles
                VStack(spacing: 16) {
                    Text("Button Styles")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        Button("Default Button") {
                            counter += 1
                        }
                        
                        Button("Bordered Button") {
                            counter += 1
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Bordered Prominent") {
                            counter += 1
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Plain Button") {
                            counter += 1
                        }
                        .buttonStyle(.plain)
                        
                        Button("Borderless Button") {
                            counter += 1
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Button Roles
                VStack(spacing: 16) {
                    Text("Button Roles")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        Button("Normal Role") {
                            selectedRole = nil
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Destructive Role", role: .destructive) {
                            selectedRole = .destructive
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Cancel Role", role: .cancel) {
                            selectedRole = .cancel
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Button States
                VStack(spacing: 16) {
                    Text("Button States")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        Button("Enabled Button") {
                            counter += 1
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Disabled Button") {
                            counter += 1
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(true)
                        
                        Toggle("Enable Buttons", isOn: $isEnabled)
                        
                        Button("Conditionally Enabled") {
                            counter += 1
                        }
                        .buttonStyle(.bordered)
                        .disabled(!isEnabled)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Button with Images
                VStack(spacing: 16) {
                    Text("Buttons with Images")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        Button(action: { counter += 1 }) {
                            Label("Add Item", systemImage: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button(action: { counter += 1 }) {
                            Label("Download", systemImage: "arrow.down.circle")
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: { counter += 1 }) {
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                Text("Like")
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Counter Display
                VStack(spacing: 16) {
                    Text("Button Counter")
                        .font(.headline)
                    
                    Text("Pressed: \(counter) times")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Button("Reset Counter") {
                        counter = 0
                    }
                    .buttonStyle(.bordered)
                    .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Button Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Button Styles Guide")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ButtonInfoRow(style: "Default", description: "Standard button appearance")
                        ButtonInfoRow(style: "Bordered", description: "Button with border outline")
                        ButtonInfoRow(style: "Bordered Prominent", description: "Filled button with emphasis")
                        ButtonInfoRow(style: "Plain", description: "Text-only button")
                        ButtonInfoRow(style: "Borderless", description: "Button without visual borders")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Button Variations")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .alert("Button Info", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text("Selected role: \(selectedRole?.description ?? "None")")
        }
    }
}

struct ButtonInfoRow: View {
    let style: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(style)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 120, alignment: .leading)
            Text(description)
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

extension ButtonRole {
    var description: String {
        switch self {
        case .destructive:
            return "Destructive"
        case .cancel:
            return "Cancel"
        @unknown default:
            return "Unknown"
        }
    }
}

#Preview {
    NavigationStack {
        ButtonDemo()
    }
}
