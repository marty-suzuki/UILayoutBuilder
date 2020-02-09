# UILayoutBuilder 📱🛠

<p align='center'>
  <img src='https://img.shields.io/badge/Platform-iOS%20tvOS%20macOS-orange.svg?style=flat' alt='Carthage compatible' />
  <br/>
  <a href='https://github.com/Carthage/Carthage'>
    <img src='https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat' alt='Carthage compatible' />
  </a>
  <a href='https://swift.org/package-manager/'>
    <img src='https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg?style=flat' alt='Carthage compatible' />
  </a>
</p>

Using UILayoutBuilder, make it easy to see constraints with view hierarchy.<br/>
In addition, you can find a constraint method easily by auto-completion with first one or two charactors.

![auto-completion](https://user-images.githubusercontent.com/2082134/74106399-1827b380-4baa-11ea-9e17-2c728ed7ca56.gif)

You can replace:

```swift
view.addSubview(subview)
subview.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
    subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
    subview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
    subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
])
```
to

```swift
view.ulb.add.subview(subview) { view, subview in
    subview.top.equalTo.top(view.safeAreaLayoutGuide).constant(10)
    subview.leading.equalTo.leading(view).constant(10)
    subview.bottom.equalTo.bottom(view.safeAreaLayoutGuide).constant(-10)
    subview.trailing.equalTo.trailing(view).constant(-10)
}
```

## Usage

Start with `ulb.add.subview`, receives proxy of superview and subview. Call `proxy.add.subview`, receives proxy of subviews only.<br/>
You can constrain for AutoLayout using them.

<img src="https://user-images.githubusercontent.com/2082134/74106419-3ee5ea00-4baa-11ea-8bca-4b09a58c5f79.png" align="right" height="300px">

```swift
view.ulb.add.subview(grayview) { view, grayview in
    grayview.edges.equalTo.edges(view.safeAreaLayoutGuide).constant(10)

    grayview.add.subview(greenview, whiteview) { greenview, whiteview in
        greenview.size.equalTo.constant(width: 100, height: 100)
        greenview.center.equalTo.center(view).constant(x: -50, y: 0)
        whiteview.leading.equalTo.trailing(greenview)
        whiteview.top.equalTo.top(greenview)
        whiteview.size.equalTo.size(greenview)
    }
}
```

For every view added by `ulb.add.subview` or `proxy.add.subview` will automatically set its `translatesAutoresizingMaskIntoConstraints` property to `false`.

### Axis

```swift
subview.top.equalTo.top(view).constant(10)
// subview.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)

subview.top.greaterThanOrEqualTo.top(view).constant(10)
// subview.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 10)

subview.top.lessThanOrEqualTo.top(view).constant(10)
// subview.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 10)

subview.center.equalTo.center(view).constant(x: 100, y: 100)
// subview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50)
// subview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)

subview.horizontal.equalTo.horizontal(view).constant(leading: 10, trailing: -10)
// subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
// subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)

subview.vertical.equalTo.vertical(view).constant(top: 10, bottom: -10)
// subview.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
// subview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)

subview.edges.equalTo.edges(view).constant(10)
// or
subview.edges.equalTo.edges(view).constant(top: 10, leading: 10, bottom: -10, trailing: -10)
// subview.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
// subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
// subview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
// subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
```

### Dimension

```swift
subview.height.equalTo.height(view)
// subview.heightAnchor.constraint(equalTo: view.heightAnchor)

subview.width.equalTo.width(view).multiplier(0.5).constant(100)
// subview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 100)

subview.height.equalTo.constant(100)
// subview.heightAnchor.constraint(equalToConstant: 100)

subview.size.equalTo.size(view)
// subview.heightAnchor.constraint(equalTo: view.heightAnchor)
// subview.widthAnchor.constraint(equalTo: view.widthAnchor)

subview.size.equalTo.constant(width: 100, height: 100)
// subview.heightAnchor.constraint(equalToConstant: 100)
// subview.widthAnchor.constraint(equalToConstant: 100)
```

### Priority

```swift
subview.width.equalTo.width(view).priority(.required)
// subview.widthAnchor.constraint(equalTo: view.widthAnchor).priority = .required
```

### Constraints

```swift
let constraint: NSLayoutConstraint = subview.width.equalTo.width(view).asConstraint()
```

```swift
let constraints = subview.edges.equalTo.edges(view).asConstraints()
let top: NSLayoutConstraint = constraints.top
let leading: NSLayoutConstraint = constraints.leading
let bottom: NSLayoutConstraint = constraints.bottom
let trailing: NSLayoutConstraint = constraints.trailing
```

```swift
let constraints = subview.size.equalTo.size(view).asConstraints()
let width: NSLayoutConstraint = constraints.width
let height: NSLayoutConstraint = constraints.height
```

```swift
let constraints = subview.center.equalTo.center(view).asConstraints()
let x: NSLayoutConstraint = constraints.x
let y: NSLayoutConstraint = constraints.y
```

```swift
let constraints = subview.horizontal.equalTo.horizontal(view).asConstraints()
let leading: NSLayoutConstraint = constraints.leading
let trailing: NSLayoutConstraint = constraints.trailing
```

```swift
let constraints = subview.vertical.equalTo.vertical(view).asConstraints()
let top: NSLayoutConstraint = constraints.top
let bottom: NSLayoutConstraint = constraints.bottom
```

## LICENSE

Under the MIT license. See LICENSE file for details.