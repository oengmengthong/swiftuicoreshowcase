//
//  NavigationDemo.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct NavigationDemo: View {
    @State private var selectedTab = 0
    @State private var showingSheet = false
    @State private var showingAlert = false
    @State private var showingConfirmation = false
    @State private var showingPopover = false
    @State private var showingFullScreen = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerSection
                
                // Navigation Stack Demo
                navigationStackSection
                
                // Presentation Styles
                presentationStylesSection
                
                // Tab View Demo
                tabViewSection
                
                // Toolbar Demo
                toolbarSection
            }
            .padding()
        }
        .navigationTitle("Navigation Demo")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingSheet) {
            SheetContentView()
        }
        .alert("Alert Demo", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
            Button("Action", role: .destructive) { }
        } message: {
            Text("This is an alert message demo")
        }
        .confirmationDialog("Confirmation Demo", isPresented: $showingConfirmation) {
            Button("Option 1") { }
            Button("Option 2") { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Choose an option")
        }
        .popover(isPresented: $showingPopover) {
            PopoverContentView()
        }
        .fullScreenCover(isPresented: $showingFullScreen) {
            FullScreenContentView()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Navigation & Presentation")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("NavigationStack, presentation styles, and navigation patterns in SwiftUI")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var navigationStackSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Navigation Stack")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                NavigationLink(destination: DetailView(title: "First Detail", content: "This is the first detail view")) {
                    HStack {
                        Image(systemName: "arrow.right.circle")
                        Text("Navigate to Detail View")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
                
                NavigationLink(destination: DetailView(title: "Second Detail", content: "This is the second detail view")) {
                    HStack {
                        Image(systemName: "arrow.right.circle")
                        Text("Navigate to Another Detail")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                }
                
                NavigationLink(destination: DeepNavigationView()) {
                    HStack {
                        Image(systemName: "arrow.right.circle")
                        Text("Deep Navigation Demo")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var presentationStylesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Presentation Styles")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                // Sheet
                Button(action: { showingSheet = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "rectangle.portrait.bottomhalf.inset.filled")
                            .font(.title2)
                        Text("Sheet")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
                
                // Full Screen Cover
                Button(action: { showingFullScreen = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "rectangle.fill")
                            .font(.title2)
                        Text("Full Screen")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                }
                
                // Alert
                Button(action: { showingAlert = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.title2)
                        Text("Alert")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }
                
                // Confirmation Dialog
                Button(action: { showingConfirmation = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "questionmark.circle")
                            .font(.title2)
                        Text("Confirmation")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(8)
                }
                
                // Popover
                Button(action: { showingPopover = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "bubble.left")
                            .font(.title2)
                        Text("Popover")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.pink.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var tabViewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tab View Demo")
                .font(.title2)
                .fontWeight(.semibold)
            
            TabView(selection: $selectedTab) {
                VStack(spacing: 16) {
                    Image(systemName: "house.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                    Text("Home Tab")
                        .font(.headline)
                    Text("This is the home tab content")
                        .foregroundColor(.secondary)
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
                
                VStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(.green)
                    Text("Search Tab")
                        .font(.headline)
                    Text("This is the search tab content")
                        .foregroundColor(.secondary)
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
                
                VStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .font(.title)
                        .foregroundColor(.purple)
                    Text("Profile Tab")
                        .font(.headline)
                    Text("This is the profile tab content")
                        .foregroundColor(.secondary)
                }
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(2)
            }
            .frame(height: 200)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var toolbarSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Toolbar Demo")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Check the navigation bar above for toolbar items")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Toolbar features:")
                    .font(.headline)
                
                Text("• Navigation bar title and buttons")
                Text("• Toolbar items with different placements")
                Text("• Contextual menus and actions")
                Text("• Search and filter capabilities")
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "gear")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct DetailView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(content)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeepNavigationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Deep Navigation")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This demonstrates deep navigation stacks")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: DeeperView()) {
                Text("Go Deeper")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Deep Navigation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeeperView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Deeper Level")
                .font(.title)
                .fontWeight(.bold)
            
            Text("You can continue navigating deeper")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            NavigationLink(destination: DeepestView()) {
                Text("Go Even Deeper")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Deeper Level")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeepestView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Deepest Level")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This is the deepest navigation level in this demo")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Use the back button to navigate back")
                .font(.caption)
                .foregroundColor(.tertiary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Deepest Level")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SheetContentView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Sheet Content")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("This is presented as a sheet")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Button("Dismiss") {
                    dismiss()
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sheet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct PopoverContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Popover Content")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("This is a popover")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button("Action") {
                // Action
            }
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
        .frame(width: 200, height: 120)
    }
}

struct FullScreenContentView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Full Screen Cover")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("This covers the entire screen")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Button("Dismiss") {
                    dismiss()
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Full Screen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        NavigationDemo()
    }
}
