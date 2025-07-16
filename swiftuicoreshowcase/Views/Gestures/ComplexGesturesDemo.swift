//
//  ComplexGesturesDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ComplexGesturesDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Magnification").tag(0)
                    Text("Rotation").tag(1)
                    Text("Combined").tag(2)
                    Text("Sequence").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    MagnificationGestureDemo()
                case 1:
                    RotationGestureDemo()
                case 2:
                    CombinedGesturesDemo()
                case 3:
                    SequenceGesturesDemo()
                default:
                    MagnificationGestureDemo()
                }
            }
        }
        .navigationTitle("Complex Gestures Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MagnificationGestureDemo: View {
    @State private var magnification: CGFloat = 1.0
    @State private var finalMagnification: CGFloat = 1.0
    @State private var isGestureActive = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Info Panel
                VStack(alignment: .leading, spacing: 15) {
                    Text("Magnification Gesture")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Current Scale: \(magnification, specifier: "%.2f")")
                        Text("Final Scale: \(finalMagnification, specifier: "%.2f")")
                        Text("Gesture Active: \(isGestureActive ? "Yes" : "No")")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    Button("Reset") {
                        withAnimation(.spring()) {
                            magnification = 1.0
                            finalMagnification = 1.0
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Magnification Demo
                VStack(spacing: 20) {
                    Text("Pinch to Zoom")
                        .font(.headline)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 300)
                        
                        VStack(spacing: 15) {
                            Image(systemName: "hand.point.up.braille")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                            
                            Text("Pinch Me!")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Use pinch gesture to zoom")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(16)
                        .scaleEffect(magnification)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    magnification = finalMagnification * value
                                    isGestureActive = true
                                }
                                .onEnded { value in
                                    finalMagnification = magnification
                                    isGestureActive = false
                                    
                                    // Limit zoom levels
                                    if magnification > 3.0 {
                                        withAnimation(.spring()) {
                                            magnification = 3.0
                                            finalMagnification = 3.0
                                        }
                                    } else if magnification < 0.5 {
                                        withAnimation(.spring()) {
                                            magnification = 0.5
                                            finalMagnification = 0.5
                                        }
                                    }
                                }
                        )
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Multiple Items Demo
                VStack(spacing: 20) {
                    Text("Multiple Magnifiable Items")
                        .font(.headline)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        ForEach(0..<4, id: \.self) { index in
                            MagnifiableCard(index: index)
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

struct MagnifiableCard: View {
    let index: Int
    @State private var scale: CGFloat = 1.0
    @State private var finalScale: CGFloat = 1.0
    
    private let colors: [Color] = [.red, .green, .blue, .orange]
    
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .font(.system(size: 30))
                .foregroundColor(colors[index])
            
            Text("Card \(index + 1)")
                .font(.caption)
                .fontWeight(.bold)
        }
        .padding()
        .background(colors[index].opacity(0.1))
        .cornerRadius(12)
        .scaleEffect(scale)
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    scale = finalScale * value
                }
                .onEnded { value in
                    finalScale = scale
                    
                    // Reset if too large or too small
                    if scale > 2.0 || scale < 0.5 {
                        withAnimation(.spring()) {
                            scale = 1.0
                            finalScale = 1.0
                        }
                    }
                }
        )
    }
}

struct RotationGestureDemo: View {
    @State private var rotation: Angle = .zero
    @State private var finalRotation: Angle = .zero
    @State private var isGestureActive = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Info Panel
                VStack(alignment: .leading, spacing: 15) {
                    Text("Rotation Gesture")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Current Rotation: \(rotation.degrees, specifier: "%.1f")°")
                        Text("Final Rotation: \(finalRotation.degrees, specifier: "%.1f")°")
                        Text("Gesture Active: \(isGestureActive ? "Yes" : "No")")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    Button("Reset") {
                        withAnimation(.spring()) {
                            rotation = .zero
                            finalRotation = .zero
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Rotation Demo
                VStack(spacing: 20) {
                    Text("Rotate with Two Fingers")
                        .font(.headline)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 300)
                        
                        VStack(spacing: 15) {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 60))
                                .foregroundColor(.green)
                            
                            Text("Rotate Me!")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Use two fingers to rotate")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(16)
                        .rotationEffect(rotation)
                        .gesture(
                            RotationGesture()
                                .onChanged { value in
                                    rotation = finalRotation + value
                                    isGestureActive = true
                                }
                                .onEnded { value in
                                    finalRotation = rotation
                                    isGestureActive = false
                                }
                        )
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Rotation with Snap
                VStack(spacing: 20) {
                    Text("Rotation with Snap to Angles")
                        .font(.headline)
                    
                    RotationSnapDemo()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct RotationSnapDemo: View {
    @State private var rotation: Angle = .zero
    @State private var finalRotation: Angle = .zero
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Snaps to 45° increments")
                .font(.caption)
                .foregroundColor(.secondary)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.purple)
                .frame(width: 100, height: 100)
                .overlay(
                    VStack {
                        Text("SNAP")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("\(Int(rotation.degrees))°")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                )
                .rotationEffect(rotation)
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            rotation = finalRotation + value
                        }
                        .onEnded { value in
                            let degrees = (finalRotation + value).degrees
                            let snapAngle = round(degrees / 45) * 45
                            
                            withAnimation(.spring()) {
                                rotation = .degrees(snapAngle)
                                finalRotation = .degrees(snapAngle)
                            }
                        }
                )
        }
    }
}

struct CombinedGesturesDemo: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var offset: CGSize = .zero
    
    @State private var finalScale: CGFloat = 1.0
    @State private var finalRotation: Angle = .zero
    @State private var finalOffset: CGSize = .zero
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Info Panel
                VStack(alignment: .leading, spacing: 15) {
                    Text("Combined Gestures")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Scale: \(scale, specifier: "%.2f")")
                        Text("Rotation: \(rotation.degrees, specifier: "%.1f")°")
                        Text("Offset: (\(offset.width, specifier: "%.1f"), \(offset.height, specifier: "%.1f"))")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    Button("Reset All") {
                        withAnimation(.spring()) {
                            scale = 1.0
                            rotation = .zero
                            offset = .zero
                            finalScale = 1.0
                            finalRotation = .zero
                            finalOffset = .zero
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Combined Gestures Demo
                VStack(spacing: 20) {
                    Text("Drag, Pinch, and Rotate")
                        .font(.headline)
                    
                    Text("Use multiple gestures simultaneously")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 350)
                        
                        VStack(spacing: 15) {
                            Image(systemName: "hand.tap.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.orange)
                            
                            Text("Multi-Touch")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Drag • Pinch • Rotate")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(16)
                        .scaleEffect(scale)
                        .rotationEffect(rotation)
                        .offset(offset)
                        .gesture(
                            SimultaneousGesture(
                                DragGesture()
                                    .onChanged { value in
                                        offset = CGSize(
                                            width: finalOffset.width + value.translation.width,
                                            height: finalOffset.height + value.translation.height
                                        )
                                    }
                                    .onEnded { value in
                                        finalOffset = offset
                                    },
                                
                                SimultaneousGesture(
                                    MagnificationGesture()
                                        .onChanged { value in
                                            scale = finalScale * value
                                        }
                                        .onEnded { value in
                                            finalScale = scale
                                        },
                                    
                                    RotationGesture()
                                        .onChanged { value in
                                            rotation = finalRotation + value
                                        }
                                        .onEnded { value in
                                            finalRotation = rotation
                                        }
                                )
                            )
                        )
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

struct SequenceGesturesDemo: View {
    @State private var dragOffset: CGSize = .zero
    @State private var isLongPressed = false
    @State private var sequenceState = "Idle"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Info Panel
                VStack(alignment: .leading, spacing: 15) {
                    Text("Sequence Gestures")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("State: \(sequenceState)")
                        Text("Long Pressed: \(isLongPressed ? "Yes" : "No")")
                        Text("Drag Offset: (\(dragOffset.width, specifier: "%.1f"), \(dragOffset.height, specifier: "%.1f"))")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    Button("Reset") {
                        withAnimation(.spring()) {
                            dragOffset = .zero
                            isLongPressed = false
                            sequenceState = "Idle"
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Sequence Demo
                VStack(spacing: 20) {
                    Text("Long Press Then Drag")
                        .font(.headline)
                    
                    Text("Hold for 0.5s, then drag to move")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 300)
                        
                        VStack(spacing: 15) {
                            Image(systemName: "hand.point.up.left.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.pink)
                            
                            Text("Hold & Drag")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(sequenceState)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.pink.opacity(0.1))
                        .cornerRadius(16)
                        .scaleEffect(isLongPressed ? 1.1 : 1.0)
                        .offset(dragOffset)
                        .gesture(
                            SequenceGesture(
                                LongPressGesture(minimumDuration: 0.5)
                                    .onChanged { _ in
                                        sequenceState = "Long Pressing..."
                                    }
                                    .onEnded { _ in
                                        isLongPressed = true
                                        sequenceState = "Long Press Complete"
                                    },
                                
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation
                                        sequenceState = "Dragging"
                                    }
                                    .onEnded { value in
                                        sequenceState = "Drag Complete"
                                    }
                            )
                        )
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Exclusively Gesture Demo
                VStack(spacing: 20) {
                    Text("Exclusive Gestures")
                        .font(.headline)
                    
                    Text("Tap OR Long Press (not both)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ExclusiveGestureDemo()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct ExclusiveGestureDemo: View {
    @State private var action = "Waiting..."
    @State private var tapCount = 0
    @State private var longPressCount = 0
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text("Action: \(action)")
                    .font(.headline)
                
                Text("Taps: \(tapCount) | Long Presses: \(longPressCount)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cyan)
                .frame(width: 120, height: 120)
                .overlay(
                    VStack {
                        Image(systemName: "hand.tap")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        
                        Text("Tap or Hold")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                )
                .gesture(
                    ExclusiveGesture(
                        TapGesture()
                            .onEnded { _ in
                                tapCount += 1
                                action = "Tapped!"
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    action = "Waiting..."
                                }
                            },
                        
                        LongPressGesture(minimumDuration: 0.5)
                            .onEnded { _ in
                                longPressCount += 1
                                action = "Long Pressed!"
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    action = "Waiting..."
                                }
                            }
                    )
                )
        }
    }
}
