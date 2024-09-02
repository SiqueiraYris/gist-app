// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StorageKit",
    products: [
        .library(
            name: "StorageKit",
            targets: ["StorageKit"]
        )
    ],
    targets: [
        .target(
            name: "StorageKit",
            resources: [
                .process("Utils/Resources/Entities/")
            ]
        ),
        .testTarget(
            name: "StorageKitTests",
            dependencies: ["StorageKit"]
        )
    ]
)
