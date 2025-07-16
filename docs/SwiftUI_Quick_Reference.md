# SwiftUI Quick Reference Card

## Essential UI Components

### Layout Containers
```swift
VStack { /* vertical layout */ }
HStack { /* horizontal layout */ }
ZStack { /* overlay layout */ }
Grid { /* 2D grid layout */ }
LazyVGrid(columns: columns) { /* performance grid */ }
ScrollView { /* scrollable content */ }
List { /* structured data */ }
```

### Basic Controls
```swift
Button("Title") { /* action */ }
Toggle("Label", isOn: $binding)
TextField("Placeholder", text: $text)
Slider(value: $value, in: 0...100)
Picker("Options", selection: $selection) { /* options */ }
DatePicker("Date", selection: $date)
```

### Navigation
```swift
NavigationStack { /* iOS 16+ navigation */ }
NavigationLink("Title", destination: View())
TabView { /* tab interface */ }
.sheet(isPresented: $showSheet) { /* modal */ }
.alert("Title", isPresented: $showAlert) { /* alert */ }
```

### Common Modifiers
```swift
.padding()
.background(Color.blue)
.foregroundColor(.white)
.font(.title)
.frame(width: 200, height: 100)
.cornerRadius(10)
.shadow(radius: 5)
.opacity(0.8)
```

## State Management

### Property Wrappers
```swift
@State private var value = 0        // Local state
@Binding var value: Int             // Two-way binding
@StateObject var model = Model()    // Observable object
@ObservedObject var model: Model    // External observable
@Environment(\.colorScheme) var colorScheme // Environment
@AppStorage("key") var setting = false // UserDefaults
```

### Animation
```swift
withAnimation(.spring()) {
    // animated state change
}

.animation(.easeInOut, value: trigger)
.transition(.slide)
```

## Gestures
```swift
.onTapGesture { /* action */ }
.onLongPressGesture { /* action */ }
.gesture(DragGesture().onChanged { value in /* action */ })
```

## SwiftUI 7 New Features

### Liquid Glass
```swift
.glassEffect()
.glassMaterial(.regular)
```

### Enhanced Animations
```swift
.keyframeAnimator(initialValue: 0) { view, value in
    // keyframe animation
}
```

## Common Patterns

### Conditional View
```swift
if condition {
    Text("Shown when true")
} else {
    Text("Shown when false")
}
```

### List with Navigation
```swift
List(items) { item in
    NavigationLink(destination: DetailView(item: item)) {
        Text(item.name)
    }
}
```

### Form Layout
```swift
Form {
    Section("Settings") {
        Toggle("Enable", isOn: $enabled)
        TextField("Name", text: $name)
    }
}
```
