// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Remote",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Remote",
            targets: ["Remote"]),
    ],
    dependencies: [
        .package(url: "https://github.com/wlsdms0122/Compose.git", exact: "1.1.0"),
        .package(url: "https://github.com/wlsdms0122/Route.git", exact: "1.2.0"),
        .package(url: "https://github.com/wlsdms0122/Deeplinker.git", exact: "1.1.1"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", exact: "6.5.0"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", exact: "3.2.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources", .upToNextMajor(from: "5.0.2")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0")
    ],
    targets: [
        .target(
            name: "Remote",
            dependencies: [
                "Compose",
                "Route",
                "Deeplinker",
                "RxSwift",
                "ReactorKit",
                "RxDataSources",
                "SnapKit"
            ]
        )
    ]
)
