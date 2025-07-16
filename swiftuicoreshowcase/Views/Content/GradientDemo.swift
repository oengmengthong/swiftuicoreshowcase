//
//  GradientDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct GradientDemo: View {
    @State private var selectedGradientType = 0
    @State private var startPoint: UnitPoint = .topLeading
    @State private var endPoint: UnitPoint = .bottomTrailing
    @State private var centerPoint: UnitPoint = .center
    @State private var radiusValue: CGFloat = 100
    @State private var animationProgress: CGFloat = 0
    
    let gradientTypes = ["Linear", "Radial", "Angular", "Animated"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // Gradient Type Selector
                gradientTypeSelector
                
                // Linear Gradients
                linearGradientSection
                
                // Radial Gradients
                radialGradientSection
                
                // Angular Gradients
                angularGradientSection
                
                // Animated Gradients
                animatedGradientSection
                
                // Gradient Applications
                gradientApplicationsSection
            }
            .padding()
        }
        .navigationTitle("Gradient Demo")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startAnimation()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Gradients & Colors")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Linear, radial, and angular gradients with color manipulation in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var gradientTypeSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Gradient Types")
                .font(.title2)
                .fontWeight(.semibold)
            
            Picker("Gradient Type", selection: $selectedGradientType) {
                ForEach(0..<gradientTypes.count, id: \.self) { index in
                    Text(gradientTypes[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var linearGradientSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Linear Gradients")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Basic Linear Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: [.red, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(height: 80)
                    Text("Red to Blue")
                        .font(.caption)
                }
                
                // Multi-color Linear Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: [.red, .yellow, .green, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 80)
                    Text("Rainbow")
                        .font(.caption)
                }
                
                // Vertical Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: [.purple, .pink],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(height: 80)
                    Text("Vertical")
                        .font(.caption)
                }
                
                // Diagonal Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: [.orange, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 80)
                    Text("Diagonal")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var radialGradientSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Radial Gradients")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Basic Radial Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(RadialGradient(
                            colors: [.yellow, .orange, .red],
                            center: .center,
                            startRadius: 0,
                            endRadius: 50
                        ))
                        .frame(height: 80)
                    Text("Sun Burst")
                        .font(.caption)
                }
                
                // Off-center Radial Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(RadialGradient(
                            colors: [.blue, .purple, .black],
                            center: .topLeading,
                            startRadius: 0,
                            endRadius: 80
                        ))
                        .frame(height: 80)
                    Text("Off-center")
                        .font(.caption)
                }
                
                // Large Radius Radial Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(RadialGradient(
                            colors: [.green, .blue],
                            center: .center,
                            startRadius: 10,
                            endRadius: 100
                        ))
                        .frame(height: 80)
                    Text("Large Radius")
                        .font(.caption)
                }
                
                // Multi-color Radial Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(RadialGradient(
                            colors: [.white, .pink, .purple, .blue],
                            center: .center,
                            startRadius: 0,
                            endRadius: 60
                        ))
                        .frame(height: 80)
                    Text("Multi-color")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var angularGradientSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Angular Gradients")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Basic Angular Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AngularGradient(
                            colors: [.red, .yellow, .green, .blue, .purple, .red],
                            center: .center
                        ))
                        .frame(height: 80)
                    Text("Color Wheel")
                        .font(.caption)
                }
                
                // Starting Angle
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AngularGradient(
                            colors: [.blue, .purple, .pink, .orange, .yellow, .blue],
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ))
                        .frame(height: 80)
                    Text("Custom Angle")
                        .font(.caption)
                }
                
                // Two Color Angular
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AngularGradient(
                            colors: [.cyan, .blue, .cyan],
                            center: .center
                        ))
                        .frame(height: 80)
                    Text("Two Color")
                        .font(.caption)
                }
                
                // Off-center Angular
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AngularGradient(
                            colors: [.green, .yellow, .orange, .red, .green],
                            center: .topLeading
                        ))
                        .frame(height: 80)
                    Text("Off-center")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var animatedGradientSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Animated Gradients")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Rotating Angular Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AngularGradient(
                            colors: [.red, .yellow, .green, .blue, .purple, .red],
                            center: .center,
                            startAngle: .degrees(animationProgress * 360),
                            endAngle: .degrees(animationProgress * 360 + 360.0)
                        ))
                        .frame(height: 80)
                    Text("Rotating")
                        .font(.caption)
                }
                
                // Pulsing Radial Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(RadialGradient(
                            colors: [.yellow, .orange, .red],
                            center: .center,
                            startRadius: 0,
                            endRadius: 30 + sin(animationProgress * 2 * Double.pi) * 20
                        ))
                        .frame(height: 80)
                    Text("Pulsing")
                        .font(.caption)
                }
                
                // Moving Linear Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: [.blue, .purple, .pink],
                            startPoint: UnitPoint(x: animationProgress, y: 0),
                            endPoint: UnitPoint(x: animationProgress + 0.5, y: 1)
                        ))
                        .frame(height: 80)
                    Text("Moving")
                        .font(.caption)
                }
                
                // Color Shifting Gradient
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: [
                                Color.red.opacity(0.5 + sin(animationProgress * Double.pi) * 0.5),
                                Color.blue.opacity(0.5 + cos(animationProgress * Double.pi) * 0.5),
                                Color.green.opacity(0.5 + sin(animationProgress * Double.pi * 2) * 0.5)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 80)
                    Text("Color Shifting")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var gradientApplicationsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Gradient Applications")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 16) {
                // Gradient Text
                Text("Gradient Text")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.red, .blue, .green],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // Gradient Button
                Button(action: {}) {
                    Text("Gradient Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.purple, .pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                }
                
                // Gradient Border
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .frame(height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [.orange, .yellow, .green],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                    )
                    .overlay(
                        Text("Gradient Border")
                            .font(.headline)
                    )
                
                // Gradient Shadow Effect
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(height: 80)
                    .shadow(color: .pink.opacity(0.3), radius: 8, x: -4, y: -4)
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 4, y: 4)
                    .overlay(
                        Text("Gradient Shadow")
                            .font(.headline)
                    )
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private func startAnimation() {
        withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
            animationProgress = 1.0
        }
    }
}

#Preview {
    NavigationView {
        GradientDemo()
    }
}
