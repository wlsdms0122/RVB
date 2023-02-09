// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Root",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Root",
            targets: ["Root"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/wlsdms0122/Route.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/wlsdms0122/Deeplinker.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0")),
        .package(path: "../../../../.."),
        .package(path: "../Launch"),
        .package(path: "../SignedOut"),
        .package(path: "../Scoreboard")
    ],
    targets: [
        .target(
            name: "Root",
            dependencies: [
                "RVB",
                "Route",
                "Deeplinker",
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                "ReactorKit",
                "Launch",
                "SignedOut",
                "Scoreboard"
            ]
        )
    ]
)
