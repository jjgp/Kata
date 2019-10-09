// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "swift",
    products: [
        .library(
            name: "LeetCode",
            targets: ["LeetCode"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LeetCode",
            dependencies: []),
        .testTarget(
            name: "LeetCodeTests",
            dependencies: ["LeetCode"]),
    ]
)
