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
            checksum: "sha256:0984430b129569dbd32e03f8024bbb63760987c14ec696cc9f30ba25f5be564d"
        )
    ]
)
