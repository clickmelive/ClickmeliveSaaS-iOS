// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Clickmelive",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Clickmelive",
            targets: ["Clickmelive"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.0.0"),
        .package(url: "https://github.com/clickmelive/ClickmeliveSaasAPI.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Clickmelive",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios"),
                .product(name: "ApolloAPI", package: "apollo-ios"),
                .product(name: "ApolloWebSocket", package: "apollo-ios"),
                .product(name: "SDWebImage", package: "SDWebImage"),
                "ClickmeliveSaasAPI",
                "AmazonIVSPlayer"
            ],
            path: "Sources/Clickmelive",
            resources: [
                .process("UI/Shared.xcassets"),
                .process("Core/Domain/Live Event/Presentation/Localization/LiveEvent.xcstrings"),
                .process("Core/Domain/Video/Presentation/Localization/Video.xcstrings")
            ]
        ),
        .binaryTarget(
            name: "AmazonIVSPlayer",
            path: "AmazonIVSPlayer.xcframework"
        ),
    ]
)
