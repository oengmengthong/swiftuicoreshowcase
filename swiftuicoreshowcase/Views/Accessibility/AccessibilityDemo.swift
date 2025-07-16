//
//  AccessibilityDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct AccessibilityDemo: View {
    @State private var sliderValue: Double = 50
    @State private var isEnabled = true
    @State private var counter = 0
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // Accessibility Labels
                accessibilityLabelsSection
                
                // Dynamic Type
                dynamicTypeSection
                
                // VoiceOver Support
                voiceOverSection
                
                // Accessibility Traits
                accessibilityTraitsSection
                
                // Accessibility Actions
                accessibilityActionsSection
                
                // Color and Contrast
                colorContrastSection
                
                // Accessibility Best Practices
                bestPracticesSection
            }
            .padding()
        }
        .navigationTitle("Accessibility")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Accessibility Features")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("VoiceOver, Dynamic Type, and accessibility modifiers in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var accessibilityLabelsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Accessibility Labels")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                // Button with accessibility label
                Button(action: { counter += 1 }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .accessibilityLabel("Increment counter")
                .accessibilityHint("Increases the counter value by one")
                .accessibilityValue("\(counter)")
                
                Text("Counter: \(counter)")
                    .font(.headline)
                    .accessibilityLabel("Current counter value is \(counter)")
                
                // Image with accessibility description
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.yellow)
                    .accessibilityLabel("Favorite star")
                    .accessibilityHint("Indicates this item is marked as favorite")
                
                Text("Accessibility labels provide descriptive text for screen readers")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var dynamicTypeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Dynamic Type Support")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Current Dynamic Type: \(dynamicTypeSize.description)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("This text scales with Dynamic Type")
                    .font(.body)
                
                Text("Large Title")
                    .font(.largeTitle)
                
                Text("Title")
                    .font(.title)
                
                Text("Headline")
                    .font(.headline)
                
                Text("Body")
                    .font(.body)
                
                Text("Caption")
                    .font(.caption)
                
                Text("Go to Settings > Display & Brightness > Text Size to test dynamic type scaling")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var voiceOverSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("VoiceOver Support")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                // Grouped accessibility elements
                VStack(alignment: .leading, spacing: 8) {
                    Text("Profile Information")
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("John Doe")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text("Software Developer")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Profile: John Doe, Software Developer")
                
                // Slider with custom accessibility
                VStack(alignment: .leading, spacing: 8) {
                    Text("Volume: \(Int(sliderValue))%")
                        .font(.subheadline)
                    
                    Slider(value: $sliderValue, in: 0...100, step: 1)
                        .accessibilityLabel("Volume slider")
                        .accessibilityValue("\(Int(sliderValue)) percent")
                        .accessibilityAdjustableAction { direction in
                            switch direction {
                            case .increment:
                                sliderValue = min(100, sliderValue + 10)
                            case .decrement:
                                sliderValue = max(0, sliderValue - 10)
                            @unknown default:
                                break
                            }
                        }
                }
                
                Text("Enable VoiceOver in Settings > Accessibility to test these features")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var accessibilityTraitsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Accessibility Traits")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Button("Button with Button Trait") {
                    // Action
                }
                .accessibilityAddTraits(.isButton)
                
                Text("Header Text")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                
                Toggle("Enable Feature", isOn: $isEnabled)
                    .accessibilityLabel("Feature toggle")
                    .accessibilityHint("Toggles the feature on or off")
                
                Text("Selected Item")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                    .accessibilityAddTraits(.isSelected)
                
                Text("Accessibility traits help VoiceOver understand element types")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var accessibilityActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Accessibility Actions")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Text("Swipe actions demo")
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
                    .accessibilityAction(named: "Like") {
                        // Like action
                    }
                    .accessibilityAction(named: "Share") {
                        // Share action
                    }
                    .accessibilityAction(named: "Delete") {
                        // Delete action
                    }
                
                Text("Custom actions provide additional interaction options for VoiceOver users")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var colorContrastSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Color & Contrast")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                // Good contrast
                Text("Good contrast example")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                // Poor contrast (avoid this)
                Text("Poor contrast example")
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                
                // Adaptive colors
                Text("Adaptive colors (system colors)")
                    .padding()
                    .background(Color(.systemBackground))
                    .foregroundColor(Color(.label))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                Text("Use system colors for automatic dark mode support")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var bestPracticesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Best Practices")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Accessibility Guidelines:")
                    .font(.headline)
                
                Text("• Provide meaningful labels for all interactive elements")
                Text("• Use semantic font styles that scale with Dynamic Type")
                Text("• Ensure sufficient color contrast (4.5:1 minimum)")
                Text("• Support VoiceOver with proper hints and values")
                Text("• Group related elements for better navigation")
                Text("• Test with VoiceOver enabled")
                Text("• Consider users with motor disabilities")
                Text("• Use standard UI elements when possible")
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Extensions

extension DynamicTypeSize {
    var description: String {
        switch self {
        case .xSmall: return "Extra Small"
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        case .xLarge: return "Extra Large"
        case .xxLarge: return "Extra Extra Large"
        case .xxxLarge: return "Extra Extra Extra Large"
        case .accessibility1: return "Accessibility 1"
        case .accessibility2: return "Accessibility 2"
        case .accessibility3: return "Accessibility 3"
        case .accessibility4: return "Accessibility 4"
        case .accessibility5: return "Accessibility 5"
        @unknown default: return "Unknown"
        }
    }
}

#Preview {
    NavigationView {
        AccessibilityDemo()
    }
}
