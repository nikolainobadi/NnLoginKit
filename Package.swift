// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnLoginKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "NnLoginKit",
            targets: ["NnLoginKit"]),
        .library(
            name: "LoginUI",
            targets: ["LoginUI"]),
        .library(
            name: "LoginLogic",
            targets: ["LoginLogic"]),
    ],
    dependencies: [
        .package(name: "NnUIKitHelpers",
                 url: "https://github.com/nikolainobadi/NnUIKitHelpers.git",
                 branch: "main")
    ],
    targets: [
        .target(
            name: "NnLoginKit",
            dependencies: ["LoginUI"]),
        .testTarget(
            name: "NnLoginKitTests",
            dependencies: ["NnLoginKit"]),
        .target(
            name: "LoginUI",
            dependencies: ["LoginLogic", "NnUIKitHelpers"]),
        .testTarget(
            name: "LoginUITests",
            dependencies: ["LoginUI", "TestHelpers"]),
        .target(
            name: "LoginLogic",
            dependencies: []),
        .testTarget(
            name: "LoginLogicTests",
            dependencies: ["LoginLogic", "TestHelpers"]),
        .target(
            name: "TestHelpers",
            dependencies: []),
    ]
)
