// swift-tools-version: 6.0
import PackageDescription

let featureFlags: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "elementary",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "Elementary",
            targets: ["Elementary"]
        ),
    ],
    targets: [
        .target(
            name: "Elementary",
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryTests",
            dependencies: ["Elementary"],
            swiftSettings: featureFlags
        ),
    ]
)
