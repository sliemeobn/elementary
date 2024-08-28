// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "HummingbirdDemo",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0-rc.5"),
        .package(path: "../../"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "Elementary", package: "elementary"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
    ]
)
