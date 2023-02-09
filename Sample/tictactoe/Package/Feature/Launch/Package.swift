// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Launch",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Launch",
            targets: ["Launch"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.0")),
        .package(path: "../../../../.."),
        .package(path: "../../Module/Game"),
        .package(path: "../../Module/UI/Resource")
    ],
    targets: [
        .target(
            name: "Launch",
            dependencies: [
                "RVB",
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                "ReactorKit",
                "SnapKit",
                "Game",
                "Resource"
            ]
        )
    ]
)
