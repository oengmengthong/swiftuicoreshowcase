import SwiftUI

struct ControlsGalleryView: View {
    @State private var toggleValue = false
    @State private var sliderValue = 0.5
    @State private var stepperValue = 0
    @State private var textInput = ""
    @State private var secureText = ""
    @State private var selectedOption = 0
    @State private var selectedDate = Date()
    @State private var selectedColor = Color.blue
    @State private var progressValue = 0.3
    @State private var gaugeValue = 0.7
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("Controls Gallery")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Every interactive control with live bindings")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Input Controls
                VStack(spacing: 20) {
                    Text("Input Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        TextField("Enter text here", text: $textInput)
                            .textFieldStyle(.roundedBorder)
                        
                        SecureField("Enter password", text: $secureText)
                            .textFieldStyle(.roundedBorder)
                        
                        TextEditor(text: $textInput)
                            .frame(height: 80)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Selection Controls
                VStack(spacing: 20) {
                    Text("Selection Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Toggle("Toggle Switch", isOn: $toggleValue)
                        
                        HStack {
                            Text("Slider")
                            Slider(value: $sliderValue, in: 0...1)
                            Text("\(sliderValue, specifier: "%.2f")")
                        }
                        
                        Stepper("Stepper: \(stepperValue)", value: $stepperValue, in: 0...10)
                        
                        Picker("Options", selection: $selectedOption) {
                            Text("Option 1").tag(0)
                            Text("Option 2").tag(1)
                            Text("Option 3").tag(2)
                        }
                        .pickerStyle(.segmented)
                        
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        
                        ColorPicker("Pick Color", selection: $selectedColor)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Progress & Status
                VStack(spacing: 20) {
                    Text("Progress & Status")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        ProgressView("Progress", value: progressValue)
                        
                        ProgressView()
                            .scaleEffect(1.5)
                        
                        Gauge(value: gaugeValue, in: 0...1) {
                            Text("Gauge")
                        }
                        .gaugeStyle(.accessoryCircular)
                        
                        LabeledContent("Status", value: "Active")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Buttons
                VStack(spacing: 20) {
                    Text("Button Variations")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Button("Default Button") { }
                        
                        Button("Prominent Button") { }
                            .buttonStyle(.borderedProminent)
                        
                        Button("Bordered Button") { }
                            .buttonStyle(.bordered)
                        
                        Button("Plain Button") { }
                            .buttonStyle(.plain)
                        
                        Button(action: { showingSheet = true }) {
                            Label("Show Sheet", systemImage: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Show Alert") {
                            showingAlert = true
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Menu Controls
                VStack(spacing: 20) {
                    Text("Menu Controls")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Menu("Menu Button") {
                            Button("Action 1") { }
                            Button("Action 2") { }
                            Button("Action 3") { }
                        }
                        
                        ShareLink("Share Link", item: "Hello, SwiftUI!")
                        
                        if #available(iOS 16.0, *) {
                            PasteButton(payloadType: String.self) { strings in
                                textInput = strings.first ?? ""
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // Control Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("SwiftUI Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ControlInfoRow(title: "TextField", description: "Single-line text input")
                        ControlInfoRow(title: "SecureField", description: "Password input field")
                        ControlInfoRow(title: "TextEditor", description: "Multi-line text editing")
                        ControlInfoRow(title: "Toggle", description: "On/off switch control")
                        ControlInfoRow(title: "Slider", description: "Continuous value selection")
                        ControlInfoRow(title: "Stepper", description: "Discrete value increment")
                        ControlInfoRow(title: "Picker", description: "Selection from options")
                        ControlInfoRow(title: "DatePicker", description: "Date and time selection")
                        ControlInfoRow(title: "ColorPicker", description: "Color selection interface")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Controls Gallery")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                Text("Sheet Content")
                    .navigationTitle("Sheet")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                showingSheet = false
                            }
                        }
                    }
            }
        }
        .alert("Alert Example", isPresented: $showingAlert) {
            Button("OK") { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This is an example alert dialog.")
        }
    }
}

struct ControlInfoRow: View {
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
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
        ControlsGalleryView()
    }
}