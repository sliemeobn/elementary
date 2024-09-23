# Elementary: HTML Templating in Pure Swift

**A modern and efficient HTML rendering library - inspired by SwiftUI, built for the web.**

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsliemeobn%2Felementary%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sliemeobn/elementary) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsliemeobn%2Felementary%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sliemeobn/elementary)

[Examples](#play-with-it) | [Motivation](#motivation-and-other-packages) | [Discussion](https://github.com/sliemeobn/elementary/discussions)

```swift
struct MainPage: HTMLDocument {
    var title = "Elementary"

    var head: some HTML {
        meta(.name(.description), .content("Typesafe HTML in modern Swift"))
    }

    var body: some HTML {
        main {
            h1 { "Features" }

            FeatureList(features: [
                "HTML in pure Swift",
                "SwiftUI-inspired composition",
                "Lightweight and fast",
                "Framework agnostic and unopinionated",
            ])

            a(.href("https://github.com/sliemeobn/elementary"), .class("fancy-style")) {
                "Learn more"
            }
        }
    }
}

struct FeatureList: HTML {
    var features: [String]

    var content: some HTML {
        ul {
            for feature in features {
                li { feature }
            }
        }
    }
}
```

## Use it

Add the dependency to `Package.swift`
```swift
.package(url: "https://github.com/sliemeobn/elementary.git", from: "0.3.2")
.product(name: "Elementary", package: "elementary")
```

Integration with [Hummingbird](https://github.com/hummingbird-community/hummingbird-elementary)
```swift
.package(url: "https://github.com/hummingbird-community/hummingbird-elementary.git", from: "0.3.0")
.product(name: "HummingbirdElementary", package: "hummingbird-elementary")
```

Integration with [Vapor](https://github.com/vapor-community/vapor-elementary)
```swift
.package(url: "https://github.com/vapor-community/vapor-elementary.git", from: "0.1.0")
.product(name: "VaporElementary", package: "vapor-elementary")
```

## Play with it

Check out the [Hummingbird + Tailwind example app](https://github.com/sliemeobn/elementary/tree/main/Examples/HummingbirdDemo).

For a demo of [ElementaryHTMX](https://github.com/sliemeobn/elementary-htmx), see this [Hummingbird + HTMX Demo](https://github.com/sliemeobn/elementary-htmx/tree/main/Examples/HummingbirdDemo).

For a Vapor example, see the [Vapor + HTMX Demo](https://github.com/sliemeobn/elementary-htmx/tree/main/Examples/VaporDemo).

## Lightweight and fast

Elementary renders straight to text, optimized for serving generated HTML from a [Hummingbird](https://github.com/hummingbird-project/hummingbird) or [Vapor](https://vapor.codes/) server app.

Any type conforming to `HTML` can be rendered individually, ideal for testing or for sending fragments with [htmx](https://github.com/sliemeobn/elementary-htmx).

The default rendering mechanism produces chunks of HTML for efficient response streaming, so the browser can start loading a page while the server is still producing the rest of it. Swift concurrency is used to handle back pressure, so you your memory footprint stays low even for large pages.

```swift
// Stream HTML, optimized for responsiveness and back pressure-aware
try await MainPage().render(into: responseStreamWriter)
```

Alternatively, you can simply collect the rendered HTML in a string.

```swift
let html: String = div(.class("pretty")) { "Hello" }.render()
// <div class="pretty">Hello</div>

let fragment: String = FeatureList(features: ["Anything conforming to HTML can be rendered"]).render()
// <ul><li>Anything conforming to HTML can be rendered</li></ul>

// For testing purposes, there is also a formatted version
print(
    div {
        p(.class("greeting")) { "Hi mom!" }
        p { "Look how pretty." }
    }.renderFormatted()
)

// <div>
//   <p class="greeting">Hi mom!</p>
//   <p>Look how pretty.</p>
// </div>
```

Elementary has zero dependencies (not even Foundation) and does not use runtime reflection or existential containers (there is not a single `any` in the code base).

By design, it does not come with a layout engine, reactive state tracking, or built-in CSS styling: it just renders HTML.

## Clean and composable

Structure your HTML with a SwiftUI-inspired composition API.

```swift
struct List: HTML {
    var items: [String]
    var importantIndex: Int

    var content: some HTML {
        // conditional rendering
        if items.isEmpty {
            p { "No items" }
        } else {
            ul {
                // list rendering
                for (index, item) in items.enumerated() {
                    // seamless composition of elements
                    ListItem(text: item, isImportant: index == importantIndex)
                }
            }
        }
    }
}

struct ListItem: HTML {
    var text: String
    var isImportant: Bool = false

    var content: some HTML {
        // conditional attributes
        li { text }
            .attributes(.class("important"), when: isImportant)
    }
}
```

## First class attribute handling

Elementary utilizes Swift's powerful generics to provide an attribute system that knows what goes where. Every element knows which Tag it is for.

As in HTML, attributes go right after the "opening tag".

```swift
// staying close to HTML syntax really helps
div(.data("hello", value: "there")) {
    a(.href("/swift"), .target(.blank)) {
        img(.src("/swift.png"))
        span(.class("fancy")) { "Click Me" }
    }
}
```

Attributes can also be altered by using the modifier syntax, this allows for easy handling of conditional attributes.

```swift
div {
    p { "Hello" }
        .attributes(.id("maybe-fancy"))
        .attributes(.class("fancy"), when: isFancy)
}
```

By exposing the tag type of `content`, attributes will fall through and be applied correctly.

```swift
struct Button: HTML {
    var text: String

    // by exposing the HTMLTag type information...
    var content: some HTML<HTMLTag.input> {
        input(.type(.button), .value(text))
    }
}

div {
    // ... Button will know it really is an <input> element ...
    Button(text: "Hello")
        .attributes(.autofocus) // ... and pass on any attributes
}
```

As a sensible default, _class_ and _style_ attributes are merged (with a blank space or semicolon respectively). All other attributes are overwritten by default.

## Seamless async support

Elementary supports Swift Concurrency in HTML content. Simply `await` something inside your HTML, while the first bytes are already flying towards the browser.

```swift
div {
    let text = await getMyData()
    p { "This totally works: \(text)" }
    MyComponent()
}

struct MyComponent: HTML {
    var content: some HTML {
        AsyncContent {
            "So does this: \(await getMoreData())"
        }
    }
}
```

By using the `AsyncForEach` element, any `AsyncSequence` can be efficiently rendered straight to HTML.

```swift
ul {
    // the full result never needs to be stored in memory...
    let users = try await db.users.findAll()
    // ...as each async sequence element...
    AsyncForEach(users) { user in
        // ...is immediately streamed out as HTML
        li { "\(user.name) \(user.favoriteProgrammingLanguage)" }
    }
}
```

## Enviroment values

Elementary utilizes `TaskLocal`s to provide a light-weight environment system.

```swift
enum MyValues {
    // task-locals act as keys, ...
    @TaskLocal static var userName = "Anonymous"
}

struct MyComponent: HTML {
    // ... their values can be accessed ...
    @Environment(MyValues.$userName) var userName

    var content: some HTML {
        p { "Hello, \(userName)!" }
    }
}

div {
    // ... and provided in a familiar way
    MyComponent()
        .environment(Values.$userName, "Drax the Destroyer")
}
```

### 🚧 Work in progress 🚧

The list of built-in attributes is far from complete, but adding them is really simple (and can be done in external packages as well).

Feel free to open a PR with additional attributes that are missing from the model.

## Motivation and other packages

[Plot](https://github.com/JohnSundell/Plot), [HTMLKit](https://github.com/vapor-community/HTMLKit), and [Swim](https://github.com/robb/Swim) are all excellent packages for doing a similar thing.

My main motivation for Elementary was to create an experience like these ([Swift Forums post](https://forums.swift.org/t/elementary-a-modern-and-efficient-html-rendering-library-inspired-by-swiftui-built-for-the-web/72647) for more context), but

- stay true to HTML tag names and conventions (including the choice of lowercase types)
- avoid allocating an intermedate structure and go straight to streaming HTML
- using generics to stay away from allocating a ton of lists of existential `any`s
- have a list of attributes go before the content block
- provide _attribute fallthrough_ and merging
- zero dependencies on other packages

[Tokamak](https://github.com/TokamakUI/Tokamak) is an awesome project and very inspiring. It can produce HTML, but it's main focus is on a very different beast. Check it out!

[swift-html](https://github.com/pointfreeco/swift-html) and [swift-dom](https://github.com/tayloraswift/swift-dom) will produce HTML nicely, but they use a different syntax for composing HTML elements.

## Future directions

- Experiment with embedded swift for wasm and bolt a lean state tracking/reconciler for reactive DOM manipulation on top
