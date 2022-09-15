// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DocCMiddleware-Example",
    platforms: [
        .macOS(.v12),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.65.1"),
        .package(url: "https://github.com/bdrelling/DocCMiddleware", from: "0.1.1"),
    ],
    targets: [
        // Example
        .executableTarget(
            name: "Example",
            dependencies: [
                .product(name: "DocCMiddleware", package: "DocCMiddleware"),
                .product(name: "Vapor", package: "vapor"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
    ]
)

#if swift(>=5.6)
// Add Kipple Tools if possible.
package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
)
#endif