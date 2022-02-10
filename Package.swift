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
        .library(
            name: "ResetPasswordUI",
            targets: ["ResetPasswordUI"]),
        .library(
            name: "ResetPasswordLogic",
            targets: ["ResetPasswordLogic"]),
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
        // MARK: Login
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
        // MARK: ResetPassword
        .target(
            name: "ResetPasswordUI",
            dependencies: ["ResetPasswordLogic", "NnUIKitHelpers"]),
        .testTarget(
            name: "ResetPasswordUITests",
            dependencies: ["ResetPasswordUI", "TestHelpers"]),
        .target(
            name: "ResetPasswordLogic",
            dependencies: ["LoginLogic"]),
        .testTarget(
            name: "ResetPasswordLogicTests",
            dependencies: ["ResetPasswordLogic", "TestHelpers"]),
        // MARK: TestHelpers
        .target(
            name: "TestHelpers",
            dependencies: []),
    ]
)
