import SwiftUI

struct LiquidGlassDemo: View {
    @State private var showGlassEffect = true
    @State private var glassIntensity = 0.5
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [.blue, .purple, .pink, .orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack {
                        Text("Liquid Glass Experience")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Modern glass morphism with SwiftUI")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding()
                    
                    // Glass Panel
                    if showGlassEffect {
                        GlassPanel()
                    }
                    
                    // Controls
                    VStack(spacing: 20) {
                        Toggle("Show Glass Effect", isOn: $showGlassEffect)
                            .foregroundColor(.white)
                        
                        VStack {
                            Text("Glass Intensity: \(glassIntensity, specifier: "%.1f")")
                                .foregroundColor(.white)
                            Slider(value: $glassIntensity, in: 0...1)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle("Liquid Glass")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GlassPanel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Glass Panel")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("This demonstrates a glass morphism effect using SwiftUI's visual effect materials.")
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "sparkles")
                    .foregroundColor(.blue)
                Text("Translucent Background")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(.green)
                Text("Blur Effect")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        LiquidGlassDemo()
    }
}