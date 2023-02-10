// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Util",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Util",
            targets: ["Util"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        .target(
            name: "Util",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                "ReactorKit"
            ]
        )
    ]
)
