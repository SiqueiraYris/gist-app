// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GistDetailKit",
    defaultLocalization: LanguageTag(stringLiteral: "pt"),
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
        .package(path: "../Foundation/DynamicKit"),
        .package(path: "../Foundation/NetworkKit"),
        .package(path: "../Foundation/StorageKit")
    ],
    targets: [
        .target(
            name: "GistDetailKit",
            dependencies: [
                "ComponentsKit",
                "CommonKit",
                "DynamicKit",
                "NetworkKit",
                "StorageKit"
            ],
            resources: [
                .process("Utils/Resources/Strings/"),
//                .process("Utils/Resources/Entities/")
            ]
        ),
        .testTarget(
            name: "GistDetailKitTests",
            dependencies: ["GistDetailKit"]
        )
    ]
)
