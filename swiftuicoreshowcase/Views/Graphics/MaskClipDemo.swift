//
//  MaskClipDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct MaskClipDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Clipping").tag(0)
                    Text("Masking").tag(1)
                    Text("Advanced").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    ClippingDemo()
                case 1:
                    MaskingDemo()
                case 2:
                    AdvancedMaskClipDemo()
                default:
                    ClippingDemo()
                }
            }
        }
        .navigationTitle("Mask & Clip Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ClippingDemo: View {
    @State private var cornerRadius: CGFloat = 12
    @State private var clipToBounds = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Clipping Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Corner Radius: \(cornerRadius, specifier: "%.0f")")
                        Slider(value: $cornerRadius, in: 0...50)
                    }
                    
                    HStack {
                        Text("Clip to Bounds:")
                        Spacer()
                        Toggle("", isOn: $clipToBounds)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Basic Clipping
                VStack(spacing: 20) {
                    Text("Basic Clipping")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Circle Clip")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.red, .yellow, .green, .blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        }
                        
                        VStack {
                            Text("Rectangle Clip")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.purple, .pink, .orange]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                        }
                        
                        VStack {
                            Text("Ellipse Clip")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .green, .yellow]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(Ellipse())
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Custom Shape Clipping
                VStack(spacing: 20) {
                    Text("Custom Shape Clipping")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Triangle Clip")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.red, .orange]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(Triangle())
                        }
                        
                        VStack {
                            Text("Star Clip")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.yellow, .orange]),
                                startPoint: .center,
                                endPoint: .bottom
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(Star())
                        }
                        
                        VStack {
                            Text("Heart Clip")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.pink, .red]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(Heart())
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Overflow Clipping
                VStack(spacing: 20) {
                    Text("Overflow Clipping")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Without Clipping")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 120, height: 120)
                            }
                        }
                        
                        VStack {
                            Text("With Clipping")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 120, height: 120)
                            }
                            .clipped()
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

struct MaskingDemo: View {
    @State private var maskOpacity: Double = 0.8
    @State private var useGradientMask = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Masking Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Mask Opacity: \(maskOpacity, specifier: "%.2f")")
                        Slider(value: $maskOpacity, in: 0...1)
                    }
                    
                    HStack {
                        Text("Use Gradient Mask:")
                        Spacer()
                        Toggle("", isOn: $useGradientMask)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Basic Masking
                VStack(spacing: 20) {
                    Text("Basic Masking")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Circle Mask")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple, .pink]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .mask(
                                Circle()
                                    .fill(.black.opacity(maskOpacity))
                            )
                        }
                        
                        VStack {
                            Text("Text Mask")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.red, .yellow, .green]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 100, height: 100)
                            .mask(
                                Text("MASK")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black.opacity(maskOpacity))
                            )
                        }
                        
                        VStack {
                            Text("Symbol Mask")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.orange, .red, .purple]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(width: 100, height: 100)
                            .mask(
                                Image(systemName: "star.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.black.opacity(maskOpacity))
                            )
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Gradient Masking
                VStack(spacing: 20) {
                    Text("Gradient Masking")
                        .font(.headline)
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 30) {
                            VStack {
                                Text("Linear Gradient")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue, .green, .yellow]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .frame(width: 100, height: 100)
                                .mask(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.black, .clear]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                            }
                            
                            VStack {
                                Text("Radial Gradient")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [.purple, .pink, .red]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .frame(width: 100, height: 100)
                                .mask(
                                    RadialGradient(
                                        gradient: Gradient(colors: [.black, .clear]),
                                        center: .center,
                                        startRadius: 20,
                                        endRadius: 50
                                    )
                                )
                            }
                            
                            VStack {
                                Text("Angular Gradient")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [.orange, .yellow, .green]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .frame(width: 100, height: 100)
                                .mask(
                                    AngularGradient(
                                        gradient: Gradient(colors: [.black, .clear, .black]),
                                        center: .center,
                                        startAngle: .degrees(0),
                                        endAngle: .degrees(360)
                                    )
                                )
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Complex Masking
                VStack(spacing: 20) {
                    Text("Complex Masking")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Multiple Shapes")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple, .pink, .red]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .mask(
                                ZStack {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .offset(x: -20, y: -20)
                                    
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .offset(x: 20, y: -20)
                                    
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .offset(x: 0, y: 20)
                                }
                                .foregroundColor(.black.opacity(maskOpacity))
                            )
                        }
                        
                        VStack {
                            Text("Pattern Mask")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.green, .blue, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .mask(
                                VStack(spacing: 4) {
                                    ForEach(0..<5, id: \.self) { _ in
                                        HStack(spacing: 4) {
                                            ForEach(0..<5, id: \.self) { _ in
                                                Circle()
                                                    .frame(width: 8, height: 8)
                                            }
                                        }
                                    }
                                }
                                .foregroundColor(.black.opacity(maskOpacity))
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

struct AdvancedMaskClipDemo: View {
    @State private var animateClip = false
    @State private var animateMask = false
    @State private var clipProgress: CGFloat = 0.5
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Advanced Controls")
                        .font(.headline)
                    
                    HStack {
                        Button("Animate Clip") {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                animateClip.toggle()
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Animate Mask") {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                animateMask.toggle()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Clip Progress: \(clipProgress, specifier: "%.2f")")
                        Slider(value: $clipProgress, in: 0...1)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Animated Clipping
                VStack(spacing: 20) {
                    Text("Animated Clipping")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Reveal Animation")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .green, .yellow]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(
                                Rectangle()
                                    .size(width: animateClip ? 100 : 0, height: 100)
                            )
                            .animation(.easeInOut(duration: 2.0), value: animateClip)
                        }
                        
                        VStack {
                            Text("Morphing Shape")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.purple, .pink, .red]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(
                                RoundedRectangle(cornerRadius: animateClip ? 50 : 0)
                            )
                            .animation(.easeInOut(duration: 2.0), value: animateClip)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Animated Masking
                VStack(spacing: 20) {
                    Text("Animated Masking")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Moving Mask")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.red, .orange, .yellow]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(width: 100, height: 100)
                            .mask(
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .offset(x: animateMask ? 20 : -20, y: animateMask ? 20 : -20)
                                    .animation(.easeInOut(duration: 2.0), value: animateMask)
                            )
                        }
                        
                        VStack {
                            Text("Scaling Mask")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [.green, .blue, .purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 100, height: 100)
                            .mask(
                                Circle()
                                    .scaleEffect(animateMask ? 1.0 : 0.1)
                                    .animation(.easeInOut(duration: 2.0), value: animateMask)
                            )
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Interactive Clipping
                VStack(spacing: 20) {
                    Text("Interactive Clipping")
                        .font(.headline)
                    
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple, .pink, .red]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: 200, height: 200)
                    .clipShape(
                        Circle()
                            .size(width: clipProgress * 200, height: clipProgress * 200)
                    )
                    .animation(.easeInOut(duration: 0.3), value: clipProgress)
                    
                    Text("Adjust the slider to reveal the image")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

// MARK: - Custom Shapes
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Star: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.4
        
        for i in 0..<5 {
            let angle = Double(i) * .pi * 2 / 5 - .pi / 2
            let outerPoint = CGPoint(
                x: center.x + CoreGraphics.cos(angle) * outerRadius,
                y: center.y + CoreGraphics.sin(angle) * outerRadius
            )
            
            let innerAngle = angle + .pi / 5
            let innerPoint = CGPoint(
                x: center.x + CoreGraphics.cos(innerAngle) * innerRadius,
                y: center.y + CoreGraphics.sin(innerAngle) * innerRadius
            )
            
            if i == 0 {
                path.move(to: outerPoint)
            } else {
                path.addLine(to: outerPoint)
            }
            path.addLine(to: innerPoint)
        }
        
        path.closeSubpath()
        return path
    }
}

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.85))
        
        path.addCurve(
            to: CGPoint(x: width * 0.1, y: height * 0.35),
            control1: CGPoint(x: width * 0.5, y: height * 0.75),
            control2: CGPoint(x: width * 0.1, y: height * 0.6)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height * 0.15),
            control1: CGPoint(x: width * 0.1, y: height * 0.1),
            control2: CGPoint(x: width * 0.3, y: height * 0.15)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.9, y: height * 0.35),
            control1: CGPoint(x: width * 0.7, y: height * 0.15),
            control2: CGPoint(x: width * 0.9, y: height * 0.1)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height * 0.85),
            control1: CGPoint(x: width * 0.9, y: height * 0.6),
            control2: CGPoint(x: width * 0.5, y: height * 0.75)
        )
        
        return path
    }
}
