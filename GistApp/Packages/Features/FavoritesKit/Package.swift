// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoritesKit",
    defaultLocalization: LanguageTag(stringLiteral: "pt"),
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FavoritesKit",
            targets: ["FavoritesKit"]
        )
    ],
    dependencies: [
        .package(path: "../Foundation/ComponentsKit"),
        .package(path: "../Foundation/CommonKit"),
        .package(path: "../Foundation/DatabaseKit"),
        .package(path: "../Foundation/RouterKit"),
        .package(path: "../Foundation/DynamicKit")
    ],
    targets: [
        .target(
            name: "FavoritesKit",
            dependencies: [
                "ComponentsKit",
                "CommonKit",
                "DatabaseKit",
                "RouterKit",
                "DynamicKit"
            ],
            resources: [
                .process("Utils/Resources/Strings/")
            ]
        ),
        .testTarget(
            name: "FavoritesKitTests",
            dependencies: ["FavoritesKit"]
        )
    ]
)
