// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoritesKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FavoritesKit",
            targets: ["FavoritesKit"]),
    ],
    targets: [
        .target(
            name: "FavoritesKit"),
        .testTarget(
            name: "FavoritesKitTests",
            dependencies: ["FavoritesKit"]),
    ]
)
