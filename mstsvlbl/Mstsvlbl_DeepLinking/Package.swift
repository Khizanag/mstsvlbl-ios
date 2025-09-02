// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mstsvlbl_DeepLinking",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Mstsvlbl_DeepLinking",
            targets: ["Mstsvlbl_DeepLinking"]),
    ],
    dependencies: [
        // Add any external dependencies here if needed
    ],
    targets: [
        .target(
            name: "Mstsvlbl_DeepLinking",
            dependencies: []),
        .testTarget(
            name: "Mstsvlbl_DeepLinkingTests",
            dependencies: ["Mstsvlbl_DeepLinking"]),
    ]
)
