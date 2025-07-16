//
//  TransitionDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct TransitionDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Basic").tag(0)
                    Text("Advanced").tag(1)
                    Text("Custom").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    BasicTransitionDemo()
                case 1:
                    AdvancedTransitionDemo()
                case 2:
                    CustomTransitionDemo()
                default:
                    BasicTransitionDemo()
                }
            }
        }
        .navigationTitle("Transition Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BasicTransitionDemo: View {
    @State private var showView = false
    @State private var selectedTransition = 0
    
    let transitions = [
        ("Slide", AnyTransition.slide),
        ("Scale", AnyTransition.scale),
        ("Opacity", AnyTransition.opacity),
        ("Move Edge", AnyTransition.move(edge: .trailing)),
        ("Push", AnyTransition.push(from: .bottom))
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Transition Type")
                        .font(.headline)
                    
                    Picker("Transition", selection: $selectedTransition) {
                        ForEach(0..<transitions.count, id: \.self) { index in
                            Text(transitions[index].0).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(showView ? "Hide View" : "Show View") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showView.toggle()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Transition Preview
                VStack(spacing: 20) {
                    Text("Transition Preview")
                        .font(.headline)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 200)
                        
                        if showView {
                            VStack(spacing: 10) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.yellow)
                                
                                Text("Animated View")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("Using \(transitions[selectedTransition].0)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                            .transition(transitions[selectedTransition].1)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Multiple Views Demo
                VStack(spacing: 20) {
                    Text("Multiple Views with Different Transitions")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Button("Toggle All") {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                showView.toggle()
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        HStack(spacing: 15) {
                            if showView {
                                TransitionCard(
                                    title: "Scale",
                                    color: .blue,
                                    transition: .scale
                                )
                                
                                TransitionCard(
                                    title: "Slide",
                                    color: .green,
                                    transition: .slide
                                )
                                
                                TransitionCard(
                                    title: "Opacity",
                                    color: .purple,
                                    transition: .opacity
                                )
                            }
                        }
                        .frame(height: 100)
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

struct TransitionCard: View {
    let title: String
    let color: Color
    let transition: AnyTransition
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
            
            Circle()
                .fill(color)
                .frame(width: 40, height: 40)
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
        .transition(transition)
    }
}

struct AdvancedTransitionDemo: View {
    @State private var showView = false
    @State private var currentTransition = 0
    
    let advancedTransitions: [(String, AnyTransition)] = [
        ("Combined Scale + Opacity", .scale.combined(with: .opacity)),
        ("Asymmetric Slide", .asymmetric(insertion: .slide, removal: .scale)),
        ("Move + Scale", .move(edge: .leading).combined(with: .scale)),
        ("Conditional", .opacity), // We'll modify this dynamically
        ("Offset", .offset(x: 100, y: 0))
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Advanced Transition")
                        .font(.headline)
                    
                    Picker("Transition", selection: $currentTransition) {
                        ForEach(0..<advancedTransitions.count, id: \.self) { index in
                            Text(advancedTransitions[index].0).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(showView ? "Hide" : "Show") {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showView.toggle()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Advanced Transition Preview
                VStack(spacing: 20) {
                    Text("Advanced Transition Preview")
                        .font(.headline)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 250)
                        
                        if showView {
                            VStack(spacing: 15) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 50))
                                    .foregroundColor(.orange)
                                
                                Text("Advanced Transition")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text(advancedTransitions[currentTransition].0)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                
                                HStack {
                                    ForEach(0..<3, id: \.self) { _ in
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: 20, height: 20)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(16)
                            .transition(getTransition())
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Sequential Transitions
                VStack(spacing: 20) {
                    Text("Sequential Transitions")
                        .font(.headline)
                    
                    Button("Animate Sequence") {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showView.toggle()
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    HStack(spacing: 20) {
                        if showView {
                            VStack {
                                Circle()
                                    .fill(.red)
                                    .frame(width: 40, height: 40)
                                Text("First")
                                    .font(.caption)
                            }
                            .transition(.scale.animation(.easeInOut(duration: 0.3)))
                        }
                        
                        if showView {
                            VStack {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 40, height: 40)
                                Text("Second")
                                    .font(.caption)
                            }
                            .transition(.scale.animation(.easeInOut(duration: 0.3).delay(0.2)))
                        }
                        
                        if showView {
                            VStack {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 40, height: 40)
                                Text("Third")
                                    .font(.caption)
                            }
                            .transition(.scale.animation(.easeInOut(duration: 0.3).delay(0.4)))
                        }
                    }
                    .frame(height: 80)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
    
    private func getTransition() -> AnyTransition {
        switch currentTransition {
        case 0:
            return .scale.combined(with: .opacity)
        case 1:
            return .asymmetric(insertion: .slide, removal: .scale)
        case 2:
            return .move(edge: .leading).combined(with: .scale)
        case 3:
            return showView ? .slide : .opacity
        case 4:
            return .offset(x: 100, y: 0)
        default:
            return .opacity
        }
    }
}

struct CustomTransitionDemo: View {
    @State private var showView = false
    @State private var selectedCustomTransition = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Custom Transition")
                        .font(.headline)
                    
                    Picker("Custom Transition", selection: $selectedCustomTransition) {
                        Text("Flip").tag(0)
                        Text("Bounce").tag(1)
                        Text("Swing").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(showView ? "Hide" : "Show") {
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                            showView.toggle()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Custom Transition Preview
                VStack(spacing: 20) {
                    Text("Custom Transition Preview")
                        .font(.headline)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 300)
                        
                        if showView {
                            VStack(spacing: 15) {
                                Image(systemName: "wand.and.stars")
                                    .font(.system(size: 60))
                                    .foregroundColor(.purple)
                                
                                Text("Custom Transition")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("Using custom animation effects")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(20)
                            .transition(getCustomTransition())
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Transition Code Examples
                VStack(alignment: .leading, spacing: 15) {
                    Text("Custom Transition Code")
                        .font(.headline)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Flip Transition:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Text("""
                            .transition(.asymmetric(
                                insertion: .modifier(
                                    active: FlipModifier(angle: -90),
                                    identity: FlipModifier(angle: 0)
                                ),
                                removal: .modifier(
                                    active: FlipModifier(angle: 90),
                                    identity: FlipModifier(angle: 0)
                                )
                            ))
                            """)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
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
    
    private func getCustomTransition() -> AnyTransition {
        switch selectedCustomTransition {
        case 0:
            return .asymmetric(
                insertion: .modifier(
                    active: FlipModifier(angle: -90),
                    identity: FlipModifier(angle: 0)
                ),
                removal: .modifier(
                    active: FlipModifier(angle: 90),
                    identity: FlipModifier(angle: 0)
                )
            )
        case 1:
            return .modifier(
                active: BounceModifier(scale: 0.1),
                identity: BounceModifier(scale: 1.0)
            )
        case 2:
            return .modifier(
                active: SwingModifier(rotation: 45, offset: 100),
                identity: SwingModifier(rotation: 0, offset: 0)
            )
        default:
            return .opacity
        }
    }
}

struct FlipModifier: ViewModifier {
    let angle: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(angle),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}

struct BounceModifier: ViewModifier {
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
    }
}

struct SwingModifier: ViewModifier {
    let rotation: Double
    let offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation))
            .offset(x: offset)
    }
}
