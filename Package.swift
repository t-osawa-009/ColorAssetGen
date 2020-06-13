// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ColorAssetGen",
    products: [
        .executable(name: "ColorAssetGen", targets: ["ColorAssetGen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", from: "0.9.1"),
        .package(url: "https://github.com/JohnSundell/Files.git", from: "4.1.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "3.0.1")
    ],
    targets: [
        .target(
            name: "ColorAssetGen",
            dependencies: ["Commander", "Files", "Yams"]),
        .testTarget(
            name: "ColorAssetGenTests",
            dependencies: ["ColorAssetGen", "Commander", "Files", "Yams"]),
    ]
)
