import Hummingbird

@main
struct App {
    static func main() async throws {
        let router = Router()

        router.get("") { _, _ in
            MainLayout(title: "Hello, there!") {
                WelcomePage()
            }
        }

        router.get("greet") { request, _ in
            let name = String(request.uri.queryParameters.get("name") ?? "")
            let count = request.uri.queryParameters.get("count", as: Int.self) ?? 1

            return MainLayout(title: "Greeting") {
                GreetingPage(name: name.isEmpty ? "kind stranger" : name, greetingCount: count)
            }
        }

        let app = Application(
            router: router,
            onServerRunning: { _ in
                print("Server running on http://localhost:8080/")
                #if DEBUG
                    browserSyncReload()
                #endif
            }
        )
        try await app.runService()
    }
}
