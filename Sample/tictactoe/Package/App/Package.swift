// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "App",
            targets: ["App"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/wlsdms0122/Deeplinker.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "../../../.."),
        .package(path: "../Remote"),
        .package(path: "../Feature/Root")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                "RVB",
                "Deeplinker",
                "Remote",
                "Root"
            ]
        )
    ]
)
