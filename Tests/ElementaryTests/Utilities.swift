import Elementary
import XCTest

func HTMLAssertEqual(_ html: some HTML, _ expected: String, file: StaticString = #filePath, line: UInt = #line) async throws {
    XCTAssertEqual(expected, html.render(), file: file, line: line)

    try await HTMLAssertEqualAsyncOnly(html, expected, file: file, line: line)
}

func HTMLAssertEqualAsyncOnly(_ html: some HTML, _ expected: String, file: StaticString = #filePath, line: UInt = #line) async throws {
    let asyncText = try await html.renderAsync()
    XCTAssertEqual(expected, asyncText, file: file, line: line)
}

func HTMLFormattedAssertEqual(_ html: some HTML, _ expected: String, file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertEqual(expected, html.renderFormatted(), file: file, line: line)
}

final class TestBufferWriter: HTMLStreamWriter {
    var result: [UInt8] = []
    var writeCount: Int = 0

    func write(_ bytes: ArraySlice<UInt8>) async throws {
        writeCount += 1
        result.append(contentsOf: bytes)
    }
}
