// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GistDetailKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GistDetailKit",
            targets: ["GistDetailKit"]
        )
    ],
    dependencies: [
        .package(path: "../Foundation/ComponentsKit"),
        .package(path: "../Foundation/CommonKit"),
    ],
    targets: [
        .target(
            name: "GistDetailKit",
            dependencies: [
                "ComponentsKit",
                "CommonKit"
            ]
        ),
        .testTarget(
            name: "GistDetailKitTests",
            dependencies: ["GistDetailKit"]
        )
    ]
)
