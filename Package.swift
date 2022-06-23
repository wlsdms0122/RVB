// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RVB",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "RVB",
            targets: [
                "RVB"
            ]
        )
    ],
    dependencies: [
    
    ],
    targets: [
        .target(
            name: "RVB",
            dependencies: [
            
            ]
        )
    ]
)
