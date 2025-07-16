//
//  TextDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct TextDemo: View {
    @State private var dynamicTypeSize: DynamicTypeSize = .medium
    @State private var selectedFont: String = "System"
    @State private var isMarkdownEnabled = false
    
    let fonts = ["System", "Monospaced", "Rounded", "Serif"]
    let sampleText = "The quick brown fox jumps over the lazy dog"
    let markdownText = "**Bold text**, *italic text*, `code text`, and [link](https://swift.org)"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // Basic Text Styles
                textStylesSection
                
                // Font Variations
                fontVariationsSection
                
                // Dynamic Type
                dynamicTypeSection
                
                // Markdown Support
                markdownSection
                
                // Text Effects
                textEffectsSection
                
                // Multiline Text
                multilineTextSection
            }
            .padding()
        }
        .navigationTitle("Text Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Text Styling & Formatting")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Comprehensive text styling, fonts, and typography options in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var textStylesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Font Styles")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Large Title").font(.largeTitle)
                Text("Title").font(.title)
                Text("Title 2").font(.title2)
                Text("Title 3").font(.title3)
                Text("Headline").font(.headline)
                Text("Subheadline").font(.subheadline)
                Text("Body").font(.body)
                Text("Callout").font(.callout)
                Text("Footnote").font(.footnote)
                Text("Caption").font(.caption)
                Text("Caption 2").font(.caption2)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var fontVariationsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Font Variations")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("System Font").font(.system(size: 16))
                Text("Monospaced Font").font(.system(size: 16, design: .monospaced))
                Text("Rounded Font").font(.system(size: 16, design: .rounded))
                Text("Serif Font").font(.system(size: 16, design: .serif))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Ultralight Weight").fontWeight(.ultraLight)
                Text("Thin Weight").fontWeight(.thin)
                Text("Light Weight").fontWeight(.light)
                Text("Regular Weight").fontWeight(.regular)
                Text("Medium Weight").fontWeight(.medium)
                Text("Semibold Weight").fontWeight(.semibold)
                Text("Bold Weight").fontWeight(.bold)
                Text("Heavy Weight").fontWeight(.heavy)
                Text("Black Weight").fontWeight(.black)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var dynamicTypeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Dynamic Type Support")
                .font(.title2)
                .fontWeight(.semibold)
            
            Picker("Dynamic Type Size", selection: $dynamicTypeSize) {
                Text("XS").tag(DynamicTypeSize.xSmall)
                Text("S").tag(DynamicTypeSize.small)
                Text("M").tag(DynamicTypeSize.medium)
                Text("L").tag(DynamicTypeSize.large)
                Text("XL").tag(DynamicTypeSize.xLarge)
                Text("XXL").tag(DynamicTypeSize.xxLarge)
                Text("XXXL").tag(DynamicTypeSize.xxxLarge)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("This text adapts to the selected dynamic type size")
                .font(.body)
                .dynamicTypeSize(dynamicTypeSize)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var markdownSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Markdown Support")
                .font(.title2)
                .fontWeight(.semibold)
            
            Toggle("Enable Markdown", isOn: $isMarkdownEnabled)
            
            if isMarkdownEnabled {
                Text(.init(markdownText))
                    .font(.body)
            } else {
                Text(markdownText)
                    .font(.body)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var textEffectsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Text Effects")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Colored Text")
                    .foregroundColor(.blue)
                
                Text("Gradient Text")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.red, .blue, .green],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("Text with Shadow")
                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
                
                Text("Strikethrough Text")
                    .strikethrough()
                
                Text("Underlined Text")
                    .underline()
                
                Text("Italic Text")
                    .italic()
                
                Text("Kerning Adjusted")
                    .kerning(2)
                
                Text("Tracking Adjusted")
                    .tracking(3)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var multilineTextSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Multiline Text")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("This is a long text that demonstrates how SwiftUI handles multiline text content. It automatically wraps to multiple lines when the content exceeds the available width.")
                .font(.body)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            Text("Center Aligned Text")
                .font(.body)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            Text("Trailing Aligned Text")
                .font(.body)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity)
            
            Text("Limited to 2 lines with truncation...")
                .font(.body)
                .lineLimit(2)
                .truncationMode(.tail)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    NavigationView {
        TextDemo()
    }
}
