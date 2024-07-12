// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewTesting",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "ViewTestingProd",
            targets: ["ViewTestingProd"]
        ),
        .library(
            name: "ViewTestingTest",
            targets: ["ViewTestingTest"]
        ),
    ],
    targets: [
        .target(
            name: "ViewTestingProd",
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .target(
            name: "ViewTestingTest",
            dependencies: ["ViewTestingProd"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .testTarget(
            name: "UnitTests",
            dependencies: ["ViewTestingTest"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
    ]
)
