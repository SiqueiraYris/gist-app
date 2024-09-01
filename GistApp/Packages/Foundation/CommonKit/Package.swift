// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CommonKit",
            targets: ["CommonKit"]
        )
    ],
    targets: [
        .target(
            name: "CommonKit"
        ),
        .testTarget(
            name: "CommonKitTests",
            dependencies: ["CommonKit"]
        )
    ]
)
