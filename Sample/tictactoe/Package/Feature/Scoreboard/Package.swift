// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Scoreboard",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Scoreboard",
            targets: ["Scoreboard"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/wlsdms0122/Compose.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/wlsdms0122/Route.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0")),
        .package(path: "../../../../.."),
        .package(path: "../../Core/Util"),
        .package(path: "../../Module/Game"),
        .package(path: "../../Module/UI/Resource"),
        .package(path: "../OnGame")
    ],
    targets: [
        .target(
            name: "Scoreboard",
            dependencies: [
                "RVB",
                "Compose",
                "Route",
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                "ReactorKit",
                "Util",
                "Game",
                "Resource",
                "OnGame"
            ]
        )
    ]
)
