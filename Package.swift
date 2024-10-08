// swift-tools-version: 5.10
import Foundation
import PackageDescription

let shouldBuildForEmbedded = ProcessInfo.processInfo.environment["EXPERIMENTAL_EMBEDDED_WASM"].flatMap(Bool.init) ?? false

let featureFlags: [SwiftSetting] = shouldBuildForEmbedded ?
    [
        .unsafeFlags([
            "-Xfrontend", "-emit-empty-object-file",
        ]),
    ] :
    [
        .enableExperimentalFeature("StrictConcurrency=complete"),
        .enableUpcomingFeature("StrictConcurrency=complete"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("ConciseMagicFile"),
        .enableUpcomingFeature("ImplicitOpenExistentials"),
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
