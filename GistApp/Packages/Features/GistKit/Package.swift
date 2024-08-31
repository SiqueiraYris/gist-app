// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GistKit",
    defaultLocalization: LanguageTag(stringLiteral: "pt"),
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GistKit",
            targets: ["GistKit"]
        )
    ],
    dependencies: [
        .package(path: "../Foundation/ComponentsKit"),
        .package(path: "../Foundation/NetworkKit"),
        .package(path: "../Foundation/DynamicKit"),
        .package(path: "../Foundation/RouterKit")
    ],
    targets: [
        .target(
            name: "GistKit",
            dependencies: [
                "ComponentsKit",
                "NetworkKit",
                "DynamicKit",
                "RouterKit"
            ],
            resources: [
                .process("Utils/Resources/Strings/")
            ]
        ),
        .testTarget(
            name: "GistKitTests",
            dependencies: ["GistKit"]
        )
    ]
)
