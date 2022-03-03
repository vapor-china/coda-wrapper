// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "coda-wrapper",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v10),
    ],
    products: [
        .library(name: "Coda", targets: ["Coda"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.2.1")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "4.0.0")),
    ],
    targets: [
        .target(name: "Coda", dependencies: []),
        .testTarget(name: "CodaTests",
                   dependencies: ["Coda", "Quick", "Nimble"])
    ]
)
