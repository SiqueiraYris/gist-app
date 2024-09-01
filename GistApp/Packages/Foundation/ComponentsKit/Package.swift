// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ComponentsKit",
    defaultLocalization: LanguageTag(stringLiteral: "pt"),
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ComponentsKit",
            targets: ["ComponentsKit"]
        )
    ],
    targets: [
        .target(
            name: "ComponentsKit",
            resources: [
                .process("Utils/Resources/Strings/")
            ]
        ),
        .testTarget(
            name: "ComponentsKitTests",
            dependencies: ["ComponentsKit"]
        )
    ]
)
