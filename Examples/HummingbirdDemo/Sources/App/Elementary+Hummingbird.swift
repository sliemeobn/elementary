import Elementary
import Hummingbird

extension MainLayout: ResponseGenerator {}

struct HTMLResponseBodyWriter: HTMLStreamWriter {
    mutating func write(_ bytes: ArraySlice<UInt8>) async throws {
        try await writer.write(allocator.buffer(bytes: bytes))
    }

    var allocator: ByteBufferAllocator
    var writer: any ResponseBodyWriter
}

extension HTML where Self: Sendable {
    func response(from request: Request, context: some RequestContext) throws -> Response {
        .init(
            status: .ok,
            headers: [.contentType: "text/html; charset=utf-8"],
            body: .init { [self] writer in
                try await self.render(into: HTMLResponseBodyWriter(allocator: ByteBufferAllocator(), writer: writer))
                try await writer.finish(nil)
            }
        )
    }
}
