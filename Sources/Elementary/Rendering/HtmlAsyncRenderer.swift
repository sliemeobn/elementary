struct AsyncHTMLRenderer<Writer: HTMLStreamWriter>: _AsyncHTMLRendering {
    var writer: Writer
    let chunkSize: Int
    var buffer: [UInt8] = []

    init(writer: Writer, chunkSize: Int) {
        self.writer = writer
        self.chunkSize = chunkSize
        buffer.reserveCapacity(chunkSize)
    }

    mutating func appendToken(_ token: consuming _HTMLRenderToken) async throws {
        let value = token.renderedValue.utf8
        if value.count + buffer.count > buffer.capacity {
            try await flush()
            buffer.replaceSubrange(0 ... buffer.count - 1, with: value)
        } else {
            buffer.append(contentsOf: value)
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
