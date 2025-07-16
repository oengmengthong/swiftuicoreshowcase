//
//  PlaceholderViews.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

// MARK: - Layout Demos
struct LazyStackDemo: View {
    var body: some View {
        PlaceholderView(title: "Lazy Stack Demo", description: "LazyVStack, LazyHStack for performance with large datasets")
    }
}

struct ScrollViewDemo: View {
    var body: some View {
        PlaceholderView(title: "ScrollView Demo", description: "Scrollable content and structured data presentation")
    }
}

struct CustomLayoutDemo: View {
    var body: some View {
        PlaceholderView(title: "Custom Layout Demo", description: "Creating custom layout containers with Layout protocol")
    }
}

// MARK: - Content Demos
struct TextDemo: View {
    var body: some View {
        PlaceholderView(title: "Text Demo", description: "Text styling, formatting, and label combinations")
    }
}

struct ImageDemo: View {
    var body: some View {
        PlaceholderView(title: "Image Demo", description: "Image display, async loading, and SF Symbols")
    }
}

struct ShapeDemo: View {
    var body: some View {
        PlaceholderView(title: "Shape Demo", description: "Built-in shapes, custom paths, and drawing")
    }
}

struct GradientDemo: View {
    var body: some View {
        PlaceholderView(title: "Gradient Demo", description: "Linear, radial, and angular gradients with color manipulation")
    }
}

struct CanvasDemo: View {
    var body: some View {
        PlaceholderView(title: "Canvas Demo", description: "Custom drawing with Canvas and GraphicsContext")
    }
}

// MARK: - Control Demos
struct ProgressDemo: View {
    var body: some View {
        PlaceholderView(title: "Progress Demo", description: "ProgressView, Gauge with different styles")
    }
}

// MARK: - Gesture Demos
struct ComplexGesturesDemo: View {
    var body: some View {
        PlaceholderView(title: "Complex Gestures Demo", description: "Magnification, rotation, combined gestures")
    }
}

struct GestureLabDemo: View {
    var body: some View {
        PlaceholderView(title: "Gesture Lab Demo", description: "Interactive gesture value visualization")
    }
}

// MARK: - Animation Demos
struct SpringAnimationDemo: View {
    var body: some View {
        PlaceholderView(title: "Spring Animation Demo", description: "Spring physics, damping, and response configuration")
    }
}

struct TransitionDemo: View {
    var body: some View {
        PlaceholderView(title: "Transition Demo", description: "View transitions: slide, scale, opacity, asymmetric, custom")
    }
}

struct KeyframeAnimationDemo: View {
    var body: some View {
        PlaceholderView(title: "Keyframe Animation Demo", description: "Timeline-based keyframe animations")
    }
}

// MARK: - Graphics Demos
struct VisualEffectsDemo: View {
    var body: some View {
        PlaceholderView(title: "Visual Effects Demo", description: "Blur, shadow, opacity, blend modes")
    }
}

struct MaskClipDemo: View {
    var body: some View {
        PlaceholderView(title: "Mask & Clip Demo", description: "Masking, clipping, and overlay techniques")
    }
}

struct GlassEffectsDemo: View {
    var body: some View {
        PlaceholderView(title: "Glass Effects Demo", description: "Liquid glass materials and background effects")
    }
}

// MARK: - Placeholder View
struct PlaceholderView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "hammer.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Text("Coming Soon")
                .font(.caption)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.orange.opacity(0.2))
                .cornerRadius(16)
        }
        .padding()
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
