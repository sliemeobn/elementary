import Elementary
import XCTest

func HtmlAssertEqual(_ html: some Html, _ expected: String, file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertEqual(expected, html.render(), file: file, line: line)
}

func HtmlFormattedAssertEqual(_ html: some Html, _ expected: String, file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertEqual(expected, html.renderFormatted(), file: file, line: line)
}
