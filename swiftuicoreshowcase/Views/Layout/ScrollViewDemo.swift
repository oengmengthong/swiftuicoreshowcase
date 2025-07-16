//
//  ScrollViewDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ScrollViewDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("Basic Scroll").tag(0)
                    Text("Horizontal").tag(1)
                    Text("Nested Scroll").tag(2)
                    Text("Scroll Reader").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    BasicScrollDemo()
                case 1:
                    HorizontalScrollDemo()
                case 2:
                    NestedScrollDemo()
                case 3:
                    ScrollReaderDemo()
                default:
                    BasicScrollDemo()
                }
            }
        }
        .navigationTitle("ScrollView Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BasicScrollDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<20, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Section \(index)")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(height: 100)
                            .overlay(
                                Text("Content \(index)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            )
                            .padding(.horizontal)
                        
                        Text("This is some sample content for section \(index). ScrollView automatically handles content that exceeds the visible area.")
                            .font(.body)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

struct HorizontalScrollDemo: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Horizontal ScrollView")
                .font(.headline)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<15, id: \.self) { index in
                        VStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.7))
                                .frame(width: 120, height: 150)
                                .overlay(
                                    VStack {
                                        Image(systemName: "photo")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                        
                                        Text("Item \(index)")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                )
                            
                            Text("Photo \(index)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Text("Bi-directional ScrollView")
                .font(.headline)
                .padding(.top)
            
            ScrollView([.horizontal, .vertical]) {
                VStack(spacing: 10) {
                    ForEach(0..<10, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<10, id: \.self) { col in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.green.opacity(0.6))
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Text("\(row),\(col)")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(height: 300)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding()
        }
    }
}

struct NestedScrollDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Nested ScrollViews")
                    .font(.headline)
                    .padding()
                
                ForEach(0..<5, id: \.self) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Section \(section)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<8, id: \.self) { item in
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.purple.opacity(0.6))
                                        .frame(width: 100, height: 100)
                                        .overlay(
                                            VStack {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.white)
                                                Text("\(section).\(item)")
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                            }
                                        )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}

struct ScrollReaderDemo: View {
    @State private var scrollTarget: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Jump to item:")
                TextField("Item number", value: $scrollTarget, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
            }
            .padding()
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0..<100, id: \.self) { index in
                            HStack {
                                Text("Item \(index)")
                                    .font(.headline)
                                Spacer()
                                Button("Jump Here") {
                                    scrollTarget = index
                                }
                                .font(.caption)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(index == scrollTarget ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                            )
                            .id(index)
                        }
                    }
                    .padding()
                }
                .onChange(of: scrollTarget) { _, newValue in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }
}
