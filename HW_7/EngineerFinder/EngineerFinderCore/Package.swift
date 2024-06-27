// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EngineerFinderCore",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "EngineerFinderCore",
            targets: ["EngineerFinderCore"]
        ),
    ],
    targets: [
        .target(
            name: "EngineerFinderCore"
        ),
        .testTarget(
            name: "EngineerFinderCoreTests",
            dependencies: ["EngineerFinderCore"],
            resources: [
                .process("Model/Employee/MockJSONs/"),
                .process("Model/TeamDecoder/MockJSONs/"),
                .process("Model/Team/MockJSONs/"),
                .process("Controller/MockJSONs/"),
            ]
        ),
    ]
)
