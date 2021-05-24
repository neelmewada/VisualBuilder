# Visual Builder

A Swift framework made for **UIKit** that enables you to add Auto-Layout **constraints** and **subviews** in a declarative SwiftUI like syntax. And that too without any strings!

Here's how adding constraints look in regular UIKit:

```swift
// Regular UIKit
titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

let constraint = button.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 400)
constraint.priority = UILayoutPriority(500)
constraint.isActive = true
```

Feels very hard on the eyes, doesn't it? It's even worse when you have to setup lots of constraints along with custom priorities.

And here's how it is with Visual Builder:

```swift
// Visual Builder
titleLabel.top == view.top + 50
titleLabel.centerX == view.centerX

(button.top <= view.bottom + 400) | 500
```

It's way better, isn't it? But hey, it gets even better. How about view hierarchys? It's difficult to visualize the view hiearachy in regular UIKit. See the code below and try to understand the hierarchy.

```swift
// Regular UIKit
view.addSubview(child1)
view.addSubview(child2)
child2.addSubview(child3)
child2.addSubview(child4)
child4.addSubview(child5)
child4.addSubview(child6)
```

And how let's see how it is with Visual Builder.

```swift
// Visual Builder
child1
child2.content {
  child3
  child4.content {
    child5
    child6
  }
}
```

# Usage



