//
//  SelectionControlsDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct SelectionControlsDemo: View {
    @State private var toggleValue = false
    @State private var sliderValue = 0.5
    @State private var stepperValue = 0
    @State private var pickerSelection = 0
    @State private var segmentedSelection = 0
    @State private var selectedDate = Date()
    @State private var selectedColor = Color.blue
    @State private var menuSelection = "Option 1"
    
    let pickerOptions = ["Option 1", "Option 2", "Option 3", "Option 4"]
    let segmentedOptions = ["First", "Second", "Third"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("Selection Controls")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Toggle, Picker, Slider, Stepper, DatePicker, ColorPicker")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Toggle Controls
                VStack(spacing: 20) {
                    Text("Toggle Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Toggle("Basic Toggle", isOn: $toggleValue)
                        
                        Toggle("Switch Style", isOn: $toggleValue)
                            .toggleStyle(.switch)
                        
                        Toggle("Button Style", isOn: $toggleValue)
                            .toggleStyle(.button)
                        
                        Toggle(isOn: $toggleValue) {
                            Label("Custom Toggle", systemImage: "gear")
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                // Slider Controls
                VStack(spacing: 20) {
                    Text("Slider Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Basic Slider: \(sliderValue, specifier: "%.2f")")
                                .font(.caption)
                            Slider(value: $sliderValue, in: 0...1)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Stepped Slider: \(Int(sliderValue * 10))")
                                .font(.caption)
                            Slider(value: $sliderValue, in: 0...1, step: 0.1)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Labeled Slider")
                                .font(.caption)
                            Slider(value: $sliderValue, in: 0...1) {
                                Text("Volume")
                            } minimumValueLabel: {
                                Image(systemName: "speaker.fill")
                            } maximumValueLabel: {
                                Image(systemName: "speaker.3.fill")
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                // Stepper Controls
                VStack(spacing: 20) {
                    Text("Stepper Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Stepper("Value: \(stepperValue)", value: $stepperValue, in: 0...10)
                        
                        Stepper("Step by 5: \(stepperValue)", value: $stepperValue, in: 0...100, step: 5)
                        
                        Stepper(value: $stepperValue, in: 0...10) {
                            Label("Custom Stepper", systemImage: "plus.minus")
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                // Picker Controls
                VStack(spacing: 20) {
                    Text("Picker Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Picker("Menu Picker", selection: $pickerSelection) {
                            ForEach(0..<pickerOptions.count, id: \.self) { index in
                                Text(pickerOptions[index]).tag(index)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Picker("Segmented Picker", selection: $segmentedSelection) {
                            ForEach(0..<segmentedOptions.count, id: \.self) { index in
                                Text(segmentedOptions[index]).tag(index)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Picker("Wheel Picker", selection: $pickerSelection) {
                            ForEach(0..<pickerOptions.count, id: \.self) { index in
                                Text(pickerOptions[index]).tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 120)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                // Date & Color Pickers
                VStack(spacing: 20) {
                    Text("Date & Color Pickers")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        
                        DatePicker("Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        
                        DatePicker("Time Only", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        
                        ColorPicker("Select Color", selection: $selectedColor)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                // Selection Values Display
                VStack(spacing: 20) {
                    Text("Current Values")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Group {
                            Text("Toggle: \(toggleValue ? "ON" : "OFF")")
                            Text("Slider: \(sliderValue, specifier: "%.2f")")
                            Text("Stepper: \(stepperValue)")
                            Text("Picker: \(pickerOptions[pickerSelection])")
                            Text("Segmented: \(segmentedOptions[segmentedSelection])")
                            Text("Date: \(selectedDate, style: .date)")
                            Text("Color: \(selectedColor.description)")
                        }
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                // Control Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Selection Controls Guide")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        SelectionInfoRow(control: "Toggle", description: "Boolean on/off switch")
                        SelectionInfoRow(control: "Slider", description: "Continuous value selection")
                        SelectionInfoRow(control: "Stepper", description: "Discrete value increment/decrement")
                        SelectionInfoRow(control: "Picker", description: "Selection from multiple options")
                        SelectionInfoRow(control: "DatePicker", description: "Date and time selection")
                        SelectionInfoRow(control: "ColorPicker", description: "Color selection interface")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Selection Controls")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

struct SelectionInfoRow: View {
    let control: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(control)
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
        SelectionControlsDemo()
    }
}
