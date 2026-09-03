// swift-tools-version: 6.4
import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "swift-birecursive-derivation",
    products: [
        .library(name: "Birecursive Derivation", targets: ["Birecursive Derivation"]),
        .library(name: "Birecursive Derivation Core", targets: ["Birecursive Derivation Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-molecules/swift-corecursive-derivation.git", branch: "main"),
        .package(url: "https://github.com/swift-molecules/swift-recursive-derivation.git", branch: "main"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", "603.0.2"..<"604.0.0"),
    ],
    targets: [
        .target(name: "Birecursive Derivation Core", dependencies: [
            .product(name: "Corecursive Derivation Core", package: "swift-corecursive-derivation"),
            .product(name: "Recursive Derivation Core", package: "swift-recursive-derivation"),
            .product(name: "SwiftSyntax", package: "swift-syntax"),
        ]),
        .macro(name: "Birecursive Derivation Macros", dependencies: [
            "Birecursive Derivation Core",
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            .product(name: "SwiftSyntax", package: "swift-syntax"),
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        ]),
        .target(name: "Birecursive Derivation", dependencies: ["Birecursive Derivation Macros"]),
        .testTarget(
            name: "Birecursive Derivation Tests",
            dependencies: ["Birecursive Derivation"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
