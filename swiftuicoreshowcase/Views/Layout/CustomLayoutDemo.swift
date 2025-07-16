//
//  CustomLayoutDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct CustomLayoutDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Flow Layout").tag(0)
                    Text("Radial Layout").tag(1)
                    Text("Masonry Layout").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    FlowLayoutDemo()
                case 1:
                    RadialLayoutDemo()
                case 2:
                    MasonryLayoutDemo()
                default:
                    FlowLayoutDemo()
                }
            }
        }
        .navigationTitle("Custom Layout Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Flow Layout
struct FlowLayoutDemo: View {
    @State private var spacing: CGFloat = 8
    @State private var alignmentIndex: Int = 0
    
    private var alignment: HorizontalAlignment {
        switch alignmentIndex {
        case 1: return .center
        case 2: return .trailing
        default: return .leading
        }
    }
    
    let items = ["SwiftUI", "iOS", "macOS", "watchOS", "tvOS", "Layout", "Custom", "Protocol", "View", "Stack", "Grid", "List", "ScrollView", "LazyVStack", "LazyHStack", "Spacer", "Divider", "Button", "Text", "Image"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Spacing: \(spacing, specifier: "%.0f")")
                        Slider(value: $spacing, in: 0...20)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Alignment:")
                        Picker("Alignment", selection: $alignmentIndex) {
                            Text("Leading").tag(0)
                            Text("Center").tag(1)
                            Text("Trailing").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Flow Layout Example
                VStack(spacing: 20) {
                    Text("Flow Layout")
                        .font(.headline)
                    
                    FlowLayout(spacing: spacing, alignment: alignment) {
                        ForEach(items, id: \.self) { item in
                            Text(item)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(16)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(12)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat
    var alignment: HorizontalAlignment
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        
        let width = proposal.width ?? 0
        var height: CGFloat = 0
        var currentRowHeight: CGFloat = 0
        var currentX: CGFloat = 0
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            
            if currentX + subviewSize.width > width && currentX > 0 {
                // Move to next row
                height += currentRowHeight + spacing
                currentRowHeight = subviewSize.height
                currentX = subviewSize.width + spacing
            } else {
                // Continue in current row
                currentRowHeight = max(currentRowHeight, subviewSize.height)
                currentX += subviewSize.width + spacing
            }
        }
        
        height += currentRowHeight
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY
        var currentRowHeight: CGFloat = 0
        var rowSubviews: [(subview: LayoutSubview, size: CGSize)] = []
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            
            if currentX + subviewSize.width > bounds.maxX && currentX > bounds.minX {
                // Place current row
                placeRow(rowSubviews, at: currentY, in: bounds, rowHeight: currentRowHeight)
                
                // Start new row
                currentX = bounds.minX
                currentY += currentRowHeight + spacing
                currentRowHeight = 0
                rowSubviews.removeAll()
            }
            
            rowSubviews.append((subview, subviewSize))
            currentX += subviewSize.width + spacing
            currentRowHeight = max(currentRowHeight, subviewSize.height)
        }
        
        // Place last row
        if !rowSubviews.isEmpty {
            placeRow(rowSubviews, at: currentY, in: bounds, rowHeight: currentRowHeight)
        }
    }
    
    private func placeRow(_ rowSubviews: [(subview: LayoutSubview, size: CGSize)], at y: CGFloat, in bounds: CGRect, rowHeight: CGFloat) {
        let totalWidth = rowSubviews.reduce(0) { $0 + $1.size.width } + CGFloat(rowSubviews.count - 1) * spacing
        
        var startX: CGFloat
        switch alignment {
        case .leading:
            startX = bounds.minX
        case .center:
            startX = bounds.minX + (bounds.width - totalWidth) / 2
        case .trailing:
            startX = bounds.maxX - totalWidth
        default:
            startX = bounds.minX
        }
        
        var currentX = startX
        for (subview, size) in rowSubviews {
            let yPosition = y + (rowHeight - size.height) / 2
            subview.place(at: CGPoint(x: currentX, y: yPosition), proposal: ProposedViewSize(size))
            currentX += size.width + spacing
        }
    }
}

// MARK: - Radial Layout
struct RadialLayoutDemo: View {
    @State private var radius: CGFloat = 80
    @State private var startAngle: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Radius: \(radius, specifier: "%.0f")")
                        Slider(value: $radius, in: 40...120)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Start Angle: \(startAngle, specifier: "%.0f")°")
                        Slider(value: $startAngle, in: 0...360)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Radial Layout Example
                VStack(spacing: 20) {
                    Text("Radial Layout")
                        .font(.headline)
                    
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                            .frame(width: radius * 2, height: radius * 2)
                        
                        RadialLayout(radius: radius, startAngle: startAngle) {
                            ForEach(0..<8, id: \.self) { index in
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Text("\(index)")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                    }
                    .frame(height: 300)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Multiple Radial Layouts
                VStack(spacing: 20) {
                    Text("Multiple Radial Layouts")
                        .font(.headline)
                    
                    HStack(spacing: 40) {
                        RadialLayout(radius: 50) {
                            ForEach(0..<6, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.red)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        
                        RadialLayout(radius: 60, startAngle: 30) {
                            ForEach(0..<5, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.green)
                                    .frame(width: 24, height: 24)
                            }
                        }
                        
                        RadialLayout(radius: 45, startAngle: 45) {
                            ForEach(0..<4, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.purple)
                                    .frame(width: 28, height: 28)
                            }
                        }
                    }
                    .frame(height: 200)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct RadialLayout: Layout {
    var radius: CGFloat
    var startAngle: CGFloat = 0
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let diameter = radius * 2
        return CGSize(width: diameter, height: diameter)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let angleStep = 360.0 / Double(subviews.count)
        
        for (index, subview) in subviews.enumerated() {
            let angle = startAngle + CGFloat(Double(index) * angleStep)
            let radians = angle * .pi / 180
            
            let x = center.x + radius * cos(radians)
            let y = center.y + radius * sin(radians)
            
            let subviewSize = subview.sizeThatFits(.unspecified)
            let position = CGPoint(
                x: x - subviewSize.width / 2,
                y: y - subviewSize.height / 2
            )
            
            subview.place(at: position, proposal: ProposedViewSize(subviewSize))
        }
    }
}

// MARK: - Masonry Layout
struct MasonryLayoutDemo: View {
    @State private var columnCount: Int = 2
    @State private var spacing: CGFloat = 8
    
    let items = Array(0..<20).map { index in
        MasonryItem(
            id: index,
            height: CGFloat.random(in: 60...200),
            color: Color.random
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Controls
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controls")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Columns: \(columnCount)")
                        Stepper("", value: $columnCount, in: 1...4)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Spacing: \(spacing, specifier: "%.0f")")
                        Slider(value: $spacing, in: 0...20)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Masonry Layout Example
                VStack(spacing: 20) {
                    Text("Masonry Layout")
                        .font(.headline)
                    
                    MasonryLayout(columnCount: columnCount, spacing: spacing) {
                        ForEach(items, id: \.id) { item in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(item.color)
                                .frame(height: item.height)
                                .overlay(
                                    Text("\(item.id)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                )
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
}

struct MasonryItem {
    let id: Int
    let height: CGFloat
    let color: Color
}

struct MasonryLayout: Layout {
    var columnCount: Int
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        
        let width = proposal.width ?? 0
        let columnWidth = (width - CGFloat(columnCount - 1) * spacing) / CGFloat(columnCount)
        
        var columnHeights = Array(repeating: CGFloat(0), count: columnCount)
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(ProposedViewSize(width: columnWidth, height: nil))
            let shortestColumnIndex = columnHeights.indices.min(by: { columnHeights[$0] < columnHeights[$1] }) ?? 0
            
            if columnHeights[shortestColumnIndex] > 0 {
                columnHeights[shortestColumnIndex] += spacing
            }
            columnHeights[shortestColumnIndex] += subviewSize.height
        }
        
        let totalHeight = columnHeights.max() ?? 0
        return CGSize(width: width, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let columnWidth = (bounds.width - CGFloat(columnCount - 1) * spacing) / CGFloat(columnCount)
        var columnHeights = Array(repeating: CGFloat(0), count: columnCount)
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(ProposedViewSize(width: columnWidth, height: nil))
            let shortestColumnIndex = columnHeights.indices.min(by: { columnHeights[$0] < columnHeights[$1] }) ?? 0
            
            if columnHeights[shortestColumnIndex] > 0 {
                columnHeights[shortestColumnIndex] += spacing
            }
            
            let x = bounds.minX + CGFloat(shortestColumnIndex) * (columnWidth + spacing)
            let y = bounds.minY + columnHeights[shortestColumnIndex]
            
            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: columnWidth, height: subviewSize.height)
            )
            
            columnHeights[shortestColumnIndex] += subviewSize.height
        }
    }
}
