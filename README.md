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

Feels hard on the eyes, doesn't it? It's even worse when you have to setup lots of constraints along with custom priorities.

And here's how it is with Visual Builder:

```swift
// Visual Builder
titleLabel.top == view.top + 50
titleLabel.centerX == view.centerX

(button.top <= view.bottom + 400) | 500
```

It's way better. But hey, it gets even better. How about view hierarchys? It's difficult to visualize the view hiearachy in regular UIKit. See the code below and try to understand the hierarchy of the view.

```swift
// Regular UIKit
view.addSubview(child1)
view.addSubview(child2)
child2.addSubview(child3)
child2.addSubview(child4)
child4.addSubview(child5)
child4.addSubview(child6)
```

And how let's see how it is with Visual Builder:

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

Much better, right? It handles adding subviews for you. Feel free to check out the Usage & features below and give it a try.

## Installation

Coming soon via a CocoaPod.

# Usage

Visual Builder can be implemented in both ```UIViewController``` and ```UIView``` subclasses. Here's a step-by-step example of a view controller implementation.

**Step 1:** Import the framework and confirm to VisualBuilder protocol.

```swift
import VisualBuilder // Import

class ViewController: UIViewController, VisualBuilder { // Conform to VisualBuilder
...
}
```

**Step 2:** Implement the Auto-Layout Builder in the class, aka ```Constraint Builder```

```swift
// Required to store active constraints.
public var currentConstraints: [NSLayoutConstraint] = []

@AutoLayoutBuilder var constraintBuilder: [VBConstraint] {
  backgroundView.edges == view.safeEdges // Constraint all 4 edges

  titleLabel.top == view.topSafe + 50 // topSafe is: safeAreaLayoutGuide.topAnchor
  titleLabel.height == 100

  if !titleLabelOffsetted { // Yes, conditional constraints are supported as well :)
    titleLabel.centerX == view.centerX
  } else {
    titleLabel.centerX == view.centerX + 100
  }
  
  // sets priority to 500. (Valid range: 0...1000)
  (button.top == subtitleLabel.bottom + buttonOffset) | 500
  button.top <= subtitleLabel.bottom + 400

  button.centerX == view.centerX
}
```

**Step 3:** Implement the ```Hierarchy Builder```

```swift
// Required to store current views created by visual builder
public var currentHierarchy: [Any] = []

@ViewHierarchyBuilder var hierarchyBuilder: [Any] {
  backgroundView
  titleLabel
  view1
  view2.content {
    view3
    view4
    view5.content {
      view6
      view7
    }
  }
}
```

**Step 4:** Call the ```buildLayout()``` function and that's it!

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  buildLayout()
}
```

**Note:** If you want to build view hierarchy and constraints separately, you can do so with ```buildHierarchy()``` and ```buildConstraints()``` functions as below:

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  // Should ALWAYS be called in below order.
  buildHierarchy()
  buildConstraints()
}
```

So there ya go! Looks super easy, doesn't it?

Feel free to give it a test-drive and let me know your thoughts. You can reach me out via email: neelrmewada@gmail.com

