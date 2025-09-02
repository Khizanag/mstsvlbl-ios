// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mstsvlbl_Core_DeepLinking",
    platforms: [
        .iOS(.v18),
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Mstsvlbl_Core_DeepLinking",
            targets: ["Mstsvlbl_Core_DeepLinking"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Mstsvlbl_Core_DeepLinking"),
        .testTarget(
            name: "Mstsvlbl_Core_DeepLinkingTests",
            dependencies: ["Mstsvlbl_Core_DeepLinking"]),
    ]
)
