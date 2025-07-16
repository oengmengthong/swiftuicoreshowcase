//
//  GestureLabDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct GestureLabDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Tap Lab").tag(0)
                    Text("Drag Lab").tag(1)
                    Text("Pinch Lab").tag(2)
                    Text("Multi-Touch").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    TapGestureLab()
                case 1:
                    DragGestureLab()
                case 2:
                    PinchGestureLab()
                case 3:
                    MultiTouchGestureLab()
                default:
                    TapGestureLab()
                }
            }
        }
        .navigationTitle("Gesture Lab Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TapGestureLab: View {
    @State private var tapCount = 0
    @State private var lastTapLocation: CGPoint = .zero
    @State private var tapLocations: [CGPoint] = []
    @State private var showRipple = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Gesture Info Panel
            VStack(alignment: .leading, spacing: 10) {
                Text("Tap Gesture Analysis")
                    .font(.headline)
                
                HStack {
                    Text("Tap Count:")
                    Spacer()
                    Text("\(tapCount)")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Last Tap Location:")
                    Spacer()
                    Text("(\(lastTapLocation.x, specifier: "%.0f"), \(lastTapLocation.y, specifier: "%.0f"))")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                HStack {
                    Text("Total Taps:")
                    Spacer()
                    Text("\(tapLocations.count)")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // Interactive Area
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                    
                    // Tap visualization
                    ForEach(Array(tapLocations.enumerated()), id: \.offset) { index, location in
                        Circle()
                            .fill(Color.red.opacity(0.6))
                            .frame(width: 20, height: 20)
                            .position(location)
                            .scaleEffect(showRipple && index == tapLocations.count - 1 ? 2.0 : 1.0)
                            .opacity(showRipple && index == tapLocations.count - 1 ? 0.3 : 0.8)
                            .animation(.easeOut(duration: 0.5), value: showRipple)
                    }
                    
                    // Instructions
                    if tapLocations.isEmpty {
                        Text("Tap anywhere to analyze gesture data")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
                .contentShape(Rectangle())
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            let location = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            handleTap(at: location)
                        }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            handleTap(at: value.location)
                        }
                )
            }
            .frame(height: 300)
            
            // Controls
            HStack {
                Button("Clear Taps") {
                    withAnimation {
                        tapLocations.removeAll()
                        tapCount = 0
                    }
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Reset Lab") {
                    withAnimation {
                        tapLocations.removeAll()
                        tapCount = 0
                        lastTapLocation = .zero
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
    
    private func handleTap(at location: CGPoint) {
        withAnimation(.easeOut(duration: 0.1)) {
            tapCount += 1
            lastTapLocation = location
            tapLocations.append(location)
            
            // Ripple effect
            showRipple = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showRipple = false
            }
        }
    }
}

struct DragGestureLab: View {
    @State private var dragOffset: CGSize = .zero
    @State private var dragVelocity: CGSize = .zero
    @State private var dragDistance: CGFloat = 0
    @State private var dragPath: [CGPoint] = []
    @State private var isDragging = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Gesture Info Panel
            VStack(alignment: .leading, spacing: 10) {
                Text("Drag Gesture Analysis")
                    .font(.headline)
                
                HStack {
                    Text("Offset:")
                    Spacer()
                    Text("(\(dragOffset.width, specifier: "%.0f"), \(dragOffset.height, specifier: "%.0f"))")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Velocity:")
                    Spacer()
                    Text("(\(dragVelocity.width, specifier: "%.0f"), \(dragVelocity.height, specifier: "%.0f"))")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                HStack {
                    Text("Distance:")
                    Spacer()
                    Text("\(dragDistance, specifier: "%.0f") pts")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                HStack {
                    Text("Status:")
                    Spacer()
                    Text(isDragging ? "Dragging" : "Idle")
                        .fontWeight(.bold)
                        .foregroundColor(isDragging ? .red : .gray)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // Interactive Area
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.green.opacity(0.3), .blue.opacity(0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.green, lineWidth: 2)
                        )
                    
                    // Drag path visualization
                    if dragPath.count > 1 {
                        Path { path in
                            path.move(to: dragPath[0])
                            for point in dragPath.dropFirst() {
                                path.addLine(to: point)
                            }
                        }
                        .stroke(Color.red, lineWidth: 3)
                        .opacity(0.7)
                    }
                    
                    // Draggable object
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                        )
                        .position(
                            x: geometry.size.width / 2 + dragOffset.width,
                            y: geometry.size.height / 2 + dragOffset.height
                        )
                        .scaleEffect(isDragging ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3), value: isDragging)
                        .shadow(
                            color: isDragging ? .blue.opacity(0.5) : .clear,
                            radius: isDragging ? 10 : 0
                        )
                    
                    // Velocity indicator
                    if isDragging && (abs(dragVelocity.width) > 10 || abs(dragVelocity.height) > 10) {
                        Path { path in
                            let startPoint = CGPoint(
                                x: geometry.size.width / 2 + dragOffset.width,
                                y: geometry.size.height / 2 + dragOffset.height
                            )
                            let endPoint = CGPoint(
                                x: startPoint.x + dragVelocity.width * 0.1,
                                y: startPoint.y + dragVelocity.height * 0.1
                            )
                            path.move(to: startPoint)
                            path.addLine(to: endPoint)
                        }
                        .stroke(Color.red, lineWidth: 4)
                        .opacity(0.8)
                    }
                }
                .contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            dragOffset = value.translation
                            dragVelocity = value.velocity
                            dragDistance = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                            
                            // Record path
                            let currentPoint = CGPoint(
                                x: geometry.size.width / 2 + value.translation.width,
                                y: geometry.size.height / 2 + value.translation.height
                            )
                            dragPath.append(currentPoint)
                        }
                        .onEnded { value in
                            isDragging = false
                            
                            // Spring back animation
                            withAnimation(.spring()) {
                                dragOffset = .zero
                            }
                            
                            // Clear path after delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    dragPath.removeAll()
                                }
                            }
                        }
                )
            }
            .frame(height: 300)
            
            // Controls
            HStack {
                Button("Clear Path") {
                    withAnimation {
                        dragPath.removeAll()
                    }
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Reset Position") {
                    withAnimation(.spring()) {
                        dragOffset = .zero
                        dragPath.removeAll()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct PinchGestureLab: View {
    @State private var scale: CGFloat = 1.0
    @State private var magnification: CGFloat = 1.0
    @State private var velocity: CGFloat = 0.0
    @State private var isPinching = false
    @State private var scaleHistory: [CGFloat] = []
    
    var body: some View {
        VStack(spacing: 20) {
            // Gesture Info Panel
            VStack(alignment: .leading, spacing: 10) {
                Text("Pinch Gesture Analysis")
                    .font(.headline)
                
                HStack {
                    Text("Scale:")
                    Spacer()
                    Text("\(scale, specifier: "%.2f")x")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Magnification:")
                    Spacer()
                    Text("\(magnification, specifier: "%.2f")x")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                HStack {
                    Text("Velocity:")
                    Spacer()
                    Text("\(velocity, specifier: "%.2f")")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                HStack {
                    Text("Status:")
                    Spacer()
                    Text(isPinching ? "Pinching" : "Idle")
                        .fontWeight(.bold)
                        .foregroundColor(isPinching ? .red : .gray)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // Interactive Area
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.orange.opacity(0.3), .red.opacity(0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.orange, lineWidth: 2)
                        )
                    
                    // Pinchable object
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 120, height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 4)
                            )
                            .shadow(
                                color: isPinching ? .blue.opacity(0.5) : .clear,
                                radius: isPinching ? 20 : 0
                            )
                        
                        VStack {
                            Image(systemName: "hand.point.up.left.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                            Text("Pinch Me")
                                .font(.headline)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                    .scaleEffect(scale)
                    .animation(.spring(response: 0.3), value: isPinching)
                    
                    // Scale indicator rings
                    ForEach(scaleHistory.indices, id: \.self) { index in
                        Circle()
                            .stroke(Color.red.opacity(0.3), lineWidth: 2)
                            .frame(width: 120 * scaleHistory[index], height: 120 * scaleHistory[index])
                            .opacity(Double(scaleHistory.count - index) / Double(scaleHistory.count))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            isPinching = true
                            magnification = value
                            scale = value
                            velocity = value - (scaleHistory.last ?? 1.0)
                            
                            // Record scale history
                            scaleHistory.append(value)
                            if scaleHistory.count > 10 {
                                scaleHistory.removeFirst()
                            }
                        }
                        .onEnded { value in
                            isPinching = false
                            
                            // Clear history after delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    scaleHistory.removeAll()
                                }
                            }
                        }
                )
            }
            .frame(height: 300)
            
            // Controls
            HStack {
                Button("Clear History") {
                    withAnimation {
                        scaleHistory.removeAll()
                    }
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Reset Scale") {
                    withAnimation(.spring()) {
                        scale = 1.0
                        magnification = 1.0
                        scaleHistory.removeAll()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct MultiTouchGestureLab: View {
    @State private var position: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var gestureState = "Idle"
    @State private var touchCount = 0
    @State private var lastGestureInfo = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Gesture Info Panel
            VStack(alignment: .leading, spacing: 10) {
                Text("Multi-Touch Gesture Analysis")
                    .font(.headline)
                
                HStack {
                    Text("Position:")
                    Spacer()
                    Text("(\(position.width, specifier: "%.0f"), \(position.height, specifier: "%.0f"))")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Scale:")
                    Spacer()
                    Text("\(scale, specifier: "%.2f")x")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                HStack {
                    Text("Rotation:")
                    Spacer()
                    Text("\(rotation.degrees, specifier: "%.0f")°")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                HStack {
                    Text("Status:")
                    Spacer()
                    Text(gestureState)
                        .fontWeight(.bold)
                        .foregroundColor(gestureState == "Idle" ? .gray : .red)
                }
                
                if !lastGestureInfo.isEmpty {
                    HStack {
                        Text("Last Gesture:")
                        Spacer()
                        Text(lastGestureInfo)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // Interactive Area
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.purple.opacity(0.3), .pink.opacity(0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                    
                    // Multi-touch object
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.red, .orange, .yellow]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 100, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 3)
                            )
                        
                        VStack {
                            Image(systemName: "hand.draw.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            Text("Multi-Touch")
                                .font(.caption)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                    .position(
                        x: geometry.size.width / 2 + position.width,
                        y: geometry.size.height / 2 + position.height
                    )
                    .scaleEffect(scale)
                    .rotationEffect(rotation)
                    .animation(.spring(response: 0.3), value: gestureState != "Idle")
                    
                    // Grid overlay for reference
                    Path { path in
                        let gridSize: CGFloat = 40
                        let width = geometry.size.width
                        let height = geometry.size.height
                        
                        // Vertical lines
                        for i in stride(from: 0, through: width, by: gridSize) {
                            path.move(to: CGPoint(x: i, y: 0))
                            path.addLine(to: CGPoint(x: i, y: height))
                        }
                        
                        // Horizontal lines
                        for i in stride(from: 0, through: height, by: gridSize) {
                            path.move(to: CGPoint(x: 0, y: i))
                            path.addLine(to: CGPoint(x: width, y: i))
                        }
                    }
                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                }
                .contentShape(Rectangle())
                .gesture(
                    SimultaneousGesture(
                        DragGesture()
                            .onChanged { value in
                                gestureState = "Dragging"
                                position = value.translation
                                lastGestureInfo = "Drag: \(Int(value.translation.width)), \(Int(value.translation.height))"
                            }
                            .onEnded { _ in
                                gestureState = "Idle"
                            },
                        
                        SimultaneousGesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    gestureState = "Scaling"
                                    scale = value
                                    lastGestureInfo = "Scale: \(String(format: "%.2f", value))x"
                                }
                                .onEnded { _ in
                                    gestureState = "Idle"
                                },
                            
                            RotationGesture()
                                .onChanged { value in
                                    gestureState = "Rotating"
                                    rotation = value
                                    lastGestureInfo = "Rotate: \(Int(value.degrees))°"
                                }
                                .onEnded { _ in
                                    gestureState = "Idle"
                                }
                        )
                    )
                )
            }
            .frame(height: 300)
            
            // Controls
            HStack {
                Button("Reset Position") {
                    withAnimation(.spring()) {
                        position = .zero
                    }
                }
                .buttonStyle(.bordered)
                
                Button("Reset Scale") {
                    withAnimation(.spring()) {
                        scale = 1.0
                    }
                }
                .buttonStyle(.bordered)
                
                Button("Reset Rotation") {
                    withAnimation(.spring()) {
                        rotation = .zero
                    }
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Reset All") {
                    withAnimation(.spring()) {
                        position = .zero
                        scale = 1.0
                        rotation = .zero
                        gestureState = "Idle"
                        lastGestureInfo = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}
