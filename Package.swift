// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnLoginKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "NnLoginKit", targets: ["NnLoginKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "7.0.0"),
        .package(url: "https://github.com/nikolainobadi/NnSwiftUIErrorHandling.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "NnLoginKit",
            dependencies: [
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "NnSwiftUIErrorHandling", package: "NnSwiftUIErrorHandling"),
            ],
            path: "Sources",
            resources: [
                .process("Resources/Assets.xcassets")
            ]
        ),
    ]
)
