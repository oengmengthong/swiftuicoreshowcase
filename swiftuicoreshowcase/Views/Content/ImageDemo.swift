//
//  ImageDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ImageDemo: View {
    @State private var selectedImageType = 0
    @State private var selectedResizeMode: ContentMode = .fit
    @State private var imageScale: CGFloat = 1.0
    @State private var isAnimating = false
    
    let imageTypes = ["SF Symbols", "System Images", "Async Images"]
    let resizeModes: [ContentMode] = [.fit, .fill]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // Image Type Selector
                imageTypeSelector
                
                // Image Content
                imageContentSection
                
                // SF Symbols Showcase
                sfSymbolsSection
                
                // Image Styling
                imageStylingSection
                
                // Async Image Demo
                asyncImageSection
            }
            .padding()
        }
        .navigationTitle("Image Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Image Display & Handling")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Image display, async loading, SF Symbols, and image processing in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var imageTypeSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Image Types")
                .font(.title2)
                .fontWeight(.semibold)
            
            Picker("Image Type", selection: $selectedImageType) {
                ForEach(0..<imageTypes.count, id: \.self) { index in
                    Text(imageTypes[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var imageContentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Image Display")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack {
                // Resize Mode Controls
                VStack(alignment: .leading, spacing: 8) {
                    Text("Resize Mode")
                        .font(.caption)
                    
                    Picker("Resize Mode", selection: $selectedResizeMode) {
                        Text("Fit").tag(ContentMode.fit)
                        Text("Fill").tag(ContentMode.fill)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Scale: \(imageScale, specifier: "%.1f")")
                        .font(.caption)
                    
                    Slider(value: $imageScale, in: 0.5...2.0, step: 0.1)
                }
                
                Spacer()
                
                // Sample Image
                sampleImageView
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var sampleImageView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 120, height: 120)
            
            Image(systemName: "photo")
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .aspectRatio(contentMode: selectedResizeMode)
                .scaleEffect(imageScale)
                .clipped()
        }
    }
    
    private var sfSymbolsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SF Symbols Showcase")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 16) {
                ForEach(sfSymbolNames, id: \.self) { symbolName in
                    VStack(spacing: 4) {
                        Image(systemName: symbolName)
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                            .frame(width: 40, height: 40)
                        
                        Text(symbolName)
                            .font(.caption2)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
            // Symbol Variants
            VStack(alignment: .leading, spacing: 8) {
                Text("Symbol Variants")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    VStack(spacing: 4) {
                        Image(systemName: "heart")
                            .font(.system(size: 24))
                        Text("None")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 24))
                        Text("Fill")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 4) {
                        Image(systemName: "heart.circle")
                            .font(.system(size: 24))
                        Text("Circle")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 4) {
                        Image(systemName: "heart.circle.fill")
                            .font(.system(size: 24))
                        Text("Circle Fill")
                            .font(.caption)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var imageStylingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Image Styling")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                // Original
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                    Text("Original")
                        .font(.caption)
                }
                
                // Rounded
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                        .clipShape(Circle())
                    Text("Clipped Circle")
                        .font(.caption)
                }
                
                // Shadow
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                        .shadow(color: .gray, radius: 3, x: 2, y: 2)
                    Text("Shadow")
                        .font(.caption)
                }
                
                // Rotated
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                        .rotationEffect(.degrees(45))
                    Text("Rotated")
                        .font(.caption)
                }
                
                // Gradient
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.red, .yellow, .green],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    Text("Gradient")
                        .font(.caption)
                }
                
                // Animated
                VStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                        .scaleEffect(isAnimating ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                        .onAppear {
                            isAnimating = true
                        }
                    Text("Animated")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var asyncImageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("AsyncImage Demo")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 16) {
                // Sample AsyncImage with placeholder
                AsyncImage(url: URL(string: "https://picsum.photos/300/200")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            VStack {
                                ProgressView()
                                    .scaleEffect(0.8)
                                Text("Loading...")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        )
                }
                .frame(height: 150)
                .cornerRadius(8)
                
                Text("AsyncImage with placeholder and error handling")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private let sfSymbolNames = [
        "star", "heart", "home", "person", "gear", "camera",
        "envelope", "phone", "bookmark", "trash", "pencil", "plus",
        "minus", "multiply", "divide", "equal", "chevron.right", "chevron.left",
        "arrow.up", "arrow.down", "arrow.right", "arrow.left", "location", "globe"
    ]
}

#Preview {
    NavigationView {
        ImageDemo()
    }
}
