# Elementary: HTML Templating in Pure Swift

**A modern and efficient HTML rendering library - inspired by SwiftUI, built for the web.**

[Examples](#play-with-it) | [Motivation](#motivation-and-other-packages)

🚧 Work In Progress 🚧 - don't bet your future on it just yet ;)

```swift
struct MainPage: HTMLDocument {
    var title: String = "Elementary"

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

## Play with it

Check out the [Hummingbird example app](https://github.com/sliemeobn/elementary/tree/main/Examples/HummingbirdDemo).

## Lightweight and fast

Elementary renders straight to text, ideal for serving generated HTML from a [Hummingbird](https://github.com/hummingbird-project/hummingbird) or [Vapor](https://vapor.codes/) server app.

Any element can be rendered individually, ideal for [htmx](https://htmx.org/).

```swift
let html = div(.class("pretty")) { "Hello" }.render()
// <div class="pretty">Hello</div>

let fragment = FeatureList(features: ["Anything conforming to HTML can be rendered"]).render()
// <ul><li>Anything conforming to HTML can be rendered</li></ul>
```

Optionally you can render formatted output, or stream the rendered HTML without collecting it in a string first.

```swift
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

```swift
// Have HTML arrive at the browser before the full page is rendered out.
MainPage().render(into: responseStream)
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
                    ListItem(text: item, isimportant: index == importantIndex)
                }
            }
        }
    }
}

struct ListItem: HTML {
    var text: String
    var isimportant: Bool = false

    var content: some HTML {
        // conditional attributes
        li { text }
            .attributes(.class("important"), when: isimportant)
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

### 🚧 Work in progress 🚧

The list of built-in attributes is quite short still, but adding them is quite easy (and can be done in external packages as well).

Feel free to open a PR with additional attributes that are missing from the model.

## Motivation and other packages

[Plot](https://github.com/JohnSundell/Plot), [HTMLKit](https://github.com/vapor-community/HTMLKit), and [Swim](https://github.com/robb/Swim) are all excellent packages for doing a similar thing.

My main motivation for Elementary was to create an experience like these, but

- stay true to HTML tag names and conventions (including the choice of lowercase types)
- avoid allocating an intermedate structure and go straght to text
- using generics to stay away from allocating a ton of lists of existential `any`s
- have a list of attributes go before the content block
- provide _attribute fallthrough_ and merging
- zero dependencies on other packages

[Tokamak](https://github.com/TokamakUI/Tokamak) is an awesome project and very inspiring. It can produce HTML, but it's main focus is on a very different beast. Check it out!

[swift-html](https://github.com/pointfreeco/swift-html) and [swift-dom](https://github.com/tayloraswift/swift-dom) will produce HTML nicely, but they use a different syntax for composing HTML elements.

## Future directions

- Try out a **_hummingbird + elementary + htmx + tailwind_** stack for fully-featured web apps (without too much client javascript or wasm)
- Experiment with an `AsyncHTML` type, that can include `await` in bodies and stream html and an async sequence
- Experiment with embedded swift for wasm and bolt a lean state tracking/reconciler for reactive DOM manipulation on top
