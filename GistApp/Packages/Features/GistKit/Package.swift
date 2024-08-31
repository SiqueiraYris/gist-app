// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GistKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GistKit",
            targets: ["GistKit"]
        ),
    ],
    dependencies: [
        .package(path: "../Foundation/ComponentsKit"),
        .package(path: "../Foundation/NetworkKit"),
        .package(path: "../Foundation/RouterKit")
    ],
    targets: [
        .target(
            name: "GistKit",
            dependencies: [
                "ComponentsKit",
                "NetworkKit",
                "RouterKit"
            ]
        ),
        .testTarget(
            name: "GistKitTests",
            dependencies: ["GistKit"]
        ),
    ]
)
