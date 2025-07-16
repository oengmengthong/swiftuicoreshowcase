//
//  ShowcaseItem.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import Foundation
import SwiftUI

struct ShowcaseItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let systemImage: String
    let destination: AnyView
    let category: ShowcaseCategory
}

enum ShowcaseCategory: String, CaseIterable {
    case layout = "Layout & Structure"
    case content = "Content Views"
    case controls = "Controls & Inputs"
    case navigation = "Navigation & Presentation"
    case gestures = "Gestures & Interactions"
    case animation = "Animation & Transitions"
    case graphics = "Graphics & Effects"
    case state = "State Management"
    case accessibility = "Accessibility"
    case utilities = "Utilities"
    
    var systemImage: String {
        switch self {
        case .layout: return "rectangle.3.group"
        case .content: return "doc.text"
        case .controls: return "slider.horizontal.3"
        case .navigation: return "arrow.triangle.turn.up.right.circle"
        case .gestures: return "hand.tap"
        case .animation: return "waveform"
        case .graphics: return "paintbrush"
        case .state: return "externaldrive.connected.to.line.below"
        case .accessibility: return "accessibility"
        case .utilities: return "wrench.and.screwdriver"
        }
    }
}
