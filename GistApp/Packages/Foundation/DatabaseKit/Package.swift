// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DatabaseKit",
    products: [
        .library(
            name: "DatabaseKit",
            targets: ["DatabaseKit"]
        ),
    ],
    targets: [
        .target(
            name: "DatabaseKit",
            resources: [
                .process("Utils/Resources/Entities/")
            ]
        ),
        .testTarget(
            name: "DatabaseKitTests",
            dependencies: ["DatabaseKit"]
        )
    ]
)
