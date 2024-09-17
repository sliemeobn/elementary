// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Benchmarks",
    platforms: [.macOS(.v14)],
    products: [],
    dependencies: [
        .package(url: "https://github.com/ordo-one/package-benchmark", from: "1.0.0"),
        .package(path: "../"),
    ],
    targets: [
        .executableTarget(
            name: "ElementaryBenchmarks",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                .product(name: "Elementary", package: "Elementary"),
            ],
            path: "Benchmarks/ElementaryBenchmarks",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark"),
            ]
        ),
    ]
)
