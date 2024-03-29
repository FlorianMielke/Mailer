// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mailer",
    defaultLocalization: "en",
    platforms: [
      .iOS(.v15)
    ],
    products: [
        .library(
            name: "Mailer",
            targets: ["Mailer"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Mailer",
            dependencies: []),
        .testTarget(
            name: "MailerTests",
            dependencies: ["Mailer"]),
    ],
    swiftLanguageVersions: [.v5]
)
