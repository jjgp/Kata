// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "swift",
    products: [
        .library(
            name: "CtCI",
            targets: ["CtCI"]),
        .library(
            name: "LeetCode",
            targets: ["LeetCode"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CtCI",
            dependencies: []),
        .testTarget(
            name: "CtCITests",
            dependencies: ["CtCI"]),
        .target(
            name: "LeetCode",
            dependencies: []),
        .testTarget(
            name: "LeetCodeTests",
            dependencies: ["LeetCode"]),
    ]
)
