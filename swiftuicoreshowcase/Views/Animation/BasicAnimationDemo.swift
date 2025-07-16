//
//  BasicAnimationDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct BasicAnimationDemo: View {
    @State private var isAnimated = false
    @State private var rotationAngle: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    @State private var offset: CGSize = .zero
    @State private var selectedTiming: TimingCurve = .easeInOut
    @State private var animationDuration: Double = 1.0
    
    enum TimingCurve: String, CaseIterable {
        case easeInOut = "Ease In Out"
        case easeIn = "Ease In"
        case easeOut = "Ease Out"
        case linear = "Linear"
        case spring = "Spring"
        
        var animation: Animation {
            switch self {
            case .easeInOut:
                return .easeInOut(duration: 1.0)
            case .easeIn:
                return .easeIn(duration: 1.0)
            case .easeOut:
                return .easeOut(duration: 1.0)
            case .linear:
                return .linear(duration: 1.0)
            case .spring:
                return .spring(response: 0.6, dampingFraction: 0.8)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("Basic Animations")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("withAnimation, implicit animations, and timing curves")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Animation Controls
                VStack(spacing: 20) {
                    Text("Animation Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Picker("Timing Curve", selection: $selectedTiming) {
                            ForEach(TimingCurve.allCases, id: \.self) { curve in
                                Text(curve.rawValue).tag(curve)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        HStack {
                            Text("Duration:")
                            Slider(value: $animationDuration, in: 0.1...3.0)
                            Text("\(animationDuration, specifier: "%.1f")s")
                        }
                        
                        Button("Animate All") {
                            withAnimation(createAnimation()) {
                                isAnimated.toggle()
                                rotationAngle = isAnimated ? 180 : 0
                                scale = isAnimated ? 1.5 : 1.0
                                opacity = isAnimated ? 0.5 : 1.0
                                offset = isAnimated ? CGSize(width: 50, height: -50) : .zero
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.headline)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Individual Animation Demos
                VStack(spacing: 20) {
                    Text("Individual Animations")
                        .font(.headline)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        // Rotation Animation
                        VStack(spacing: 12) {
                            Text("Rotation")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.blue)
                                .frame(width: 60, height: 60)
                                .rotationEffect(.degrees(rotationAngle))
                                .animation(createAnimation(), value: rotationAngle)
                            
                            Button("Rotate") {
                                withAnimation(createAnimation()) {
                                    rotationAngle += 90
                                }
                            }
                            .buttonStyle(.bordered)
                            .font(.caption)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                        
                        // Scale Animation
                        VStack(spacing: 12) {
                            Text("Scale")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Circle()
                                .fill(Color.green)
                                .frame(width: 60, height: 60)
                                .scaleEffect(scale)
                                .animation(createAnimation(), value: scale)
                            
                            Button("Scale") {
                                withAnimation(createAnimation()) {
                                    scale = scale == 1.0 ? 1.5 : 1.0
                                }
                            }
                            .buttonStyle(.bordered)
                            .font(.caption)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                        
                        // Opacity Animation
                        VStack(spacing: 12) {
                            Text("Opacity")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Capsule()
                                .fill(Color.purple)
                                .frame(width: 80, height: 40)
                                .opacity(opacity)
                                .animation(createAnimation(), value: opacity)
                            
                            Button("Fade") {
                                withAnimation(createAnimation()) {
                                    opacity = opacity == 1.0 ? 0.3 : 1.0
                                }
                            }
                            .buttonStyle(.bordered)
                            .font(.caption)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                        
                        // Offset Animation
                        VStack(spacing: 12) {
                            Text("Offset")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 100, height: 80)
                                
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 30, height: 30)
                                    .offset(offset)
                                    .animation(createAnimation(), value: offset)
                            }
                            
                            Button("Move") {
                                withAnimation(createAnimation()) {
                                    offset = offset == .zero ? CGSize(width: 20, height: -20) : .zero
                                }
                            }
                            .buttonStyle(.bordered)
                            .font(.caption)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Combined Animation Demo
                VStack(spacing: 20) {
                    Text("Combined Animation")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [.pink, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(rotationAngle))
                            .scaleEffect(scale)
                            .opacity(opacity)
                            .offset(offset)
                            .animation(createAnimation(), value: isAnimated)
                        
                        Text("This shape combines all animation types")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Animation State Display
                VStack(spacing: 20) {
                    Text("Animation Values")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Group {
                            Text("Rotation: \(rotationAngle, specifier: "%.0f")°")
                            Text("Scale: \(scale, specifier: "%.2f")x")
                            Text("Opacity: \(opacity, specifier: "%.2f")")
                            Text("Offset: (\(offset.width, specifier: "%.0f"), \(offset.height, specifier: "%.0f"))")
                            Text("Timing: \(selectedTiming.rawValue)")
                            Text("Duration: \(animationDuration, specifier: "%.1f")s")
                        }
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Reset Button
                VStack(spacing: 20) {
                    Text("Reset Animations")
                        .font(.headline)
                    
                    Button("Reset All") {
                        withAnimation(createAnimation()) {
                            isAnimated = false
                            rotationAngle = 0
                            scale = 1.0
                            opacity = 1.0
                            offset = .zero
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Animation Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Animation Timing Curves")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        TimingInfoRow(curve: "Ease In Out", description: "Slow start and end, fast middle")
                        TimingInfoRow(curve: "Ease In", description: "Slow start, accelerates")
                        TimingInfoRow(curve: "Ease Out", description: "Fast start, decelerates")
                        TimingInfoRow(curve: "Linear", description: "Constant speed throughout")
                        TimingInfoRow(curve: "Spring", description: "Physics-based spring animation")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Basic Animations")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
    
    private func createAnimation() -> Animation {
        switch selectedTiming {
        case .easeInOut:
            return .easeInOut(duration: animationDuration)
        case .easeIn:
            return .easeIn(duration: animationDuration)
        case .easeOut:
            return .easeOut(duration: animationDuration)
        case .linear:
            return .linear(duration: animationDuration)
        case .spring:
            return .spring(response: 0.6, dampingFraction: 0.8)
        }
    }
}

struct TimingInfoRow: View {
    let curve: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(curve)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 100, alignment: .leading)
            Text(description)
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        BasicAnimationDemo()
    }
}
