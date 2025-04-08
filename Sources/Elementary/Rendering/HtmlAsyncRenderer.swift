#if !hasFeature(Embedded)
struct AsyncHTMLRenderer<Writer: HTMLStreamWriter>: _AsyncHTMLRendering {
    var writer: Writer
    let chunkSize: Int
    var buffer: [UInt8] = []

    init(writer: Writer, chunkSize: Int) {
        self.writer = writer
        self.chunkSize = chunkSize
        // add some extra space as we do not know or check the exact size of the tokens before adding to the chunk buffer
        // ideally, this avoids unnecessary reallocations
        buffer.reserveCapacity(chunkSize + 500)
    }

    mutating func appendToken(_ token: consuming _HTMLRenderToken) async throws {
        // let value = token.renderedValue.utf8
        buffer.appendToken(token)
        if buffer.count >= buffer.capacity {
            try await flush()
            buffer.replaceSubrange(0...buffer.count - 1, with: [])
        }
    }

    mutating func flush() async throws {
        guard !buffer.isEmpty else { return }
        try await writer.write(buffer[...])
    }
}

final class BufferWriter: HTMLStreamWriter {
    var result: [UInt8] = []

    func write(_ bytes: ArraySlice<UInt8>) async throws {
        result.append(contentsOf: bytes)
    }
}
#endif
