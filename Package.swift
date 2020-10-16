// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Package Extension

/// 根据条件进行数据组合
private func ruleSets<Element>(_ items: [[Element]]) -> [Element] {
    return items.flatMap { $0 }
}

/// 总是返回指定数据
private func always<Element>(use items: [Element]) -> [Element] {
    return items
}

/// 返回符合条件的数据
private func when<Element>(_ condition: Bool, use items: [Element]) -> [Element] {
    if condition {
        return items
    } else {
        return []
    }
}

private enum OSPlatform: Equatable {
    case darwin // macOS, iOS, tvOS, watchOS
    case linux // ubuntu(16/18/20) / Amazon Linux 2
    case windows // windows 10²
    
    #if os(macOS)
    static let current = OSPlatform.darwin
    #elseif os(Linux)
    static let current = OSPlatform.linux
    #else
    #error("Unsupported platform.")
    #endif
}


// MARK: - Package

let package = Package(
    name: "OpenSSL",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OpenSSL",
            targets: ["OpenSSL"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: ruleSets([
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        when(OSPlatform.current == .linux, use: [
            .systemLibrary(
                name: "OpenSSL",
                pkgConfig: "openssl",
                providers: [
                    .apt(["openssl libssl-dev"]),
                ]
            ),
        ]),
        when(OSPlatform.current == .darwin, use: [
            .binaryTarget(
                name: "OpenSSL",
                path: "Sources/Framework/OpenSSL.xcframework"
            )
        ]),
    ])
)
