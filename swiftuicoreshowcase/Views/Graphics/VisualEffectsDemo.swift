//
//  VisualEffectsDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct VisualEffectsDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Blur & Shadow").tag(0)
                    Text("Opacity & Blend").tag(1)
                    Text("Materials").tag(2)
                    Text("Interactive").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    BlurShadowDemo()
                case 1:
                    OpacityBlendDemo()
                case 2:
                    MaterialsDemo()
                case 3:
                    InteractiveEffectsDemo()
                default:
                    BlurShadowDemo()
                }
            }
        }
        .navigationTitle("Visual Effects Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BlurShadowDemo: View {
    @State private var blurRadius: CGFloat = 3.0
    @State private var shadowRadius: CGFloat = 5.0
    @State private var shadowX: CGFloat = 0.0
    @State private var shadowY: CGFloat = 2.0
    @State private var shadowOpacity: Double = 0.3
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Blur Radius: \(blurRadius, specifier: "%.1f")")
                        Slider(value: $blurRadius, in: 0...20)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Shadow Radius: \(shadowRadius, specifier: "%.1f")")
                        Slider(value: $shadowRadius, in: 0...20)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Shadow X: \(shadowX, specifier: "%.1f")")
                        Slider(value: $shadowX, in: -10...10)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Shadow Y: \(shadowY, specifier: "%.1f")")
                        Slider(value: $shadowY, in: -10...10)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Shadow Opacity: \(shadowOpacity, specifier: "%.2f")")
                        Slider(value: $shadowOpacity, in: 0...1)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Blur Examples
                VStack(spacing: 20) {
                    Text("Blur Effects")
                        .font(.headline)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("No Blur")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.yellow)
                        }
                        
                        VStack {
                            Text("Blur: \(blurRadius, specifier: "%.1f")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.yellow)
                                .blur(radius: blurRadius)
                        }
                        
                        VStack {
                            Text("Background Blur")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 80, height: 80)
                                    .blur(radius: blurRadius)
                                
                                Text("Text")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Shadow Examples
                VStack(spacing: 20) {
                    Text("Shadow Effects")
                        .font(.headline)
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 30) {
                            VStack {
                                Text("Drop Shadow")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.blue)
                                    .frame(width: 60, height: 60)
                                    .shadow(
                                        color: .black.opacity(shadowOpacity),
                                        radius: shadowRadius,
                                        x: shadowX,
                                        y: shadowY
                                    )
                            }
                            
                            VStack {
                                Text("Colored Shadow")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.green)
                                    .frame(width: 60, height: 60)
                                    .shadow(
                                        color: .green.opacity(shadowOpacity),
                                        radius: shadowRadius,
                                        x: shadowX,
                                        y: shadowY
                                    )
                            }
                            
                            VStack {
                                Text("Multiple Shadows")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.orange)
                                    .frame(width: 60, height: 60)
                                    .shadow(
                                        color: .orange.opacity(shadowOpacity),
                                        radius: shadowRadius,
                                        x: shadowX,
                                        y: shadowY
                                    )
                                    .shadow(
                                        color: .red.opacity(shadowOpacity * 0.5),
                                        radius: shadowRadius * 1.5,
                                        x: shadowX * 2,
                                        y: shadowY * 2
                                    )
                            }
                        }
                        
                        // Text with shadow
                        VStack {
                            Text("Text Shadow")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text("Shadow Text")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(
                                    color: .black.opacity(shadowOpacity),
                                    radius: shadowRadius,
                                    x: shadowX,
                                    y: shadowY
                                )
                                .padding()
                                .background(Color.purple.opacity(0.3))
                                .cornerRadius(12)
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

struct OpacityBlendDemo: View {
    @State private var opacity: Double = 0.8
    @State private var selectedBlendMode = 0
    
    let blendModes: [(String, BlendMode)] = [
        ("Normal", .normal),
        ("Multiply", .multiply),
        ("Screen", .screen),
        ("Overlay", .overlay),
        ("Darken", .darken),
        ("Lighten", .lighten),
        ("Color Dodge", .colorDodge),
        ("Color Burn", .colorBurn),
        ("Soft Light", .softLight),
        ("Hard Light", .hardLight),
        ("Difference", .difference),
        ("Exclusion", .exclusion)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Opacity: \(opacity, specifier: "%.2f")")
                        Slider(value: $opacity, in: 0...1)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Blend Mode: \(blendModes[selectedBlendMode].0)")
                        Picker("Blend Mode", selection: $selectedBlendMode) {
                            ForEach(0..<blendModes.count, id: \.self) { index in
                                Text(blendModes[index].0).tag(index)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Opacity Examples
                VStack(spacing: 20) {
                    Text("Opacity Effects")
                        .font(.headline)
                    
                    HStack(spacing: 20) {
                        ForEach([1.0, 0.8, 0.5, 0.2], id: \.self) { opacityValue in
                            VStack {
                                Text("\(opacityValue, specifier: "%.1f")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 50, height: 50)
                                    .opacity(opacityValue)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Blend Mode Examples
                VStack(spacing: 20) {
                    Text("Blend Mode: \(blendModes[selectedBlendMode].0)")
                        .font(.headline)
                    
                    ZStack {
                        // Background
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.red, .yellow]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(height: 200)
                        
                        // Overlapping circles with blend mode
                        HStack(spacing: -30) {
                            Circle()
                                .fill(.blue)
                                .frame(width: 80, height: 80)
                                .opacity(opacity)
                                .blendMode(blendModes[selectedBlendMode].1)
                            
                            Circle()
                                .fill(.green)
                                .frame(width: 80, height: 80)
                                .opacity(opacity)
                                .blendMode(blendModes[selectedBlendMode].1)
                            
                            Circle()
                                .fill(.purple)
                                .frame(width: 80, height: 80)
                                .opacity(opacity)
                                .blendMode(blendModes[selectedBlendMode].1)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Blend Mode Grid
                VStack(spacing: 20) {
                    Text("All Blend Modes")
                        .font(.headline)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(0..<blendModes.count, id: \.self) { index in
                            BlendModeCard(
                                title: blendModes[index].0,
                                blendMode: blendModes[index].1
                            )
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

struct BlendModeCard: View {
    let title: String
    let blendMode: BlendMode
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.red, .blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 60)
                
                Circle()
                    .fill(.yellow)
                    .frame(width: 40, height: 40)
                    .blendMode(blendMode)
            }
        }
        .padding(8)
        .background(Color.white.opacity(0.1))
        .cornerRadius(8)
    }
}

struct MaterialsDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Material Examples
                VStack(spacing: 20) {
                    Text("Material Effects")
                        .font(.headline)
                    
                    ZStack {
                        // Background image simulation
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .blue.opacity(0.8),
                                .purple.opacity(0.8),
                                .pink.opacity(0.8)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 300)
                        .overlay(
                            VStack {
                                ForEach(0..<5, id: \.self) { _ in
                                    HStack {
                                        ForEach(0..<5, id: \.self) { _ in
                                            Circle()
                                                .fill(.white.opacity(0.3))
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                            }
                        )
                        
                        // Material overlays
                        VStack(spacing: 20) {
                            MaterialCard(
                                title: "Ultra Thin",
                                material: .ultraThinMaterial
                            )
                            
                            MaterialCard(
                                title: "Thin",
                                material: .thinMaterial
                            )
                            
                            MaterialCard(
                                title: "Regular",
                                material: .regularMaterial
                            )
                            
                            MaterialCard(
                                title: "Thick",
                                material: .thickMaterial
                            )
                            
                            MaterialCard(
                                title: "Ultra Thick",
                                material: .ultraThickMaterial
                            )
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Hierarchical Materials
                VStack(spacing: 20) {
                    Text("Hierarchical Materials")
                        .font(.headline)
                    
                    ZStack {
                        // Colorful background
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.orange, .red, .pink]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(height: 200)
                        
                        VStack(spacing: 15) {
                            Text("Primary Material")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                            
                            Text("Secondary Material")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding()
                                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8))
                            
                            Text("Tertiary Material")
                                .font(.caption)
                                .foregroundColor(.primary.opacity(0.6))
                                .padding()
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 6))
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

struct MaterialCard: View {
    let title: String
    let material: Material
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primary)
            .padding()
            .background(material, in: RoundedRectangle(cornerRadius: 12))
    }
}

struct InteractiveEffectsDemo: View {
    @State private var isPressed = false
    @State private var dragOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Interactive Press Effect
                VStack(spacing: 20) {
                    Text("Interactive Press Effect")
                        .font(.headline)
                    
                    Button(action: {}) {
                        Text("Press Me")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(isPressed ? .blue.opacity(0.8) : .blue)
                                    .shadow(
                                        color: isPressed ? .blue.opacity(0.3) : .blue.opacity(0.6),
                                        radius: isPressed ? 5 : 10,
                                        x: 0,
                                        y: isPressed ? 2 : 5
                                    )
                            )
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { pressing in
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = pressing
                        }
                    } perform: {}
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Drag with Trail Effect
                VStack(spacing: 20) {
                    Text("Drag with Trail Effect")
                        .font(.headline)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 200)
                        
                        // Trail effect
                        ForEach(0..<5, id: \.self) { index in
                            Circle()
                                .fill(.purple.opacity(0.3 - Double(index) * 0.05))
                                .frame(width: 40 - CGFloat(index) * 5, height: 40 - CGFloat(index) * 5)
                                .offset(
                                    x: dragOffset.width * (0.8 - Double(index) * 0.2),
                                    y: dragOffset.height * (0.8 - Double(index) * 0.2)
                                )
                                .animation(.easeOut(duration: 0.2 + Double(index) * 0.1), value: dragOffset)
                        }
                        
                        // Main circle
                        Circle()
                            .fill(.purple)
                            .frame(width: 40, height: 40)
                            .offset(dragOffset)
                            .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            dragOffset = .zero
                                        }
                                    }
                            )
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Scaling with Glow Effect
                VStack(spacing: 20) {
                    Text("Scaling with Glow Effect")
                        .font(.headline)
                    
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [.yellow, .orange]),
                                center: .center,
                                startRadius: 5,
                                endRadius: 50
                            )
                        )
                        .frame(width: 80, height: 80)
                        .scaleEffect(scale)
                        .shadow(color: .yellow.opacity(0.6), radius: scale * 20, x: 0, y: 0)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                scale = 1.5
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    scale = 1.0
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
