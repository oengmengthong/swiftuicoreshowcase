//
//  ProgressDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ProgressDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("ProgressView").tag(0)
                    Text("Gauge").tag(1)
                    Text("Custom Progress").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    ProgressViewDemo()
                case 1:
                    GaugeDemo()
                case 2:
                    CustomProgressDemo()
                default:
                    ProgressViewDemo()
                }
            }
        }
        .navigationTitle("Progress Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProgressViewDemo: View {
    @State private var progress: Double = 0.0
    @State private var isIndeterminate = false
    @State private var timer: Timer?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controls")
                        .font(.headline)
                    
                    HStack {
                        Text("Progress: \(progress, specifier: "%.1f")")
                        Spacer()
                        Slider(value: $progress, in: 0...1)
                            .frame(width: 200)
                    }
                    
                    HStack {
                        Text("Indeterminate:")
                        Spacer()
                        Toggle("", isOn: $isIndeterminate)
                    }
                    
                    HStack {
                        Button("Start Animation") {
                            startProgress()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Stop") {
                            stopProgress()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Basic ProgressView
                VStack(alignment: .leading, spacing: 15) {
                    Text("Basic ProgressView")
                        .font(.headline)
                    
                    if isIndeterminate {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        ProgressView(value: progress)
                        ProgressView(value: progress) {
                            Text("Loading...")
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Styled ProgressView
                VStack(alignment: .leading, spacing: 15) {
                    Text("Styled ProgressView")
                        .font(.headline)
                    
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                    
                    ProgressView(value: progress)
                        .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                        .scaleEffect(1.5)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Progress with Label
                VStack(alignment: .leading, spacing: 15) {
                    Text("Progress with Labels")
                        .font(.headline)
                    
                    ProgressView("Downloading...", value: progress, total: 1.0)
                    
                    ProgressView(value: progress, total: 1.0) {
                        Text("Custom Label")
                            .font(.caption)
                    } currentValueLabel: {
                        Text("\(Int(progress * 100))%")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .progressViewStyle(LinearProgressViewStyle())
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
        .onDisappear {
            stopProgress()
        }
    }
    
    private func startProgress() {
        progress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if progress < 1.0 {
                progress += 0.02
            } else {
                stopProgress()
            }
        }
    }
    
    private func stopProgress() {
        timer?.invalidate()
        timer = nil
    }
}

struct GaugeDemo: View {
    @State private var value: Double = 0.5
    @State private var minValue: Double = 0.0
    @State private var maxValue: Double = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controls")
                        .font(.headline)
                    
                    HStack {
                        Text("Value: \(value, specifier: "%.2f")")
                        Spacer()
                        Slider(value: $value, in: minValue...maxValue)
                            .frame(width: 200)
                    }
                    
                    HStack {
                        Text("Range: \(minValue, specifier: "%.1f") - \(maxValue, specifier: "%.1f")")
                        Spacer()
                        Button("Reset") {
                            value = 0.5
                            minValue = 0.0
                            maxValue = 1.0
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Basic Gauge
                VStack(spacing: 15) {
                    Text("Basic Gauge")
                        .font(.headline)
                    
                    Gauge(value: value, in: minValue...maxValue) {
                        Text("Speed")
                    }
                    .gaugeStyle(.accessoryLinear)
                    
                    Gauge(value: value, in: minValue...maxValue) {
                        Text("Temperature")
                    }
                    .gaugeStyle(.accessoryCircular)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Gauge with Current Value Label
                VStack(spacing: 15) {
                    Text("Gauge with Current Value")
                        .font(.headline)
                    
                    Gauge(value: value, in: minValue...maxValue) {
                        Text("Progress")
                    } currentValueLabel: {
                        Text("\(Int(value * 100))%")
                            .font(.caption)
                    }
                    .gaugeStyle(.accessoryLinear)
                    
                    Gauge(value: value, in: minValue...maxValue) {
                        Text("Level")
                    } currentValueLabel: {
                        Text(value, format: .number.precision(.fractionLength(2)))
                            .font(.caption)
                    }
                    .gaugeStyle(.accessoryCircular)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Gauge with Min/Max Labels
                VStack(spacing: 15) {
                    Text("Gauge with Min/Max Labels")
                        .font(.headline)
                    
                    Gauge(value: value, in: minValue...maxValue) {
                        Text("Battery")
                    } currentValueLabel: {
                        Text("\(Int(value * 100))%")
                    } minimumValueLabel: {
                        Text("0%")
                            .font(.caption)
                    } maximumValueLabel: {
                        Text("100%")
                            .font(.caption)
                    }
                    .gaugeStyle(.accessoryLinear)
                    .tint(.green)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct CustomProgressDemo: View {
    @State private var progress: Double = 0.3
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack {
                    HStack {
                        Text("Progress: \(progress, specifier: "%.1f")")
                        Spacer()
                        Slider(value: $progress, in: 0...1)
                            .frame(width: 200)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Custom Ring Progress
                VStack(spacing: 15) {
                    Text("Custom Ring Progress")
                        .font(.headline)
                    
                    CustomRingProgress(progress: progress)
                        .frame(width: 120, height: 120)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Custom Bar Progress
                VStack(spacing: 15) {
                    Text("Custom Bar Progress")
                        .font(.headline)
                    
                    CustomBarProgress(progress: progress)
                        .frame(height: 20)
                    
                    CustomBarProgress(progress: progress, cornerRadius: 4, backgroundColor: .gray.opacity(0.2), foregroundColor: .orange)
                        .frame(height: 12)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Custom Stepped Progress
                VStack(spacing: 15) {
                    Text("Custom Stepped Progress")
                        .font(.headline)
                    
                    CustomSteppedProgress(progress: progress, steps: 5)
                        .frame(height: 30)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct CustomRingProgress: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)
            
            Text("\(Int(progress * 100))%")
                .font(.headline)
                .fontWeight(.bold)
        }
    }
}

struct CustomBarProgress: View {
    let progress: Double
    let cornerRadius: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    
    init(progress: Double, cornerRadius: CGFloat = 10, backgroundColor: Color = .gray.opacity(0.3), foregroundColor: Color = .blue) {
        self.progress = progress
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(foregroundColor)
                    .frame(width: geometry.size.width * progress)
                    .animation(.easeInOut(duration: 0.5), value: progress)
            }
        }
    }
}

struct CustomSteppedProgress: View {
    let progress: Double
    let steps: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<steps, id: \.self) { index in
                let stepProgress = Double(index + 1) / Double(steps)
                RoundedRectangle(cornerRadius: 6)
                    .fill(progress >= stepProgress ? .green : .gray.opacity(0.3))
                    .animation(.easeInOut(duration: 0.3).delay(Double(index) * 0.1), value: progress)
            }
        }
    }
}
