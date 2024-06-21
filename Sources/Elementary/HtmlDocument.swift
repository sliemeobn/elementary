public protocol HTMLDocument: HTML {
    associatedtype HTMLHead: HTML
    associatedtype HTMLBody: HTML

    var title: String { get }
    @HTMLBuilder var head: HTMLHead { get }
    @HTMLBuilder var body: HTMLBody { get }
}

public extension HTMLDocument {
    @HTMLBuilder var content: some HTML {
        HTMLRaw("<!DOCTYPE html>")
        html {
            Elementary.head {
                Elementary.title { self.title }
                self.head
            }
            Elementary.body { self.body }
        }
    }
}
