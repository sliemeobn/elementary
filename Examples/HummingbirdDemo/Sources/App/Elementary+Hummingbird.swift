import Elementary
import Hummingbird

extension MainLayout: ResponseGenerator {}

extension HTML {
    func response(from request: Request, context: some RequestContext) throws -> Response {
        .init(
            status: .ok,
            headers: [.contentType: "text/html"],
            body: .init(byteBuffer: .init(string: render()))
        )
    }

    // NOTE: for very large pages, using streaming might be worth it
    // func response(from request: Request, context: some RequestContext) throws -> Response {
    //     .init(
    //         status: .ok,
    //         headers: [.contentType: "text/html"],
    //         body: .init(asyncSequence: AsyncStream { continuation in
    //             self.render { continuation.yield(context.allocator.buffer(string: $0)) }
    //             continuation.finish()
    //         })
    //     )
    // }
}
