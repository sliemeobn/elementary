import Elementary
import XCTest

final class EnvironmentRenderingTests: XCTestCase {
    func testSetsEnvironment() async throws {
        try await HTMLAssertEqual(
            div {
                MyNumber()
                MyNumber()
                    .environment(Values.$number, 1)
                MyNumber()
            },
            "<div>010</div>"
        )
    }

    func testGetsOptionalEnvironment() async throws {
        try await HTMLAssertEqualAsyncOnly(
            div {
                MyDatabaseValue()
                    .environment(Values.$database, Database())
            },
            "<div><p>Hello</p></div>"
        )
    }
}

struct MyNumber: HTML {
    @Environment(Values.$number) var number

    var content: some HTML {
        "\(number)"
    }
}

struct MyDatabaseValue: HTML {
    @Environment(requiring: Values.$database) var database
    var content: some HTML {
        p {
            await database.value
        }
    }
}

enum Values {
    @TaskLocal static var number = 0
    @TaskLocal static var database: Database?
}

actor Database {
    var value: String = "Hello"
}
