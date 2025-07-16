import SwiftUI

struct GestureLabView: View {
    @State private var dragOffset = CGSize.zero
    @State private var scale = 1.0
    @State private var rotation = 0.0
    @State private var tapCount = 0
    @State private var isLongPressed = false
    @State private var magnificationValue = 1.0
    @State private var rotationValue = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("Gesture Laboratory")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Visualize drag, magnify, rotate values in real-time")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Gesture value display
                VStack(alignment: .leading, spacing: 8) {
                    Text("Live Gesture Values")
                        .font(.headline)
                    
                    Group {
                        Text("Drag: (\(dragOffset.width, specifier: "%.1f"), \(dragOffset.height, specifier: "%.1f"))")
                        Text("Scale: \(scale, specifier: "%.2f")")
                        Text("Rotation: \(rotation, specifier: "%.1f")°")
                        Text("Tap Count: \(tapCount)")
                        Text("Long Press: \(isLongPressed ? "Active" : "Inactive")")
                    }
                    .font(.system(.body, design: .monospaced))
                    .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Interactive gesture target
                VStack {
                    Text("Interactive Target")
                        .font(.headline)
                    Text("Tap, drag, pinch, rotate, and long press")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 200, height: 200)
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                        .offset(dragOffset)
                        .overlay(
                            VStack {
                                Image(systemName: "hand.tap")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                                Text("Interact")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                            }
                        )
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
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    magnificationValue = value
                                    scale = value
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        scale = 1.0
                                        magnificationValue = 1.0
                                    }
                                }
                        )
                        .gesture(
                            RotationGesture()
                                .onChanged { value in
                                    rotationValue = value.degrees
                                    rotation = value.degrees
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        rotation = 0
                                        rotationValue = 0
                                    }
                                }
                        )
                        .onTapGesture {
                            tapCount += 1
                            withAnimation(.easeInOut(duration: 0.2)) {
                                scale = 1.2
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    scale = 1.0
                                }
                            }
                        }
                        .onLongPressGesture(minimumDuration: 0.5) {
                            isLongPressed = true
                            withAnimation(.easeInOut(duration: 0.3)) {
                                scale = 0.8
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    scale = 1.0
                                    isLongPressed = false
                                }
                            }
                        }
                }
                .padding()
                
                // Reset button
                Button("Reset All Values") {
                    withAnimation(.spring()) {
                        dragOffset = .zero
                        scale = 1.0
                        rotation = 0.0
                        tapCount = 0
                        isLongPressed = false
                        magnificationValue = 1.0
                        rotationValue = 0.0
                    }
                }
                .buttonStyle(.borderedProminent)
                
                // Gesture documentation
                VStack(alignment: .leading, spacing: 12) {
                    Text("Available Gestures")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        GestureDocRow(icon: "hand.tap", title: "Tap", description: "Single tap to increment counter")
                        GestureDocRow(icon: "hand.point.up.left", title: "Long Press", description: "Hold for 0.5 seconds")
                        GestureDocRow(icon: "hand.drag", title: "Drag", description: "Drag to move the shape")
                        GestureDocRow(icon: "magnifyingglass", title: "Magnification", description: "Pinch to scale")
                        GestureDocRow(icon: "rotate.3d", title: "Rotation", description: "Rotate with two fingers")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle("Gesture Laboratory")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

struct GestureDocRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundStyle(.blue)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        GestureLabView()
    }
}
