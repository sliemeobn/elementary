public protocol HtmlDocument: Html {
    associatedtype HtmlHead: Html
    associatedtype HtmlBody: Html

    var title: String { get }
    @HtmlBuilder var head: HtmlHead { get }
    @HtmlBuilder var body: HtmlBody { get }
}

public extension HtmlDocument {
    @HtmlBuilder var content: some Html {
        HtmlRaw("<!DOCTYPE html>")
        html {
            Elementary.head {
                Elementary.title { self.title }
                self.head
            }
            Elementary.body { self.body }
        }
    }
}
