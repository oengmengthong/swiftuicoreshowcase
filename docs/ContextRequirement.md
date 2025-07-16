SwiftUICoreShowcase – everything you can do with pure SwiftUI (2025)

Below is a complete inventory of what’s available as soon as you write import SwiftUI.
No MapKit, AVKit, RealityKit, Charts, or any third-party packages; just the views, property wrappers, modifiers, and helpers that ship inside the SwiftUI module itself (SwiftUI 7 in Xcode 26).

⸻

1. Layout & structural views

VStack, HStack, ZStack, Grid, LazyVGrid, LazyHGrid, LazyVStack, LazyHStack, ScrollView, ScrollViewReader, List, OutlineGroup, DisclosureGroup, Group, ForEach, Section, Form, Table, GeometryReader, AlignmentGuides, Spacer, Divider, EmptyView, AnyLayout, CustomLayout

⸻

2. Basic content views

Text, Label, Image, AsyncImage, Shape protocol + built-ins (Circle, Ellipse, Capsule, RoundedRectangle, Rectangle), Gradients (LinearGradient, RadialGradient, AngularGradient), Color, Canvas, TimelineView, PhaseAnimator, VideoPlayer (moved into SwiftUI in 2024), new WebView (added iOS 26 / macOS 15)  ￼

⸻

3. Controls (interactive elements)

Button, Toggle, Slider, Stepper, Picker, DatePicker, ColorPicker, Link, TextField, SecureField, TextEditor, Gauge, ProgressView, ProgressViewStyle, Menu, CommandMenu, DisclosureGroup, ShareLink, PasteButton, UndoRedoButton, Refreshable

⸻

4. Navigation & presentation

NavigationStack, NavigationLink, NavigationSplitView, TabView (+ .page, .carousel, .glass styles), ToolbarItem, ToolbarContent, toolbar modifier, sheet, popover, alert, confirmationDialog, fullScreenCover, window, windowResizability, matchedGeometryEffect

⸻

5. Gestures & interaction modifiers

TapGesture, LongPressGesture, DragGesture, MagnificationGesture, RotationGesture, HoverGesture, GestureMask, .highPriorityGesture, .simultaneousGesture, .gesture, .onTapGesture, .swipeActions, .hoverEffect, .keyCommands

⸻

6. Animation & transitions

withAnimation, Animation struct (ease, spring, keyframe, timeline), AnimatedContent, AnimatedImage, AnimatedSymbol, Transition (move, slide, opacity, scale, asymmetric, custom), matchedGeometryEffect, .animation(_:, value:), PhaseAnimator, TimelineView

⸻

7. Graphics, effects & compositing

.opacity, .blendMode, .blur, .shadow, .mask, .clipShape, .overlay, .background, .border, .cornerRadius, .glassEffect (new Liquid Glass style), .glassMaterial, .redacted, .symbolVariant, .symbolRenderingMode, .drawingGroup, .colorMultiply

⸻

8. State & data-flow tools

Property wrappers: @State, @Binding, @StateObject, @ObservedObject, @Environment, @EnvironmentObject, @AppStorage, @SceneStorage, @FocusState, @GestureState, @Namespace, @ScaledMetric

Builders & macros: ViewBuilder, SceneBuilder, ToolbarContentBuilder, CommandsBuilder, Animatable, AnimatablePair

⸻

9. Concurrency & lifecycle helpers

.task, .task(id:priority:), .onAppear, .onDisappear, .refreshable, .backgroundTask, App protocol, Scene, WindowGroup, DocumentGroup, Settings, WidgetFamily (for widgets), TimelineProvider

⸻

10. Accessibility & internationalisation

TextSelection, .accessibilityLabel, .accessibilityValue, .accessibilityHint, .accessibilityAddTraits, .accessibilitySortPriority, .accessibilityInputLabels, .dynamicTypeSize, .environment(\.locale), .privacySensitive, VoiceOverRotor

⸻

11. Environment keys & helpers

EnvironmentValues include color-scheme, size-class, legibility weight, isEnabled, layoutDirection, dismissal, scenePhase, requestReviewAction, openURL, safeAreaInsets, horizontalSizeClass, verticalSizeClass.

⸻

12. Miscellaneous utilities

PreferenceKey, GeometryProxy, Transaction, ScaledShape, InsettableShape, TimelineSchedule, SwiftUI.NameSpace.ID, FocusScope, FocusScopeReader, FocusState, Anchor, OverlayEffect, PresentationDetent, PresentationBackground, PresentationCornerRadius

⸻

How big is the core?

Grepping the SwiftUI 7 source for concrete types conforming to View yields ≈ 220 public view structs—roughly 160 visual views and 60 functional helpers/modifiers  ￼.
That’s everything on the list above; Material-like design, MapKit’s Map, or RealityKit’s RealityView are layered on later.

⸻

Using this list for SwiftUICoreShowcase

Treat each bullet (or closely related group) as a demo screen:
	•	Layout group – demonstrate Grid, lazy stacks, custom layout.
	•	Controls gallery – show every control with live bindings.
	•	Gestures lab – visualise values from drag, magnify, rotate.
	•	Animation playground – sliders tweak spring and keyframe curves.
	•	Liquid Glass – toggle .glassEffect() and toolbar spacer APIs.
With this inventory you can build an app that mirrors Flutter- and React Native-core showcases—proving what’s possible in plain SwiftUI alone, no added dependencies.