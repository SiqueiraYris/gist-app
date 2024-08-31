// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DynamicKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "DynamicKit",
            targets: ["DynamicKit"]
        )
    ],
    targets: [
        .target(
            name: "DynamicKit"),
        .testTarget(
            name: "DynamicKitTests",
            dependencies: ["DynamicKit"]
        )
    ]
)
