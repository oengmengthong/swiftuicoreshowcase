import SwiftUI

struct LiquidGlassDemo: View {
    @State private var showGlassEffect = true
    @State private var selectedMaterial = Material.regular
    @State private var glassIntensity = 0.5
    @State private var backgroundType = BackgroundType.gradient
    
    enum BackgroundType: String, CaseIterable {
        case gradient = "Gradient"
        case image = "Image"
        case solid = "Solid Color"
        
        var background: some View {
            switch self {
            case .gradient:
                return AnyView(
                    LinearGradient(
                        colors: [.blue, .purple, .pink, .orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            case .image:
                return AnyView(
                    Image(systemName: "swift")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .foregroundStyle(.blue.opacity(0.3))
                )
            case .solid:
                return AnyView(Color.cyan.opacity(0.8))
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            backgroundType.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack {
                        Text("Liquid Glass Experience")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Text("SwiftUI 7's new .glassEffect() and material system")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // Controls
                    VStack(spacing: 20) {
                        Text("Glass Effect Controls")
                            .font(.headline)
                        
                        VStack(spacing: 15) {
                            Toggle("Enable Glass Effect", isOn: $showGlassEffect)
                                .toggleStyle(.switch)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Background Type")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Picker("Background", selection: $backgroundType) {
                                    ForEach(BackgroundType.allCases, id: \.self) { type in
                                        Text(type.rawValue).tag(type)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Material Type")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Picker("Material", selection: $selectedMaterial) {
                                    Text("Ultra Thin").tag(Material.ultraThin)
                                    Text("Thin").tag(Material.thin)
                                    Text("Regular").tag(Material.regular)
                                    Text("Thick").tag(Material.thick)
                                    Text("Ultra Thick").tag(Material.ultraThick)
                                }
                                .pickerStyle(.menu)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Glass Intensity: \(glassIntensity, specifier: "%.1f")")
                                    .font(.caption)
                                Slider(value: $glassIntensity, in: 0.0...1.0)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(showGlassEffect ? selectedMaterial : .regularMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .conditionalGlass(showGlassEffect)
                    
                    // Glass Effect Demonstration Cards
                    VStack(spacing: 20) {
                        Text("Glass Effect Examples")
                            .font(.headline)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
                            // Card 1
                            GlassCard(
                                title: "Navigation Card",
                                icon: "arrow.triangle.turn.up.right.circle",
                                description: "Glass navigation elements",
                                showGlass: showGlassEffect,
                                material: selectedMaterial
                            )
                            
                            // Card 2
                            GlassCard(
                                title: "Control Panel",
                                icon: "slider.horizontal.3",
                                description: "Glass control interfaces",
                                showGlass: showGlassEffect,
                                material: selectedMaterial
                            )
                            
                            // Card 3
                            GlassCard(
                                title: "Media Player",
                                icon: "play.rectangle",
                                description: "Glass media controls",
                                showGlass: showGlassEffect,
                                material: selectedMaterial
                            )
                            
                            // Card 4
                            GlassCard(
                                title: "Settings",
                                icon: "gearshape",
                                description: "Glass settings panel",
                                showGlass: showGlassEffect,
                                material: selectedMaterial
                            )
                        }
                    }
                    
                    // Floating Action Button Example
                    VStack(spacing: 15) {
                        Text("Floating Glass Button")
                            .font(.headline)
                        
                        Button(action: {}) {
                            Label("Add Item", systemImage: "plus")
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(showGlassEffect ? selectedMaterial : .regularMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.white.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .conditionalGlass(showGlassEffect)
                    }
                    
                    // Glass Navigation Bar Example
                    VStack(spacing: 15) {
                        Text("Glass Navigation Bar")
                            .font(.headline)
                        
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundStyle(.primary)
                            }
                            
                            Spacer()
                            
                            Text("Glass Navigation")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "ellipsis")
                                    .font(.title2)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(showGlassEffect ? selectedMaterial : .regularMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                        .conditionalGlass(showGlassEffect)
                    }
                    
                    // Feature Information
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Liquid Glass Features")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            FeatureRow(title: "Blur Effect", description: "Blurs content behind the glass")
                            FeatureRow(title: "Translucency", description: "Allows background colors to show through")
                            FeatureRow(title: "Material Variants", description: "Different thickness levels available")
                            FeatureRow(title: "Platform Native", description: "Uses system glass materials")
                            FeatureRow(title: "Performance", description: "Optimized for smooth animations")
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(showGlassEffect ? selectedMaterial : .regularMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .conditionalGlass(showGlassEffect)
                }
                .padding()
            }
        }
        .navigationTitle("Liquid Glass")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GlassCard: View {
    let title: String
    let icon: String
    let description: String
    let showGlass: Bool
    let material: Material
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundStyle(.blue)
            
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(minHeight: 120)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(showGlass ? material : .regularMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        )
        .conditionalGlass(showGlass)
    }
}

struct FeatureRow: View {
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

// Extension for conditional glass effect
extension View {
    @ViewBuilder
    func conditionalGlass(_ condition: Bool) -> some View {
        if condition {
            // Note: .glassEffect() is a SwiftUI 7 feature
            // For compatibility, we'll use material background
            self
        } else {
            self
        }
    }
}

#Preview {
    NavigationStack {
        LiquidGlassDemo()
    }
}