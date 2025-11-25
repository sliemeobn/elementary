import Elementary

extension MainLayout: Sendable where Body: Sendable {}
struct MainLayout<Body: HTML>: HTMLDocument {
    var title: String
    @HTMLBuilder var pageContent: Body

    var head: some HTML {
        meta(.charset(.utf8))
        meta(.name(.viewport), .content("width=device-width, initial-scale=1.0"))
        HTMLComment("Do not use this in production, use the tailwind CLI to generate a production build from your swift files.")
        script(.src("https://cdn.tailwindcss.com")) {}
    }

    var body: some HTML {
        div(.class("flex flex-col min-h-screen items-center font-mono bg-zinc-300")) {
            div(.class("bg-zinc-50 m-12 p-12 rounded-lg shadow-md gap-4")) {
                h1(.class("text-3xl pb-6 mx-auto")) { title }
                main {
                    pageContent
                }
            }
        }
    }
}

struct WelcomePage: HTML {
    var body: some HTML {
        div(.class("flex flex-col gap-4")) {
            p {
                "This is a simple example of using "
                i(.class("text-red-800")) { "Elementary" }
                " with Hummingbird."
            }
            form(.action("/greet"), .class("flex flex-col gap-2")) {
                label(.for("name")) { "Enter your name:" }
                input(.type(.text), .name("name"), .autofocus)
                    .roundedTextbox()
                label(.for("count"), .class("mt-2")) { "How many greetings would you like:" }
                input(.type(.number), .name("count"), .value("1"))
                    .roundedTextbox()
                    .attributes(.class("w-20"))
                input(.type(.submit), .class("mt-4"), .value("Let's go!"))
                    .primaryButton()
            }
        }
    }
}

struct GreetingPage: HTML {
    // example of a task-local based environment value
    @Environment(requiring: EnvironmentValues.$name) var name
    var greetingCount: Int

    var body: some HTML {
        if greetingCount < 1 {
            p(.class("text-red-500")) {
                "No greetings to show."
            }
        } else {
            ul {
                ForEach(0..<greetingCount) { i in
                    li {
                        "Hello there, \(name)!"
                        // demo of conditional styling (should be done with CSS in real life)
                    }.attributes(.class("text-orange-700"), when: i % 2 == 0)
                }
            }
        }
    }
}

// example of using modifier-like methods to apply styling
extension input {
    // making the return type specify the input tag allows to chain attributes for it
    func roundedTextbox() -> some HTML<HTMLTag.input> {
        attributes(.class("rounded-lg p-2 border border-gray-300"))
    }

    func primaryButton() -> some HTML<HTMLTag.input> {
        attributes(
            .class("rounded-lg p-2 bg-orange-500 text-white font-semibold shadow-sm"),
            .class("hover:bg-orange-600 hover:shadow-xl")
        )
    }
}

enum EnvironmentValues {
    @TaskLocal static var name: String?
}
