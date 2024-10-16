// swift-tools-version: 6.0
import Foundation
import PackageDescription

let shouldBuildForEmbedded = ProcessInfo.processInfo.environment["JAVASCRIPTKIT_EXPERIMENTAL_EMBEDDED_WASM"].flatMap(Bool.init) ?? false

var featureFlags: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

if shouldBuildForEmbedded {
    // currently this work-around only works for SwiftPM package dependencies on branches, not version tags
    // see https://github.com/swiftlang/swift-package-manager/issues/7612
    featureFlags.append(
        .unsafeFlags([
            "-Xfrontend", "-emit-empty-object-file",
        ])
    )
}

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
