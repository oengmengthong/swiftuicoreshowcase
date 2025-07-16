//
//  ContentView.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var showcaseData = ShowcaseData()
    @State private var selectedItem: ShowcaseItem? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ShowcaseCategory.allCases, id: \.self) { category in
                    Section(category.rawValue) {
                        ForEach(showcaseData.items.filter { $0.category == category }) { item in
                            NavigationLink(destination: item.destination) {
                                HStack {
                                    Label(item.title, systemImage: item.systemImage)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI Showcase")
            
            Text("Select a demo")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
