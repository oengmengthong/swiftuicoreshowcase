//
//  ShapeDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ShapeDemo: View {
    @State private var selectedShape = 0
    @State private var cornerRadius: CGFloat = 10
    @State private var strokeWidth: CGFloat = 2
    @State private var showFill = true
    @State private var showStroke = true
    @State private var animationProgress: CGFloat = 0
    
    let shapes = ["Built-in Shapes", "Custom Paths", "Animated Shapes"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // Shape Type Selector
                shapeTypeSelector
                
                // Built-in Shapes
                builtInShapesSection
                
                // Custom Paths
                customPathsSection
                
                // Shape Styling
                shapeStylingSection
                
                // Animated Shapes
                animatedShapesSection
            }
            .padding()
        }
        .navigationTitle("Shape Demo")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startAnimation()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Shapes & Custom Paths")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Built-in shapes, custom paths, and drawing capabilities in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var shapeTypeSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Shape Categories")
                .font(.title2)
                .fontWeight(.semibold)
            
            Picker("Shape Type", selection: $selectedShape) {
                ForEach(0..<shapes.count, id: \.self) { index in
                    Text(shapes[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var builtInShapesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Built-in Shapes")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                // Rectangle
                VStack(spacing: 8) {
                    Rectangle()
                        .fill(Color.blue.opacity(0.6))
                        .frame(width: 80, height: 60)
                    Text("Rectangle")
                        .font(.caption)
                }
                
                // RoundedRectangle
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.green.opacity(0.6))
                        .frame(width: 80, height: 60)
                    Text("RoundedRectangle")
                        .font(.caption)
                }
                
                // Circle
                VStack(spacing: 8) {
                    Circle()
                        .fill(Color.red.opacity(0.6))
                        .frame(width: 80, height: 60)
                    Text("Circle")
                        .font(.caption)
                }
                
                // Ellipse
                VStack(spacing: 8) {
                    Ellipse()
                        .fill(Color.orange.opacity(0.6))
                        .frame(width: 80, height: 60)
                    Text("Ellipse")
                        .font(.caption)
                }
                
                // Capsule
                VStack(spacing: 8) {
                    Capsule()
                        .fill(Color.purple.opacity(0.6))
                        .frame(width: 80, height: 60)
                    Text("Capsule")
                        .font(.caption)
                }
                
                // Capsule (Horizontal)
                VStack(spacing: 8) {
                    Capsule()
                        .fill(Color.pink.opacity(0.6))
                        .frame(width: 80, height: 40)
                    Text("Capsule (H)")
                        .font(.caption)
                }
            }
            
            // Corner Radius Control
            VStack(alignment: .leading, spacing: 8) {
                Text("Corner Radius: \(cornerRadius, specifier: "%.0f")")
                    .font(.caption)
                Slider(value: $cornerRadius, in: 0...30)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var customPathsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Custom Paths")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Triangle
                VStack(spacing: 8) {
                    TriangleShape()
                        .fill(Color.blue.opacity(0.6))
                        .frame(width: 80, height: 80)
                    Text("Triangle")
                        .font(.caption)
                }
                
                // Diamond
                VStack(spacing: 8) {
                    DiamondShape()
                        .fill(Color.green.opacity(0.6))
                        .frame(width: 80, height: 80)
                    Text("Diamond")
                        .font(.caption)
                }
                
                // Star
                VStack(spacing: 8) {
                    StarShape()
                        .fill(Color.yellow.opacity(0.8))
                        .frame(width: 80, height: 80)
                    Text("Star")
                        .font(.caption)
                }
                
                // Heart
                VStack(spacing: 8) {
                    HeartShape()
                        .fill(Color.red.opacity(0.6))
                        .frame(width: 80, height: 80)
                    Text("Heart")
                        .font(.caption)
                }
                
                // Hexagon
                VStack(spacing: 8) {
                    HexagonShape()
                        .fill(Color.purple.opacity(0.6))
                        .frame(width: 80, height: 80)
                    Text("Hexagon")
                        .font(.caption)
                }
                
                // Arrow
                VStack(spacing: 8) {
                    ArrowShape()
                        .fill(Color.orange.opacity(0.6))
                        .frame(width: 80, height: 80)
                    Text("Arrow")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var shapeStylingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Shape Styling")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Controls
            VStack(alignment: .leading, spacing: 8) {
                Toggle("Fill", isOn: $showFill)
                Toggle("Stroke", isOn: $showStroke)
                
                Text("Stroke Width: \(strokeWidth, specifier: "%.0f")")
                    .font(.caption)
                Slider(value: $strokeWidth, in: 1...10)
            }
            
            // Styled Shapes
            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    Circle()
                        .fill(showFill ? Color.blue.opacity(0.6) : Color.clear)
                        .stroke(showStroke ? Color.blue : Color.clear, lineWidth: strokeWidth)
                        .frame(width: 80, height: 80)
                    Text("Circle")
                        .font(.caption)
                }
                
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(showFill ? Color.green.opacity(0.6) : Color.clear)
                        .stroke(showStroke ? Color.green : Color.clear, lineWidth: strokeWidth)
                        .frame(width: 80, height: 80)
                    Text("Rectangle")
                        .font(.caption)
                }
                
                VStack(spacing: 8) {
                    StarShape()
                        .fill(showFill ? Color.yellow.opacity(0.8) : Color.clear)
                        .stroke(showStroke ? Color.orange : Color.clear, lineWidth: strokeWidth)
                        .frame(width: 80, height: 80)
                    Text("Star")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var animatedShapesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Animated Shapes")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    Circle()
                        .trim(from: 0, to: animationProgress)
                        .stroke(Color.blue, lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(-90))
                    Text("Loading Circle")
                        .font(.caption)
                }
                
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.green.opacity(0.6))
                        .frame(width: 80, height: 80)
                        .scaleEffect(1.0 + sin(animationProgress * 2 * .pi) * 0.2)
                    Text("Pulsing Rectangle")
                        .font(.caption)
                }
                
                VStack(spacing: 8) {
                    StarShape()
                        .fill(Color.yellow.opacity(0.8))
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(animationProgress * 360))
                    Text("Spinning Star")
                        .font(.caption)
                }
            }
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

// MARK: - Custom Shapes

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.4
        
        for i in 0..<5 {
            let angle = Double(i) * .pi * 2 / 5 - .pi / 2
            let nextAngle = Double(i + 1) * .pi * 2 / 5 - .pi / 2
            let midAngle = (angle + nextAngle) / 2
            
            let outerPoint = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
            let innerPoint = CGPoint(
                x: center.x + cos(midAngle) * innerRadius,
                y: center.y + sin(midAngle) * innerRadius
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

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.85))
        path.addCurve(to: CGPoint(x: width * 0.1, y: height * 0.4),
                     control1: CGPoint(x: width * 0.5, y: height * 0.7),
                     control2: CGPoint(x: width * 0.1, y: height * 0.6))
        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.15),
                     control1: CGPoint(x: width * 0.1, y: height * 0.15),
                     control2: CGPoint(x: width * 0.3, y: height * 0.15))
        path.addCurve(to: CGPoint(x: width * 0.9, y: height * 0.4),
                     control1: CGPoint(x: width * 0.7, y: height * 0.15),
                     control2: CGPoint(x: width * 0.9, y: height * 0.15))
        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.85),
                     control1: CGPoint(x: width * 0.9, y: height * 0.6),
                     control2: CGPoint(x: width * 0.5, y: height * 0.7))
        
        return path
    }
}

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        for i in 0..<6 {
            let angle = Double(i) * .pi / 3
            let point = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.1, y: height * 0.4))
        path.addLine(to: CGPoint(x: width * 0.6, y: height * 0.4))
        path.addLine(to: CGPoint(x: width * 0.6, y: height * 0.2))
        path.addLine(to: CGPoint(x: width * 0.9, y: height * 0.5))
        path.addLine(to: CGPoint(x: width * 0.6, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.6, y: height * 0.6))
        path.addLine(to: CGPoint(x: width * 0.1, y: height * 0.6))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    NavigationView {
        ShapeDemo()
    }
}
