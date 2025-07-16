//
//  GlassEffectsDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct GlassEffectsDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Materials").tag(0)
                    Text("Blur Effects").tag(1)
                    Text("Glass Cards").tag(2)
                    Text("Advanced").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    GlassMaterialsDemo()
                case 1:
                    BlurEffectsDemo()
                case 2:
                    GlassCardsDemo()
                case 3:
                    AdvancedGlassDemo()
                default:
                    GlassMaterialsDemo()
                }
            }
        }
        .navigationTitle("Glass Effects Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GlassMaterialsDemo: View {
    @State private var materialThickness: Double = 1.0
    @State private var selectedMaterial = 0
    
    private let materials: [Material] = [
        .ultraThinMaterial,
        .thinMaterial,
        .regularMaterial,
        .thickMaterial,
        .ultraThickMaterial
    ]
    
    private let materialNames = [
        "Ultra Thin",
        "Thin",
        "Regular",
        "Thick",
        "Ultra Thick"
    ]
    
    var body: some View {
        ZStack {
            // Background with gradient
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple, .pink, .orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Controls
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Material Controls")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Picker("Material Type", selection: $selectedMaterial) {
                            ForEach(0..<materialNames.count, id: \.self) { index in
                                Text(materialNames[index]).tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Material Thickness: \(materialThickness, specifier: "%.1f")")
                                .foregroundColor(.white)
                            Slider(value: $materialThickness, in: 0.1...2.0)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Material Showcase
                    VStack(spacing: 20) {
                        Text("Material Showcase")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                            ForEach(0..<materials.count, id: \.self) { index in
                                VStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(materials[index])
                                        .frame(height: 120)
                                        .overlay(
                                            VStack {
                                                Image(systemName: "sparkles")
                                                    .font(.system(size: 30))
                                                    .foregroundColor(.primary)
                                                
                                                Text(materialNames[index])
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.primary)
                                            }
                                        )
                                        .scaleEffect(index == selectedMaterial ? 1.1 : 1.0)
                                        .animation(.easeInOut(duration: 0.2), value: selectedMaterial)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Interactive Demo
                    VStack(spacing: 20) {
                        Text("Interactive Demo")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(materials[selectedMaterial])
                                .frame(height: 200)
                                .overlay(
                                    VStack(spacing: 15) {
                                        Image(systemName: "apple.logo")
                                            .font(.system(size: 50))
                                            .foregroundColor(.primary)
                                        
                                        Text("Material Effect")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                        
                                        Text("This demonstrates the \(materialNames[selectedMaterial].lowercased()) material effect with dynamic thickness.")
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.secondary)
                                            .padding(.horizontal)
                                    }
                                )
                                .scaleEffect(materialThickness)
                                .animation(.easeInOut(duration: 0.3), value: materialThickness)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                }
                .padding()
            }
        }
    }
}

struct BlurEffectsDemo: View {
    @State private var blurRadius: CGFloat = 10
    @State private var blurOpacity: Double = 0.8
    @State private var useGaussianBlur = true
    
    var body: some View {
        ZStack {
            // Background pattern
            ZStack {
                Color.black
                
                ForEach(0..<20, id: \.self) { _ in
                    Circle()
                        .fill(Color.random)
                        .frame(width: CGFloat.random(in: 50...150))
                        .position(
                            x: CGFloat.random(in: 0...400),
                            y: CGFloat.random(in: 0...800)
                        )
                }
            }
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Controls
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Blur Controls")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Blur Radius: \(blurRadius, specifier: "%.0f")")
                                .foregroundColor(.white)
                            Slider(value: $blurRadius, in: 0...50)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Blur Opacity: \(blurOpacity, specifier: "%.2f")")
                                .foregroundColor(.white)
                            Slider(value: $blurOpacity, in: 0...1)
                        }
                        
                        HStack {
                            Text("Use Gaussian Blur:")
                                .foregroundColor(.white)
                            Spacer()
                            Toggle("", isOn: $useGaussianBlur)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Blur Types
                    VStack(spacing: 20) {
                        Text("Blur Types")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 20) {
                            VStack {
                                Text("Standard Blur")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [.red, .orange, .yellow]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 100, height: 100)
                                    .blur(radius: blurRadius * 0.5)
                            }
                            
                            VStack {
                                Text("Motion Blur")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple, .pink]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                    .frame(width: 100, height: 100)
                                    .blur(radius: blurRadius * 0.3)
                                    .scaleEffect(x: 1.2, y: 1.0)
                            }
                            
                            VStack {
                                Text("Radial Blur")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                RadialGradient(
                                    gradient: Gradient(colors: [.green, .blue, .purple]),
                                    center: .center,
                                    startRadius: 10,
                                    endRadius: 50
                                )
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .blur(radius: blurRadius * 0.4)
                            }
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Background Blur
                    VStack(spacing: 20) {
                        Text("Background Blur")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            // Background content
                            VStack(spacing: 10) {
                                ForEach(0..<3, id: \.self) { _ in
                                    HStack(spacing: 10) {
                                        ForEach(0..<4, id: \.self) { _ in
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.random)
                                                .frame(width: 60, height: 60)
                                        }
                                    }
                                }
                            }
                            .blur(radius: blurRadius)
                            .opacity(blurOpacity)
                            
                            // Foreground content
                            VStack(spacing: 15) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                
                                Text("Foreground Content")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("This content remains sharp while the background is blurred")
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.horizontal)
                            }
                            .padding()
                            .background(Material.ultraThinMaterial)
                            .cornerRadius(16)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                }
                .padding()
            }
        }
    }
}

struct GlassCardsDemo: View {
    @State private var cardScale: CGFloat = 1.0
    @State private var cardRotation: Double = 0.0
    @State private var cardOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            // Animated background
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Controls
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Glass Card Controls")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Card Scale: \(cardScale, specifier: "%.2f")")
                                .foregroundColor(.white)
                            Slider(value: $cardScale, in: 0.5...1.5)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Card Rotation: \(cardRotation, specifier: "%.0f")°")
                                .foregroundColor(.white)
                            Slider(value: $cardRotation, in: -45...45)
                        }
                        
                        Button("Reset Transform") {
                            withAnimation(.spring()) {
                                cardScale = 1.0
                                cardRotation = 0.0
                                cardOffset = .zero
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Glass Card Examples
                    VStack(spacing: 20) {
                        Text("Glass Card Examples")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                            // Card 1: Basic Glass
                            GlassCard(title: "Basic Glass", icon: "circle.fill", color: .blue)
                            
                            // Card 2: Frosted Glass
                            GlassCard(title: "Frosted Glass", icon: "snowflake", color: .cyan, material: .thickMaterial)
                            
                            // Card 3: Tinted Glass
                            GlassCard(title: "Tinted Glass", icon: "paintpalette.fill", color: .purple, tint: .purple.opacity(0.2))
                            
                            // Card 4: Gradient Glass
                            GlassCard(title: "Gradient Glass", icon: "rainbow", color: .pink, gradient: true)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Interactive Glass Card
                    VStack(spacing: 20) {
                        Text("Interactive Glass Card")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Material.ultraThinMaterial)
                                .frame(height: 200)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.white.opacity(0.6), .white.opacity(0.1)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1
                                        )
                                )
                                .overlay(
                                    VStack(spacing: 15) {
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(.red)
                                        
                                        Text("Interactive Card")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                        
                                        Text("Drag, scale, and rotate this card")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                )
                                .scaleEffect(cardScale)
                                .rotationEffect(.degrees(cardRotation))
                                .offset(cardOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            cardOffset = value.translation
                                        }
                                        .onEnded { _ in
                                            withAnimation(.spring()) {
                                                cardOffset = .zero
                                            }
                                        }
                                )
                                .animation(.spring(), value: cardScale)
                                .animation(.spring(), value: cardRotation)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                }
                .padding()
            }
        }
    }
}

struct AdvancedGlassDemo: View {
    @State private var animateGlow = false
    @State private var animateShimmer = false
    @State private var glowIntensity: Double = 0.5
    
    var body: some View {
        ZStack {
            // Dynamic background
            DynamicGlassBackground()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Controls
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Advanced Glass Controls")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack {
                            Button("Animate Glow") {
                                withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                                    animateGlow.toggle()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Button("Animate Shimmer") {
                                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                    animateShimmer.toggle()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Glow Intensity: \(glowIntensity, specifier: "%.2f")")
                                .foregroundColor(.white)
                            Slider(value: $glowIntensity, in: 0...1)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Morphing Glass
                    VStack(spacing: 20) {
                        Text("Morphing Glass Effects")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 20) {
                            MorphingGlassCard(
                                title: "Breathing",
                                icon: "lungs.fill",
                                color: .green,
                                animationType: .breathing
                            )
                            
                            MorphingGlassCard(
                                title: "Pulsing",
                                icon: "heart.fill",
                                color: .red,
                                animationType: .pulsing
                            )
                        }
                        
                        HStack(spacing: 20) {
                            MorphingGlassCard(
                                title: "Floating",
                                icon: "cloud.fill",
                                color: .blue,
                                animationType: .floating
                            )
                            
                            MorphingGlassCard(
                                title: "Rotating",
                                icon: "gear.circle.fill",
                                color: .orange,
                                animationType: .rotating
                            )
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                    
                    // Layered Glass
                    VStack(spacing: 20) {
                        Text("Layered Glass System")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            // Background layer
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Material.thickMaterial)
                                .frame(height: 180)
                                .offset(x: 10, y: 10)
                            
                            // Middle layer
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Material.regularMaterial)
                                .frame(height: 180)
                                .offset(x: 5, y: 5)
                            
                            // Front layer
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Material.ultraThinMaterial)
                                .frame(height: 180)
                                .overlay(
                                    VStack(spacing: 15) {
                                        Image(systemName: "layers.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(.primary)
                                        
                                        Text("Layered Glass")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                        
                                        Text("Multiple glass layers create depth")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.center)
                                    }
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.white.opacity(0.8), .white.opacity(0.2)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 2
                                        )
                                )
                                .shadow(
                                    color: .white.opacity(animateGlow ? glowIntensity : 0.1),
                                    radius: animateGlow ? 20 : 5
                                )
                                .animation(.easeInOut(duration: 2.0).repeatForever(), value: animateGlow)
                        }
                    }
                    .padding()
                    .background(Material.ultraThinMaterial)
                    .cornerRadius(16)
                }
                .padding()
            }
        }
    }
}

// MARK: - Supporting Views

struct GlassCard: View {
    let title: String
    let icon: String
    let color: Color
    var material: Material = .ultraThinMaterial
    var tint: Color? = nil
    var gradient: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(material)
            .frame(height: 120)
            .overlay(
                ZStack {
                    if gradient {
                        LinearGradient(
                            gradient: Gradient(colors: [color.opacity(0.3), color.opacity(0.1)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .cornerRadius(16)
                    }
                    
                    if let tint = tint {
                        tint
                            .cornerRadius(16)
                    }
                    
                    VStack(spacing: 8) {
                        Image(systemName: icon)
                            .font(.system(size: 24))
                            .foregroundColor(color)
                        
                        Text(title)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.white.opacity(0.4), .white.opacity(0.1)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
    }
}

struct MorphingGlassCard: View {
    let title: String
    let icon: String
    let color: Color
    let animationType: AnimationType
    
    @State private var animate = false
    
    enum AnimationType {
        case breathing, pulsing, floating, rotating
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Material.ultraThinMaterial)
            .frame(width: 140, height: 100)
            .overlay(
                VStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(color)
                    
                    Text(title)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.white.opacity(0.4), .white.opacity(0.1)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .modifier(AnimationModifier(animationType: animationType, animate: animate))
            .onAppear {
                withAnimation(animationFor(animationType)) {
                    animate = true
                }
            }
    }
    
    private func animationFor(_ type: AnimationType) -> Animation {
        switch type {
        case .breathing:
            return .easeInOut(duration: 2.0).repeatForever(autoreverses: true)
        case .pulsing:
            return .easeInOut(duration: 1.0).repeatForever(autoreverses: true)
        case .floating:
            return .easeInOut(duration: 3.0).repeatForever(autoreverses: true)
        case .rotating:
            return .linear(duration: 4.0).repeatForever(autoreverses: false)
        }
    }
}

struct AnimationModifier: ViewModifier {
    let animationType: MorphingGlassCard.AnimationType
    let animate: Bool
    
    func body(content: Content) -> some View {
        switch animationType {
        case .breathing:
            content
                .scaleEffect(animate ? 1.1 : 0.9)
        case .pulsing:
            content
                .scaleEffect(animate ? 1.2 : 1.0)
        case .floating:
            content
                .offset(y: animate ? -10 : 10)
        case .rotating:
            content
                .rotationEffect(.degrees(animate ? 360 : 0))
        }
    }
}

struct AnimatedGradientBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .blue.opacity(0.8),
                .purple.opacity(0.8),
                .pink.opacity(0.8),
                .orange.opacity(0.8)
            ]),
            startPoint: animateGradient ? .topLeading : .bottomTrailing,
            endPoint: animateGradient ? .bottomTrailing : .topLeading
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: true)) {
                animateGradient = true
            }
        }
    }
}

struct DynamicGlassBackground: View {
    @State private var animatePosition = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ForEach(0..<8, id: \.self) { index in
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.random.opacity(0.6),
                                Color.random.opacity(0.3),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 100
                        )
                    )
                    .frame(width: 200, height: 200)
                    .position(
                        x: animatePosition ? CGFloat.random(in: 0...400) : CGFloat.random(in: 0...400),
                        y: animatePosition ? CGFloat.random(in: 0...800) : CGFloat.random(in: 0...800)
                    )
                    .animation(
                        .easeInOut(duration: Double.random(in: 3...6))
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.5),
                        value: animatePosition
                    )
            }
        }
        .onAppear {
            animatePosition = true
        }
    }
}
