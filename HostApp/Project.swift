import ProjectDescription

let project = Project(
    name: "HostApp",
    targets: [
        .target(
            name: "HostApp",
            destinations: .macOS,
            product: .app,
            bundleId: "io.tuist.HostApp",
            infoPlist: .default,
            sources: ["App.swift"],
            resources: [],
            dependencies: [
                 .package(product: "ViewTestingProd"),
            ],
            additionalFiles: [
                .folderReference(path: "..")
            ]
        ),
        .target(
            name: "HostAppTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "io.tuist.HostAppTests",
            infoPlist: .default,
            sources: ["Tests.swift"],
            resources: [],
            dependencies: [
                .target(name: "HostApp"),
                .package(product: "ViewTestingTest")
            ]
        ),
    ]
)
