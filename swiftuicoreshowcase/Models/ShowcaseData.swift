//
//  ShowcaseData.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import Foundation
import SwiftUI

class ShowcaseData: ObservableObject {
    @Published var items: [ShowcaseItem] = []
    
    init() {
        loadShowcaseItems()
    }
    
    private func loadShowcaseItems() {
        items = [
            // Layout & Structure
            ShowcaseItem(
                title: "VStack, HStack, ZStack",
                description: "Basic layout containers for vertical, horizontal, and overlay arrangements",
                systemImage: "rectangle.3.group",
                destination: AnyView(StackLayoutDemo()),
                category: .layout
            ),
            ShowcaseItem(
                title: "Grid Layouts",
                description: "Grid, LazyVGrid, LazyHGrid for 2D arrangements",
                systemImage: "grid",
                destination: AnyView(GridLayoutDemo()),
                category: .layout
            ),
            ShowcaseItem(
                title: "Lazy Stacks",
                description: "LazyVStack, LazyHStack for performance with large datasets",
                systemImage: "rectangle.stack",
                destination: AnyView(LazyStackDemo()),
                category: .layout
            ),
            ShowcaseItem(
                title: "ScrollView & List",
                description: "Scrollable content and structured data presentation",
                systemImage: "list.bullet",
                destination: AnyView(ScrollViewDemo()),
                category: .layout
            ),
            ShowcaseItem(
                title: "Custom Layout",
                description: "Creating custom layout containers with Layout protocol",
                systemImage: "rectangle.center.inset.filled",
                destination: AnyView(CustomLayoutDemo()),
                category: .layout
            ),
            
            // Content Views
            ShowcaseItem(
                title: "Text & Label",
                description: "Text styling, formatting, and label combinations",
                systemImage: "textformat",
                destination: AnyView(TextDemo()),
                category: .content
            ),
            ShowcaseItem(
                title: "Images & AsyncImage",
                description: "Image display, async loading, and SF Symbols",
                systemImage: "photo",
                destination: AnyView(ImageDemo()),
                category: .content
            ),
            ShowcaseItem(
                title: "Shapes & Paths",
                description: "Built-in shapes, custom paths, and drawing",
                systemImage: "circle.square",
                destination: AnyView(ShapeDemo()),
                category: .content
            ),
            ShowcaseItem(
                title: "Gradients & Colors",
                description: "Linear, radial, and angular gradients with color manipulation",
                systemImage: "paintpalette",
                destination: AnyView(GradientDemo()),
                category: .content
            ),
            ShowcaseItem(
                title: "Canvas & Drawing",
                description: "Custom drawing with Canvas and GraphicsContext",
                systemImage: "paintbrush.pointed",
                destination: AnyView(CanvasDemo()),
                category: .content
            ),
            
            // Controls & Inputs
            ShowcaseItem(
                title: "Controls Gallery",
                description: "Every interactive control with live bindings",
                systemImage: "slider.horizontal.3",
                destination: AnyView(ControlsGalleryView()),
                category: .controls
            ),
            ShowcaseItem(
                title: "Button Variations",
                description: "All button types, styles, and configurations",
                systemImage: "button.programmable",
                destination: AnyView(ButtonDemo()),
                category: .controls
            ),
            ShowcaseItem(
                title: "Selection Controls",
                description: "Pickers, toggles, sliders, and steppers",
                systemImage: "checkmark.circle",
                destination: AnyView(SelectionControlsDemo()),
                category: .controls
            ),
            
            // Gestures & Interactions
            ShowcaseItem(
                title: "Gesture Laboratory",
                description: "Visualize drag, magnify, rotate values in real-time",
                systemImage: "hand.tap",
                destination: AnyView(GestureLabView()),
                category: .gestures
            ),
            ShowcaseItem(
                title: "Basic Gestures",
                description: "Tap, long press, and drag gestures",
                systemImage: "hand.point.up.left",
                destination: AnyView(BasicGesturesDemo()),
                category: .gestures
            ),
            
            // Animation & Transitions
            ShowcaseItem(
                title: "Animation Playground",
                description: "Interactive spring and keyframe animation controls",
                systemImage: "waveform.path",
                destination: AnyView(AnimationPlaygroundView()),
                category: .animation
            ),
            ShowcaseItem(
                title: "Basic Animations",
                description: "Fundamental animation techniques and transitions",
                systemImage: "arrow.clockwise",
                destination: AnyView(BasicAnimationDemo()),
                category: .animation
            ),
            
            // Graphics & Effects
            ShowcaseItem(
                title: "Liquid Glass Experience",
                description: "SwiftUI 7's new .glassEffect() and material system",
                systemImage: "circle.hexagongrid.fill",
                destination: AnyView(LiquidGlassDemo()),
                category: .graphics
            ),
            
            // Navigation & Presentation
            ShowcaseItem(
                title: "Navigation Patterns",
                description: "NavigationStack, NavigationSplitView, and presentation styles",
                systemImage: "arrow.triangle.turn.up.right.circle",
                destination: AnyView(NavigationDemo()),
                category: .navigation
            ),
            
            // State Management
            ShowcaseItem(
                title: "State Management",
                description: "Property wrappers, bindings, and data flow patterns",
                systemImage: "externaldrive.connected.to.line.below",
                destination: AnyView(StateManagementDemo()),
                category: .state
            ),
            
            // Accessibility
            ShowcaseItem(
                title: "Accessibility Features",
                description: "VoiceOver, Dynamic Type, and accessibility modifiers",
                systemImage: "accessibility",
                destination: AnyView(AccessibilityDemo()),
                category: .accessibility
            ),
            
            // Utilities
            ShowcaseItem(
                title: "Text Styling",
                description: "Text formatting, fonts, and typography",
                systemImage: "textformat",
                destination: AnyView(TextDemo()),
                category: .utilities
            ),
            ShowcaseItem(
                title: "Image Handling",
                description: "Image display, AsyncImage, and SF Symbols",
                systemImage: "photo",
                destination: AnyView(ImageDemo()),
                category: .utilities
            ),
            ShowcaseItem(
                title: "Shapes & Paths",
                description: "Built-in shapes, custom paths, and drawing",
                systemImage: "circle.square",
                destination: AnyView(ShapeDemo()),
                category: .utilities
            ),
            ShowcaseItem(
                title: "Gradients & Colors",
                description: "Linear, radial, and angular gradients with color manipulation",
                systemImage: "paintpalette",
                destination: AnyView(GradientDemo()),
                category: .utilities
            ),
            ShowcaseItem(
                title: "Canvas & Drawing",
                description: "Custom drawing with Canvas and GraphicsContext",
                systemImage: "paintbrush.pointed",
                destination: AnyView(CanvasDemo()),
                category: .utilities
            )
        ]
    }
}
