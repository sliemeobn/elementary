# Elementary

**Typesafe HTML templating in pure Swift.**

_🚧 Work in progress 🚧_

```swift
struct MainPage: HtmlDocument {
    var title: String = "Elementary"

    var head: some Html {
        meta(.name(.description), .content("Typesafe HTML in modern Swift"))
    }

    var body: some Html {
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

struct FeatureList: Html {
    var features: [String]

    var content: some Html {
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

Elementary renders straight to text, ideal for serving generated HTML from a [Hummingbird](https://github.com/hummingbird-project/hummingbird) or [Vapor](https://vapor.codes/) app.

Any element can be rendered individually, ideal for [htmx](https://htmx.org/).

```swift
let html = div(.class("pretty")) { "Hello" }.render()
// <div class="pretty">Hello</div>

let fragment = FeatureList(features: ["Anything conforming to Html can be rendered"]).render()
// <ul><li>Anything conforming to Html can be rendered</li></ul>
```

Optionally you can render formatted output, or stream the rendered Html without collecting it in a string first.

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

## Clean and composable

Structure your HTML with a SwiftUI-inspired composition API.

```swift
struct List: Html {
    var items: [String]
    var importantIndex: Int

    var content: some Html {
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

struct ListItem: Html {
    var text: String
    var isimportant: Bool = false

    var content: some Html {
        // conditional attributes
        li { text }
            .attributes(.class("important"), when: isimportant)
    }
}
```

## Framework agnostig and unopinionated

Elementary has zero dependencies (not even Foundation) and does not use runtime reflection or existentials (there is not a single `any` in the code base).

It does not come with a layout engine, reactive state tracking, or built-in CSS styling: it just renders HTML.

## 🚧 Work in progress 🚧

TODO:

- finish readme (explain attribute mering, add motivation, add links and acknowledgements to other packages)
- push to SPI
- include badges in readme
- add code comments and documentation build (SPI)
- add public API to control attribute merging/overrides
- add more common attributes (definitely the on\* events)
- fix formatted rendering, improve API
- share tailwind intelli sense trick
