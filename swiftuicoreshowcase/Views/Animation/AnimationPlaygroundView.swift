import SwiftUI

struct AnimationPlaygroundView: View {
    @State private var springResponse = 0.6
    @State private var springDamping = 0.8
    @State private var animationTrigger = false
    @State private var selectedAnimation: AnimationType = .spring
    @State private var animationDuration = 1.0
    @State private var animationDelay = 0.0
    @State private var repeatCount = 1.0
    @State private var autoreverse = false
    
    enum AnimationType: String, CaseIterable {
        case spring = "Spring"
        case easeIn = "Ease In"
        case easeOut = "Ease Out"
        case easeInOut = "Ease In Out"
        case linear = "Linear"
        case bouncy = "Bouncy"
        case smooth = "Smooth"
        case snappy = "Snappy"
        
        var animation: Animation {
            switch self {
            case .spring:
                return .spring(response: 0.6, dampingFraction: 0.8)
            case .easeIn:
                return .easeIn(duration: 1.0)
            case .easeOut:
                return .easeOut(duration: 1.0)
            case .easeInOut:
                return .easeInOut(duration: 1.0)
            case .linear:
                return .linear(duration: 1.0)
            case .bouncy:
                return .bouncy(duration: 1.0)
            case .smooth:
                return .smooth(duration: 1.0)
            case .snappy:
                return .snappy(duration: 1.0)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("Animation Playground")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Interactive spring and keyframe animation controls")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Animation Controls
                VStack(spacing: 20) {
                    Text("Animation Controls")
                        .font(.headline)
                    
                    // Animation Type Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Animation Type")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Picker("Animation Type", selection: $selectedAnimation) {
                            ForEach(AnimationType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    // Spring Animation Controls (only show for spring)
                    if selectedAnimation == .spring {
                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Spring Response: \(springResponse, specifier: "%.2f")")
                                    .font(.caption)
                                Slider(value: $springResponse, in: 0.1...2.0)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Spring Damping: \(springDamping, specifier: "%.2f")")
                                    .font(.caption)
                                Slider(value: $springDamping, in: 0.1...1.0)
                            }
                        }
                    }
                    
                    // General Animation Controls
                    VStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Duration: \(animationDuration, specifier: "%.1f")s")
                                .font(.caption)
                            Slider(value: $animationDuration, in: 0.1...3.0)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Delay: \(animationDelay, specifier: "%.1f")s")
                                .font(.caption)
                            Slider(value: $animationDelay, in: 0.0...2.0)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Repeat Count: \(Int(repeatCount))")
                                .font(.caption)
                            Slider(value: $repeatCount, in: 1...5, step: 1)
                        }
                        
                        Toggle("Auto Reverse", isOn: $autoreverse)
                    }
                    
                    // Trigger Button
                    Button("Animate") {
                        animationTrigger.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.headline)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Animation Demonstration Area
                VStack(spacing: 20) {
                    Text("Animation Preview")
                        .font(.headline)
                    
                    // Multiple animation targets
                    HStack(spacing: 30) {
                        // Scale Animation
                        VStack {
                            Text("Scale")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 60)
                                .scaleEffect(animationTrigger ? 1.5 : 1.0)
                                .animation(
                                    createAnimation()
                                        .delay(animationDelay)
                                        .repeatCount(Int(repeatCount), autoreverses: autoreverse),
                                    value: animationTrigger
                                )
                        }
                        
                        // Rotation Animation
                        VStack {
                            Text("Rotation")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.green)
                                .frame(width: 60, height: 60)
                                .rotationEffect(.degrees(animationTrigger ? 180 : 0))
                                .animation(
                                    createAnimation()
                                        .delay(animationDelay)
                                        .repeatCount(Int(repeatCount), autoreverses: autoreverse),
                                    value: animationTrigger
                                )
                        }
                        
                        // Offset Animation
                        VStack {
                            Text("Offset")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Capsule()
                                .fill(Color.purple)
                                .frame(width: 60, height: 30)
                                .offset(y: animationTrigger ? -30 : 0)
                                .animation(
                                    createAnimation()
                                        .delay(animationDelay)
                                        .repeatCount(Int(repeatCount), autoreverses: autoreverse),
                                    value: animationTrigger
                                )
                        }
                    }
                    
                    // Color Animation
                    VStack {
                        Text("Color")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        RoundedRectangle(cornerRadius: 12)
                            .fill(animationTrigger ? Color.orange : Color.red)
                            .frame(width: 120, height: 40)
                            .animation(
                                createAnimation()
                                    .delay(animationDelay)
                                    .repeatCount(Int(repeatCount), autoreverses: autoreverse),
                                value: animationTrigger
                            )
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Transition Examples
                VStack(spacing: 20) {
                    Text("Transition Examples")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        if animationTrigger {
                            Text("Slide Transition")
                                .padding()
                                .background(Color.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(8)
                                .transition(.slide)
                        }
                        
                        if animationTrigger {
                            Text("Scale Transition")
                                .padding()
                                .background(Color.green)
                                .foregroundStyle(.white)
                                .cornerRadius(8)
                                .transition(.scale)
                        }
                        
                        if animationTrigger {
                            Text("Opacity Transition")
                                .padding()
                                .background(Color.purple)
                                .foregroundStyle(.white)
                                .cornerRadius(8)
                                .transition(.opacity)
                        }
                    }
                    .animation(createAnimation(), value: animationTrigger)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Animation Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Animation Types")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        AnimationInfoRow(title: "Spring", description: "Physics-based animation with response and damping")
                        AnimationInfoRow(title: "Ease In", description: "Starts slow, accelerates")
                        AnimationInfoRow(title: "Ease Out", description: "Starts fast, decelerates")
                        AnimationInfoRow(title: "Ease In Out", description: "Slow start and end, fast middle")
                        AnimationInfoRow(title: "Linear", description: "Constant speed throughout")
                        AnimationInfoRow(title: "Bouncy", description: "Bouncy spring animation")
                        AnimationInfoRow(title: "Smooth", description: "Smooth spring animation")
                        AnimationInfoRow(title: "Snappy", description: "Quick spring animation")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Animation Playground")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
    
    private func createAnimation() -> Animation {
        var animation: Animation
        
        switch selectedAnimation {
        case .spring:
            animation = .spring(response: springResponse, dampingFraction: springDamping)
        case .easeIn:
            animation = .easeIn(duration: animationDuration)
        case .easeOut:
            animation = .easeOut(duration: animationDuration)
        case .easeInOut:
            animation = .easeInOut(duration: animationDuration)
        case .linear:
            animation = .linear(duration: animationDuration)
        case .bouncy:
            animation = .bouncy(duration: animationDuration)
        case .smooth:
            animation = .smooth(duration: animationDuration)
        case .snappy:
            animation = .snappy(duration: animationDuration)
        }
        
        return animation
    }
}

struct AnimationInfoRow: View {
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 80, alignment: .leading)
            Text(description)
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        AnimationPlaygroundView()
    }
}
