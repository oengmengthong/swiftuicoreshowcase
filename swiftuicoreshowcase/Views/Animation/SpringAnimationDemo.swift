//
//  SpringAnimationDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct SpringAnimationDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Basic Spring").tag(0)
                    Text("Spring Types").tag(1)
                    Text("Interactive").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    BasicSpringDemo()
                case 1:
                    SpringTypesDemo()
                case 2:
                    InteractiveSpringDemo()
                default:
                    BasicSpringDemo()
                }
            }
        }
        .navigationTitle("Spring Animation Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BasicSpringDemo: View {
    @State private var isAnimated = false
    @State private var response: Double = 0.5
    @State private var dampingFraction: Double = 0.8
    @State private var blendDuration: Double = 0.25
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Spring Parameters")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Response: \(response, specifier: "%.2f")")
                        Slider(value: $response, in: 0.1...2.0)
                        Text("Controls how quickly the animation responds")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Damping: \(dampingFraction, specifier: "%.2f")")
                        Slider(value: $dampingFraction, in: 0.1...1.0)
                        Text("Controls how much the animation oscillates")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Blend Duration: \(blendDuration, specifier: "%.2f")")
                        Slider(value: $blendDuration, in: 0.0...1.0)
                        Text("Smooths the beginning of the animation")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Animate") {
                        isAnimated.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Animation Preview
                VStack(spacing: 20) {
                    Text("Animation Preview")
                        .font(.headline)
                    
                    VStack(spacing: 40) {
                        // Position Animation
                        HStack {
                            Text("Position:")
                                .font(.subheadline)
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.blue)
                                .frame(width: 60, height: 60)
                                .offset(x: isAnimated ? 100 : -100)
                                .animation(.spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration), value: isAnimated)
                        }
                        
                        // Scale Animation
                        HStack {
                            Text("Scale:")
                                .font(.subheadline)
                            Spacer()
                            
                            Circle()
                                .fill(.green)
                                .frame(width: 60, height: 60)
                                .scaleEffect(isAnimated ? 1.5 : 0.5)
                                .animation(.spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration), value: isAnimated)
                        }
                        
                        // Rotation Animation
                        HStack {
                            Text("Rotation:")
                                .font(.subheadline)
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.purple)
                                .frame(width: 60, height: 60)
                                .rotationEffect(.degrees(isAnimated ? 180 : 0))
                                .animation(.spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration), value: isAnimated)
                        }
                        
                        // Opacity Animation
                        HStack {
                            Text("Opacity:")
                                .font(.subheadline)
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.orange)
                                .frame(width: 60, height: 60)
                                .opacity(isAnimated ? 1.0 : 0.3)
                                .animation(.spring(response: response, dampingFraction: dampingFraction, blendDuration: blendDuration), value: isAnimated)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct SpringTypesDemo: View {
    @State private var isAnimated = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Button("Animate All") {
                    isAnimated.toggle()
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                VStack(spacing: 30) {
                    SpringDemoRow(
                        title: "Default Spring",
                        animation: .spring(),
                        isAnimated: isAnimated
                    )
                    
                    SpringDemoRow(
                        title: "Bouncy Spring",
                        animation: .spring(response: 0.6, dampingFraction: 0.6),
                        isAnimated: isAnimated
                    )
                    
                    SpringDemoRow(
                        title: "Smooth Spring",
                        animation: .spring(response: 0.8, dampingFraction: 1.0),
                        isAnimated: isAnimated
                    )
                    
                    SpringDemoRow(
                        title: "Quick Spring",
                        animation: .spring(response: 0.3, dampingFraction: 0.8),
                        isAnimated: isAnimated
                    )
                    
                    SpringDemoRow(
                        title: "Slow Spring",
                        animation: .spring(response: 1.5, dampingFraction: 0.7),
                        isAnimated: isAnimated
                    )
                    
                    SpringDemoRow(
                        title: "Oscillating Spring",
                        animation: .spring(response: 0.5, dampingFraction: 0.3),
                        isAnimated: isAnimated
                    )
                }
                .padding()
            }
        }
    }
}

struct SpringDemoRow: View {
    let title: String
    let animation: Animation
    let isAnimated: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            HStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 40, height: 40)
                    .offset(x: isAnimated ? 200 : 0)
                    .animation(animation, value: isAnimated)
                
                Spacer()
            }
            .frame(height: 40)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct InteractiveSpringDemo: View {
    @State private var dragOffset = CGSize.zero
    @State private var tapScale: CGFloat = 1.0
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Drag Spring
                VStack(spacing: 15) {
                    Text("Drag with Spring Return")
                        .font(.headline)
                    
                    Text("Drag the circle around")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 200)
                        
                        Circle()
                            .fill(.blue)
                            .frame(width: 60, height: 60)
                            .offset(dragOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                            dragOffset = .zero
                                        }
                                    }
                            )
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Tap Spring
                VStack(spacing: 15) {
                    Text("Tap to Scale")
                        .font(.headline)
                    
                    Text("Tap the square to see spring scaling")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.green)
                        .frame(width: 100, height: 100)
                        .scaleEffect(tapScale)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                                tapScale = 1.3
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                    tapScale = 1.0
                                }
                            }
                        }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Rotation Spring
                VStack(spacing: 15) {
                    Text("Rotation with Spring")
                        .font(.headline)
                    
                    Text("Tap to rotate")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.purple)
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(rotationAngle))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                                rotationAngle += 90
                            }
                        }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Combined Spring Effects
                VStack(spacing: 15) {
                    Text("Combined Spring Effects")
                        .font(.headline)
                    
                    Text("Long press for combined animation")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.pink, .orange]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 100, height: 100)
                        .scaleEffect(tapScale)
                        .rotationEffect(.degrees(rotationAngle))
                        .offset(dragOffset)
                        .onLongPressGesture {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.5)) {
                                tapScale = 1.5
                                rotationAngle += 180
                                dragOffset = CGSize(width: 50, height: -50)
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                                    tapScale = 1.0
                                    rotationAngle = 0
                                    dragOffset = .zero
                                }
                            }
                        }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}
