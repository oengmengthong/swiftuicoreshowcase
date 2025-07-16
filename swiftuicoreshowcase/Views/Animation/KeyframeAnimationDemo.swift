//
//  KeyframeAnimationDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct KeyframeAnimationDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Basic Keyframes").tag(0)
                    Text("Complex Path").tag(1)
                    Text("Interactive").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    BasicKeyframeDemo()
                case 1:
                    ComplexPathDemo()
                case 2:
                    InteractiveKeyframeDemo()
                default:
                    BasicKeyframeDemo()
                }
            }
            .navigationTitle("Keyframe Animation")
        }
    }
}

struct BasicKeyframeDemo: View {
    @State private var animate = false
    @State private var duration: Double = 2.0
    
    var body: some View {
        VStack(spacing: 30) {
            // Controls
            controlsSection
            
            // Animation Demo
            keyframeAnimationSection
        }
        .padding()
    }
    
    private var controlsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Controls")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Duration: \(duration, specifier: "%.1f")s")
                Slider(value: $duration, in: 0.5...5.0)
            }
            
            Button(animate ? "Stop Animation" : "Start Animation") {
                animate.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private var keyframeAnimationSection: some View {
        VStack(spacing: 20) {
            Text("Bouncing Ball Animation")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    Circle()
                        .fill(Color.red)
                        .frame(width: 30, height: 30)
                        .keyframeAnimator(
                            initialValue: AnimationState(),
                            repeating: animate,
                            content: { content, value in
                                content
                                    .scaleEffect(value.scale)
                                    .offset(x: value.offsetX, y: value.offsetY)
                            },
                            keyframes: { _ in
                                KeyframeTrack(\.scale) {
                                    SpringKeyframe(1.2, duration: duration * 0.25)
                                    SpringKeyframe(0.8, duration: duration * 0.25)
                                    SpringKeyframe(1.0, duration: duration * 0.5)
                                }
                                
                                KeyframeTrack(\.offsetX) {
                                    LinearKeyframe(-80, duration: duration * 0.33)
                                    LinearKeyframe(80, duration: duration * 0.33)
                                    LinearKeyframe(0, duration: duration * 0.34)
                                }
                                
                                KeyframeTrack(\.offsetY) {
                                    CubicKeyframe(-60, duration: duration * 0.5)
                                    CubicKeyframe(60, duration: duration * 0.5)
                                }
                            }
                        )
                )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct ComplexPathDemo: View {
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 30) {
            Button(animate ? "Stop Animation" : "Start Animation") {
                animate.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            // Complex path animation
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.2))
                .frame(height: 250)
                .overlay(
                    Circle()
                        .fill(Color.green)
                        .frame(width: 20, height: 20)
                        .keyframeAnimator(
                            initialValue: ComplexAnimationState(),
                            repeating: animate,
                            content: { content, value in
                                content
                                    .scaleEffect(value.scale)
                                    .rotationEffect(.degrees(value.rotation))
                                    .offset(x: value.offsetX, y: value.offsetY)
                            },
                            keyframes: { _ in
                                KeyframeTrack(\.offsetX) {
                                    LinearKeyframe(-100, duration: 0.5)
                                    LinearKeyframe(100, duration: 1.0)
                                    LinearKeyframe(0, duration: 0.5)
                                }
                                
                                KeyframeTrack(\.offsetY) {
                                    CubicKeyframe(-80, duration: 0.25)
                                    CubicKeyframe(80, duration: 0.5)
                                    CubicKeyframe(-40, duration: 0.5)
                                    CubicKeyframe(0, duration: 0.75)
                                }
                                
                                KeyframeTrack(\.scale) {
                                    SpringKeyframe(1.5, duration: 0.5)
                                    SpringKeyframe(0.5, duration: 0.5)
                                    SpringKeyframe(1.0, duration: 1.0)
                                }
                                
                                KeyframeTrack(\.rotation) {
                                    LinearKeyframe(180, duration: 1.0)
                                    LinearKeyframe(360, duration: 1.0)
                                }
                            }
                        )
                )
        }
        .padding()
    }
}

struct InteractiveKeyframeDemo: View {
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 15) {
                Text("Interactive Keyframe Control")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Progress: \(progress, specifier: "%.2f")")
                    Slider(value: $progress, in: 0...1)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 25, height: 25)
                        .keyframeAnimator(
                            initialValue: AnimationState(),
                            repeating: false,
                            content: { content, value in
                                content
                                    .scaleEffect(value.scale)
                                    .offset(x: value.offsetX, y: value.offsetY)
                            },
                            keyframes: { _ in
                                KeyframeTrack(\.scale) {
                                    SpringKeyframe(1.5, duration: 0.5)
                                    SpringKeyframe(1.0, duration: 0.5)
                                }
                                
                                KeyframeTrack(\.offsetX) {
                                    LinearKeyframe(-60, duration: 0.5)
                                    LinearKeyframe(60, duration: 0.5)
                                }
                                
                                KeyframeTrack(\.offsetY) {
                                    CubicKeyframe(-40, duration: 0.5)
                                    CubicKeyframe(40, duration: 0.5)
                                }
                            }
                        )
                        .animation(.default, value: progress)
                )
        }
        .padding()
    }
}

struct AnimationState {
    var scale: Double = 1.0
    var offsetX: Double = 0.0
    var offsetY: Double = 0.0
}

struct ComplexAnimationState {
    var scale: Double = 1.0
    var offsetX: Double = 0.0
    var offsetY: Double = 0.0
    var rotation: Double = 0.0
}

#Preview {
    KeyframeAnimationDemo()
}
