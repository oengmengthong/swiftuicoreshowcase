//
//  CanvasDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct CanvasDemo: View {
    @State private var selectedDemo = 0
    @State private var animationProgress: CGFloat = 0
    @State private var isAnimating = false
    
    let demos = ["Basic Drawing", "Animated Canvas", "Interactive"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // Demo Selector
                demoSelector
                
                // Basic Drawing Canvas
                basicDrawingSection
                
                // Animated Canvas
                animatedCanvasSection
                
                // Interactive Canvas
                interactiveCanvasSection
                
                // Canvas Capabilities
                canvasCapabilitiesSection
            }
            .padding()
        }
        .navigationTitle("Canvas Demo")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startAnimation()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Canvas & Custom Drawing")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Custom drawing with Canvas and GraphicsContext in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var demoSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Canvas Demos")
                .font(.title2)
                .fontWeight(.semibold)
            
            Picker("Demo Type", selection: $selectedDemo) {
                ForEach(0..<demos.count, id: \.self) { index in
                    Text(demos[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var basicDrawingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Basic Drawing")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Shapes Canvas
                VStack(spacing: 8) {
                    Canvas { context, size in
                        let rect = CGRect(origin: .zero, size: size)
                        
                        // Draw rectangle
                        context.fill(
                            Path(CGRect(x: 10, y: 10, width: 60, height: 40)),
                            with: .color(.blue)
                        )
                        
                        // Draw circle
                        context.fill(
                            Path(ellipseIn: CGRect(x: 80, y: 10, width: 50, height: 50)),
                            with: .color(.red)
                        )
                        
                        // Draw line
                        var path = Path()
                        path.move(to: CGPoint(x: 10, y: 70))
                        path.addLine(to: CGPoint(x: 130, y: 70))
                        context.stroke(path, with: .color(.green), lineWidth: 3)
                    }
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    Text("Basic Shapes")
                        .font(.caption)
                }
                
                // Gradient Canvas
                VStack(spacing: 8) {
                    Canvas { context, size in
                        let gradient = Gradient(colors: [.purple, .pink, .orange])
                        
                        context.fill(
                            Path(CGRect(origin: .zero, size: size)),
                            with: .linearGradient(
                                gradient,
                                startPoint: CGPoint(x: 0, y: 0),
                                endPoint: CGPoint(x: size.width, y: size.height)
                            )
                        )
                        
                        // Add some shapes on top
                        context.fill(
                            Path(ellipseIn: CGRect(x: 20, y: 20, width: 30, height: 30)),
                            with: .color(.white.opacity(0.5))
                        )
                        
                        context.fill(
                            Path(ellipseIn: CGRect(x: 80, y: 50, width: 40, height: 40)),
                            with: .color(.white.opacity(0.3))
                        )
                    }
                    .frame(height: 100)
                    .cornerRadius(8)
                    
                    Text("Gradient Background")
                        .font(.caption)
                }
                
                // Text Canvas
                VStack(spacing: 8) {
                    Canvas { context, size in
                        let rect = CGRect(origin: .zero, size: size)
                        
                        // Background
                        context.fill(Path(rect), with: .color(.blue.opacity(0.1)))
                        
                        // Text
                        context.draw(
                            Text("Hello\nCanvas")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue),
                            at: CGPoint(x: size.width/2, y: size.height/2)
                        )
                    }
                    .frame(height: 100)
                    .cornerRadius(8)
                    
                    Text("Text Drawing")
                        .font(.caption)
                }
                
                // Pattern Canvas
                VStack(spacing: 8) {
                    Canvas { context, size in
                        let spacing: CGFloat = 15
                        
                        for x in stride(from: 0, through: size.width, by: spacing) {
                            for y in stride(from: 0, through: size.height, by: spacing) {
                                let rect = CGRect(x: x, y: y, width: 8, height: 8)
                                context.fill(
                                    Path(ellipseIn: rect),
                                    with: .color(.green.opacity(0.6))
                                )
                            }
                        }
                    }
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    Text("Dot Pattern")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var animatedCanvasSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Animated Canvas")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Wave Animation
                VStack(spacing: 8) {
                    Canvas { context, size in
                        var path = Path()
                        let waveLength: CGFloat = 30
                        let amplitude: CGFloat = 20
                        let midY = size.height / 2
                        
                        path.move(to: CGPoint(x: 0, y: midY))
                        
                        for x in stride(from: 0, through: size.width, by: 2) {
                            let y = midY + sin((x + animationProgress * 100) / waveLength) * amplitude
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                        
                        context.stroke(path, with: .color(.blue), lineWidth: 3)
                    }
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    Text("Wave Animation")
                        .font(.caption)
                }
                
                // Rotating Elements
                VStack(spacing: 8) {
                    Canvas { context, size in
                        let center = CGPoint(x: size.width/2, y: size.height/2)
                        let radius: CGFloat = 30
                        
                        // Draw rotating circles
                        for i in 0..<6 {
                            let angle = (Double(i) * .pi * 2 / 6) + (animationProgress * .pi * 2)
                            let x = center.x + cos(angle) * radius
                            let y = center.y + sin(angle) * radius
                            
                            context.fill(
                                Path(ellipseIn: CGRect(x: x-5, y: y-5, width: 10, height: 10)),
                                with: .color(.red)
                            )
                        }
                        
                        // Center circle
                        context.fill(
                            Path(ellipseIn: CGRect(x: center.x-8, y: center.y-8, width: 16, height: 16)),
                            with: .color(.blue)
                        )
                    }
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    Text("Rotating Elements")
                        .font(.caption)
                }
                
                // Pulsing Effect
                VStack(spacing: 8) {
                    Canvas { context, size in
                        let center = CGPoint(x: size.width/2, y: size.height/2)
                        let baseRadius: CGFloat = 20
                        let pulseRadius = baseRadius + sin(animationProgress * .pi * 4) * 10
                        
                        // Outer pulse
                        context.fill(
                            Path(ellipseIn: CGRect(
                                x: center.x - pulseRadius,
                                y: center.y - pulseRadius,
                                width: pulseRadius * 2,
                                height: pulseRadius * 2
                            )),
                            with: .color(.purple.opacity(0.3))
                        )
                        
                        // Inner circle
                        context.fill(
                            Path(ellipseIn: CGRect(
                                x: center.x - baseRadius/2,
                                y: center.y - baseRadius/2,
                                width: baseRadius,
                                height: baseRadius
                            )),
                            with: .color(.purple)
                        )
                    }
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    Text("Pulsing Effect")
                        .font(.caption)
                }
                
                // Particle System
                VStack(spacing: 8) {
                    Canvas { context, size in
                        let particleCount = 20
                        
                        for i in 0..<particleCount {
                            let progress = (animationProgress + Double(i) * 0.1).truncatingRemainder(dividingBy: 1.0)
                            let x = CGFloat(progress) * size.width
                            let y = size.height/2 + sin(progress * .pi * 4) * 20
                            let opacity = 1.0 - progress
                            
                            context.fill(
                                Path(ellipseIn: CGRect(x: x-2, y: y-2, width: 4, height: 4)),
                                with: .color(.orange.opacity(opacity))
                            )
                        }
                    }
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    Text("Particle System")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var interactiveCanvasSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Interactive Canvas")
                .font(.title2)
                .fontWeight(.semibold)
            
            InteractiveDrawingCanvas()
                .frame(height: 200)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Text("Draw on the canvas above with your finger or mouse")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var canvasCapabilitiesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Canvas Capabilities")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Drawing Operations:")
                    .font(.headline)
                
                Text("• Fill and stroke paths")
                Text("• Draw text with custom fonts")
                Text("• Apply gradients and patterns")
                Text("• Blend modes and opacity")
                Text("• Transformations (scale, rotate, translate)")
                Text("• Clipping and masking")
                Text("• Real-time animation support")
                Text("• Performance optimized for smooth rendering")
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private func startAnimation() {
        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
            animationProgress = 1.0
        }
    }
}

// MARK: - Interactive Drawing Canvas

struct InteractiveDrawingCanvas: View {
    @State private var currentPath = Path()
    @State private var paths: [Path] = []
    
    var body: some View {
        Canvas { context, size in
            // Draw completed paths
            for path in paths {
                context.stroke(path, with: .color(.blue), lineWidth: 2)
            }
            
            // Draw current path
            context.stroke(currentPath, with: .color(.blue), lineWidth: 2)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if currentPath.isEmpty {
                        currentPath.move(to: value.location)
                    } else {
                        currentPath.addLine(to: value.location)
                    }
                }
                .onEnded { _ in
                    paths.append(currentPath)
                    currentPath = Path()
                }
        )
        .onTapGesture(count: 2) {
            // Double tap to clear
            paths.removeAll()
            currentPath = Path()
        }
    }
}

#Preview {
    NavigationView {
        CanvasDemo()
    }
}
