// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RouterKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RouterKit",
            targets: ["RouterKit"]
        )
    ],
    targets: [
        .target(
            name: "RouterKit"
        ),
        .testTarget(
            name: "RouterKitTests",
            dependencies: ["RouterKit"]
        )
    ]
)
