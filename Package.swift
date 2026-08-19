// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NetworkLogger",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NetworkLogger",
            targets: ["NetworkLogger"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "NetworkLogger",
            url: "https://github.com/way2dipak/NetworkLogger/releases/download/1.0.0/NetworkLogger.xcframework.zip",
            checksum: "ddef3598923bbb81b0c8f94c6fbe1576ae07ac158991521a1d8e7580f418c309"
        )
    ]
)
