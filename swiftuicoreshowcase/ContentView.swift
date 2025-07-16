//
//  ContentView.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var showcaseData = ShowcaseData()
    @State private var selectedCategory: ShowcaseCategory? = nil
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedCategory) {
                ForEach(ShowcaseCategory.allCases, id: \.self) { category in
                    Section(category.rawValue) {
                        ForEach(showcaseData.items.filter { $0.category == category }) { item in
                            NavigationLink(destination: item.destination) {
                                Label(item.title, systemImage: item.systemImage)
                                    .badge(item.description)
                            }
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI Core Showcase")
            .navigationSplitViewColumnWidth(min: 300, ideal: 350)
        } detail: {
            if let selectedCategory = selectedCategory {
                VStack {
                    Image(systemName: selectedCategory.systemImage)
                        .font(.system(size: 60))
                        .foregroundStyle(.secondary)
                    Text(selectedCategory.rawValue)
                        .font(.title)
                        .fontWeight(.medium)
                    Text("Select a demo to explore SwiftUI features")
                        .foregroundStyle(.secondary)
                }
            } else {
                VStack {
                    Image(systemName: "swift")
                        .font(.system(size: 80))
                        .foregroundStyle(.blue)
                    Text("SwiftUI Core Showcase")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Everything you can do with pure SwiftUI")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    Text("Select a category to explore features")
                        .padding(.top)
                        .foregroundStyle(.tertiary)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
