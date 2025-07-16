//
//  StackLayoutDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct StackLayoutDemo: View {
    @State private var selectedTab = 0
    @State private var spacing: CGFloat = 10
    @State private var selectedAlignment = 0 // 0 = leading, 1 = center, 2 = trailing
    
    private var alignment: HorizontalAlignment {
        switch selectedAlignment {
        case 0: return .leading
        case 1: return .center
        case 2: return .trailing
        default: return .center
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with controls
            VStack(spacing: 16) {
                Text("Stack Layout Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Tab selector
                Picker("Layout Type", selection: $selectedTab) {
                    Text("VStack").tag(0)
                    Text("HStack").tag(1)
                    Text("ZStack").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // Controls
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Spacing: \(Int(spacing))")
                            .font(.caption)
                        Slider(value: $spacing, in: 0...50)
                    }
                    
                    if selectedTab == 0 { // VStack
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Alignment")
                                .font(.caption)
                            Picker("Alignment", selection: $selectedAlignment) {
                                Text("Leading").tag(0)
                                Text("Center").tag(1)
                                Text("Trailing").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
            
            Divider()
            
            // Demo area
            ScrollView {
                VStack(spacing: 20) {
                    // Live demo
                    Group {
                        switch selectedTab {
                        case 0:
                            VStackDemo(spacing: spacing, alignment: alignment)
                        case 1:
                            HStackDemo(spacing: spacing)
                        case 2:
                            ZStackDemo()
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Code example
                    CodeExampleView(selectedTab: selectedTab, spacing: spacing, alignment: alignment)
                }
                .padding()
            }
        }
        .navigationTitle("Stack Layouts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VStackDemo: View {
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor)
                    .frame(width: CGFloat(50 + index * 30), height: 40)
                    .overlay(
                        Text("Item \(index + 1)")
                            .foregroundColor(.white)
                            .font(.caption)
                    )
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct HStackDemo: View {
    let spacing: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(0..<8) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor)
                        .frame(width: 60, height: CGFloat(40 + index * 10))
                        .overlay(
                            Text("\(index + 1)")
                                .foregroundColor(.white)
                                .font(.caption)
                        )
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct ZStackDemo: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.3))
                .frame(width: 200, height: 200)
            
            // Middle layer
            Circle()
                .fill(Color.green.opacity(0.6))
                .frame(width: 120, height: 120)
            
            // Top layer
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.red.opacity(0.8))
                .frame(width: 60, height: 60)
            
            // Text overlay
            Text("ZStack")
                .font(.headline)
                .foregroundColor(.white)
                .shadow(radius: 1)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct CodeExampleView: View {
    let selectedTab: Int
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Code Example")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                Text(codeExample)
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    var codeExample: String {
        switch selectedTab {
        case 0:
            return """
VStack(alignment: .\(alignmentString), spacing: \(Int(spacing))) {
    ForEach(0..<5) { index in
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.accentColor)
            .frame(width: CGFloat(50 + index * 30), height: 40)
    }
}
"""
        case 1:
            return """
HStack(spacing: \(Int(spacing))) {
    ForEach(0..<8) { index in
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.accentColor)
            .frame(width: 60, height: CGFloat(40 + index * 10))
    }
}
"""
        case 2:
            return """
ZStack {
    RoundedRectangle(cornerRadius: 12)
        .fill(Color.blue.opacity(0.3))
        .frame(width: 200, height: 200)
    
    Circle()
        .fill(Color.green.opacity(0.6))
        .frame(width: 120, height: 120)
    
    RoundedRectangle(cornerRadius: 6)
        .fill(Color.red.opacity(0.8))
        .frame(width: 60, height: 60)
}
"""
        default:
            return ""
        }
    }
    
    var alignmentString: String {
        switch alignment {
        case .leading: return "leading"
        case .center: return "center"
        case .trailing: return "trailing"
        default: return "center"
        }
    }
}

#Preview {
    NavigationStack {
        StackLayoutDemo()
    }
}
