//
//  BasicGesturesDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct BasicGesturesDemo: View {
    @State private var tapCount = 0
    @State private var longPressCount = 0
    @State private var dragOffset = CGSize.zero
    @State private var isPressed = false
    @State private var lastTapLocation: CGPoint = .zero
    @State private var dragDistance: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("Basic Gestures")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Tap, long press, drag gestures with visual feedback")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Gesture Counters
                VStack(spacing: 20) {
                    Text("Gesture Counters")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("\(tapCount)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.blue)
                            Text("Taps")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        VStack {
                            Text("\(longPressCount)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                            Text("Long Presses")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        VStack {
                            Text("\(dragDistance, specifier: "%.0f")")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.purple)
                            Text("Drag Distance")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Tap Gesture Demo
                VStack(spacing: 20) {
                    Text("Tap Gesture")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue.opacity(0.3))
                            .frame(height: 120)
                            .overlay(
                                VStack {
                                    Image(systemName: "hand.tap")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.blue)
                                    Text("Tap Me!")
                                        .font(.headline)
                                        .foregroundStyle(.blue)
                                }
                            )
                            .onTapGesture { location in
                                tapCount += 1
                                lastTapLocation = location
                                
                                // Visual feedback
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    // Scale effect will be handled by scaleEffect modifier
                                }
                            }
                            .scaleEffect(tapCount > 0 ? 1.05 : 1.0)
                            .animation(.easeInOut(duration: 0.1), value: tapCount)
                        
                        Text("Tap Count: \(tapCount)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        if lastTapLocation != .zero {
                            Text("Last Tap: (\(lastTapLocation.x, specifier: "%.0f"), \(lastTapLocation.y, specifier: "%.0f"))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Long Press Gesture Demo
                VStack(spacing: 20) {
                    Text("Long Press Gesture")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(isPressed ? Color.green.opacity(0.6) : Color.green.opacity(0.3))
                            .frame(height: 120)
                            .overlay(
                                VStack {
                                    Image(systemName: "hand.point.up.left")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.green)
                                    Text(isPressed ? "Pressed!" : "Hold Me!")
                                        .font(.headline)
                                        .foregroundStyle(.green)
                                }
                            )
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .onLongPressGesture(minimumDuration: 0.5) {
                                longPressCount += 1
                                
                                // Reset pressed state after a delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isPressed = false
                                    }
                                }
                            } onPressingChanged: { pressing in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isPressed = pressing
                                }
                            }
                        
                        Text("Long Press Count: \(longPressCount)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("Hold for 0.5 seconds")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Drag Gesture Demo
                VStack(spacing: 20) {
                    Text("Drag Gesture")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 200)
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.purple, .pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 60, height: 60)
                                .offset(dragOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            dragOffset = value.translation
                                            dragDistance = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                                        }
                                        .onEnded { _ in
                                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                dragOffset = .zero
                                            }
                                        }
                                )
                        }
                        
                        VStack(spacing: 4) {
                            Text("Drag the circle")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text("Offset: (\(dragOffset.width, specifier: "%.0f"), \(dragOffset.height, specifier: "%.0f"))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .font(.system(.caption, design: .monospaced))
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Combined Gesture Demo
                VStack(spacing: 20) {
                    Text("Combined Gestures")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.orange.opacity(0.3))
                            .frame(height: 120)
                            .overlay(
                                VStack {
                                    Image(systemName: "hand.raised")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.orange)
                                    Text("Multi-Gesture")
                                        .font(.headline)
                                        .foregroundStyle(.orange)
                                }
                            )
                            .onTapGesture {
                                tapCount += 1
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    // Visual feedback
                                }
                            }
                            .onLongPressGesture {
                                longPressCount += 1
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    // Visual feedback
                                }
                            }
                        
                        Text("This element responds to both tap and long press")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Reset Button
                VStack(spacing: 20) {
                    Text("Reset Counters")
                        .font(.headline)
                    
                    Button("Reset All") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            tapCount = 0
                            longPressCount = 0
                            dragOffset = .zero
                            dragDistance = 0
                            lastTapLocation = .zero
                            isPressed = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Gesture Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Gesture Types")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        GestureInfoRow(gesture: "Tap", description: "Single finger tap recognition")
                        GestureInfoRow(gesture: "Long Press", description: "Extended touch with configurable duration")
                        GestureInfoRow(gesture: "Drag", description: "Continuous movement tracking")
                        GestureInfoRow(gesture: "Combined", description: "Multiple gestures on same element")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Basic Gestures")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

struct GestureInfoRow: View {
    let gesture: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(gesture)
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
        BasicGesturesDemo()
    }
}
