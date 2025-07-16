//
//  LazyStackDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct LazyStackDemo: View {
    @State private var selectedDemo = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Demo Type", selection: $selectedDemo) {
                    Text("LazyVStack").tag(0)
                    Text("LazyHStack").tag(1)
                    Text("Performance Test").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedDemo {
                case 0:
                    LazyVStackDemo()
                case 1:
                    LazyHStackDemo()
                case 2:
                    PerformanceTestDemo()
                default:
                    LazyVStackDemo()
                }
            }
        }
        .navigationTitle("Lazy Stack Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LazyVStackDemo: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<1000, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Item \(index)")
                                .font(.headline)
                            Text("This is a lazy loaded item")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("Row \(index)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .onAppear {
                        // This will only be called when the view appears
                        print("LazyVStack item \(index) appeared")
                    }
                }
            }
            .padding()
        }
    }
}

struct LazyHStackDemo: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(0..<100, id: \.self) { index in
                    VStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 150, height: 200)
                            .overlay(
                                VStack {
                                    Text("\(index)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text("Card")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            )
                        
                        Text("Item \(index)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .onAppear {
                        print("LazyHStack item \(index) appeared")
                    }
                }
            }
            .padding()
        }
    }
}

struct PerformanceTestDemo: View {
    @State private var isLazy = true
    @State private var itemCount = 500
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Use Lazy Stack:")
                    Spacer()
                    Toggle("", isOn: $isLazy)
                }
                
                HStack {
                    Text("Item Count: \(itemCount)")
                    Spacer()
                    Stepper("", value: $itemCount, in: 100...2000, step: 100)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding()
            
            Text(isLazy ? "LazyVStack (Efficient)" : "VStack (All items rendered)")
                .font(.headline)
                .foregroundColor(isLazy ? .green : .red)
            
            ScrollView {
                if isLazy {
                    LazyVStack(spacing: 5) {
                        ForEach(0..<itemCount, id: \.self) { index in
                            PerformanceTestRow(index: index)
                        }
                    }
                } else {
                    VStack(spacing: 5) {
                        ForEach(0..<itemCount, id: \.self) { index in
                            PerformanceTestRow(index: index)
                        }
                    }
                }
            }
        }
    }
}

struct PerformanceTestRow: View {
    let index: Int
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.random)
                .frame(width: 30, height: 30)
            
            Text("Performance Test Row \(index)")
                .font(.body)
            
            Spacer()
            
            Text(Date().formatted(.dateTime.hour().minute().second()))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.05))
        .onAppear {
            print("Row \(index) rendered at \(Date())")
        }
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
