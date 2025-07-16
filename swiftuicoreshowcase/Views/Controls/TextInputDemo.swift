import SwiftUI

struct TextInputDemo: View {
    @State private var basicText = ""
    @State private var multilineText = ""
    @State private var secureText = ""
    @State private var numberText = ""
    @State private var searchText = ""
    @State private var isEnabled = true
    @State private var selectedFormat = 0
    
    let textFormats = ["Default", "Number Pad", "Email", "URL", "Phone"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("Text Input Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("TextField, SecureField, TextEditor variations")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Basic Text Input
                VStack(spacing: 20) {
                    Text("Basic Text Input")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        TextField("Enter your name", text: $basicText)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Placeholder text", text: $basicText)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.blue)
                            TextField("With icon", text: $basicText)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
                
                // Secure Text Input
                VStack(spacing: 20) {
                    Text("Secure Text Input")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        SecureField("Password", text: $secureText)
                            .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.orange)
                            SecureField("Secure with icon", text: $secureText)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
                
                // Multi-line Text Input
                VStack(spacing: 20) {
                    Text("Multi-line Text Input")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        TextEditor(text: $multilineText)
                            .frame(minHeight: 100)
                            .padding(4)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        if multilineText.isEmpty {
                            Text("Enter your message here...")
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
                
                // Keyboard Types
                VStack(spacing: 20) {
                    Text("Keyboard Types")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Picker("Format", selection: $selectedFormat) {
                            ForEach(0..<textFormats.count, id: \.self) { index in
                                Text(textFormats[index]).tag(index)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        TextField("Number input", text: $numberText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Email input", text: $basicText)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("URL input", text: $basicText)
                            .keyboardType(.URL)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
                
                // Search Field
                VStack(spacing: 20) {
                    Text("Search Field")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)
                            TextField("Search...", text: $searchText)
                            
                            if !searchText.isEmpty {
                                Button(action: { searchText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(25)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
                
                // Text Input States
                VStack(spacing: 20) {
                    Text("Input States")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        Toggle("Enable Input Fields", isOn: $isEnabled)
                        
                        TextField("Enabled field", text: $basicText)
                            .textFieldStyle(.roundedBorder)
                            .disabled(!isEnabled)
                        
                        TextField("Disabled field", text: .constant("Disabled"))
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                            .foregroundStyle(.gray)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
                
                // Current Values Display
                VStack(spacing: 20) {
                    Text("Current Values")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Group {
                            Text("Basic Text: \"\(basicText)\"")
                            Text("Secure Text: \"\(String(repeating: "•", count: secureText.count))\"")
                            Text("Number Text: \"\(numberText)\"")
                            Text("Search Text: \"\(searchText)\"")
                            Text("Character Count: \(basicText.count)")
                        }
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
                
                // Text Input Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Text Input Types")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        TextInputInfoRow(type: "TextField", description: "Single-line text input")
                        TextInputInfoRow(type: "SecureField", description: "Password/secure text input")
                        TextInputInfoRow(type: "TextEditor", description: "Multi-line text editing")
                        TextInputInfoRow(type: "Search Field", description: "Search interface with clear button")
                        TextInputInfoRow(type: "Keyboard Types", description: "Specialized keyboards for different input")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("Text Input")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

struct TextInputInfoRow: View {
    let type: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(type)
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
        TextInputDemo()
    }
}