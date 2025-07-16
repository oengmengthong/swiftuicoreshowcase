//
//  GridLayoutDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct GridLayoutDemo: View {
    @State private var selectedGridType = 0
    @State private var columnCount: Double = 3
    @State private var spacing: CGFloat = 10
    @State private var itemCount: Double = 20
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with controls
            VStack(spacing: 16) {
                Text("Grid Layout Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Grid type selector
                Picker("Grid Type", selection: $selectedGridType) {
                    Text("LazyVGrid").tag(0)
                    Text("LazyHGrid").tag(1)
                    Text("Grid").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // Controls
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Columns: \(Int(columnCount))")
                            .font(.caption)
                        Slider(value: $columnCount, in: 2...6, step: 1)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Spacing: \(Int(spacing))")
                            .font(.caption)
                        Slider(value: $spacing, in: 0...30)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Items: \(Int(itemCount))")
                            .font(.caption)
                        Slider(value: $itemCount, in: 10...100, step: 5)
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
                        switch selectedGridType {
                        case 0:
                            LazyVGridDemo(
                                columnCount: Int(columnCount),
                                spacing: spacing,
                                itemCount: Int(itemCount)
                            )
                        case 1:
                            LazyHGridDemo(
                                rowCount: Int(columnCount),
                                spacing: spacing,
                                itemCount: Int(itemCount)
                            )
                        case 2:
                            RegularGridDemo(
                                columnCount: Int(columnCount),
                                spacing: spacing,
                                itemCount: Int(itemCount)
                            )
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Grid item types explanation
                    GridItemTypesView()
                    
                    // Code example
                    GridCodeExampleView(
                        gridType: selectedGridType,
                        columnCount: Int(columnCount),
                        spacing: spacing
                    )
                }
                .padding()
            }
        }
        .navigationTitle("Grid Layouts")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

struct LazyVGridDemo: View {
    let columnCount: Int
    let spacing: CGFloat
    let itemCount: Int
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnCount)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(0..<itemCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.accentColor)
                        .frame(height: CGFloat.random(in: 60...120))
                        .overlay(
                            Text("\(index + 1)")
                                .foregroundColor(.white)
                                .font(.caption)
                        )
                }
            }
            .padding()
        }
        .frame(height: 300)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct LazyHGridDemo: View {
    let rowCount: Int
    let spacing: CGFloat
    let itemCount: Int
    
    private var rows: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: rowCount)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: spacing) {
                ForEach(0..<itemCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.green)
                        .frame(width: CGFloat.random(in: 60...120))
                        .overlay(
                            Text("\(index + 1)")
                                .foregroundColor(.white)
                                .font(.caption)
                        )
                }
            }
            .padding()
        }
        .frame(height: 200)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct RegularGridDemo: View {
    let columnCount: Int
    let spacing: CGFloat
    let itemCount: Int
    
    var body: some View {
        Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
            ForEach(0..<(itemCount / columnCount), id: \.self) { row in
                GridRow {
                    ForEach(0..<columnCount, id: \.self) { column in
                        let index = row * columnCount + column
                        if index < itemCount {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.orange)
                                .frame(height: 60)
                                .overlay(
                                    Text("\(index + 1)")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct GridItemTypesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("GridItem Types")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("• .flexible()")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("- Expands to fill available space")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("• .fixed(width)")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("- Fixed width column")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("• .adaptive(minimum: width)")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("- Adaptive column count")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            // Example of different grid item types
            LazyVGrid(columns: [
                GridItem(.fixed(80)),
                GridItem(.flexible()),
                GridItem(.adaptive(minimum: 50))
            ], spacing: 8) {
                ForEach(0..<6) { index in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.purple.opacity(0.6))
                        .frame(height: 40)
                        .overlay(
                            Text("\(index + 1)")
                                .foregroundColor(.white)
                                .font(.caption)
                        )
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct GridCodeExampleView: View {
    let gridType: Int
    let columnCount: Int
    let spacing: CGFloat
    
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
        switch gridType {
        case 0:
            return """
let columns = Array(repeating: GridItem(.flexible(), spacing: \(Int(spacing))), count: \(columnCount))

LazyVGrid(columns: columns, spacing: \(Int(spacing))) {
    ForEach(0..<itemCount, id: \\.self) { index in
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.accentColor)
            .frame(height: 80)
    }
}
"""
        case 1:
            return """
let rows = Array(repeating: GridItem(.flexible(), spacing: \(Int(spacing))), count: \(columnCount))

LazyHGrid(rows: rows, spacing: \(Int(spacing))) {
    ForEach(0..<itemCount, id: \\.self) { index in
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.green)
            .frame(width: 80)
    }
}
"""
        case 2:
            return """
Grid(horizontalSpacing: \(Int(spacing)), verticalSpacing: \(Int(spacing))) {
    ForEach(0..<rowCount, id: \\.self) { row in
        GridRow {
            ForEach(0..<\(columnCount), id: \\.self) { column in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.orange)
                    .frame(height: 60)
            }
        }
    }
}
"""
        default:
            return ""
        }
    }
}

#Preview {
    NavigationStack {
        GridLayoutDemo()
    }
}
