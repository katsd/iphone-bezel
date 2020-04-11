// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "iPhoneBezel",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "iPhoneBezel",
            targets: ["iPhoneBezel"]),
    ],
    targets: [
        .target(
            name: "iPhoneBezel",
            dependencies: [],
            path: "Sources"),
    ]
)
