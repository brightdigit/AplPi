// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AplPi",
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "AplPi",
      targets: ["AplPi"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/shibapm/Komondor", from: "1.1.2"), // dev
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.47.0"), // dev
    .package(url: "https://github.com/realm/SwiftLint", from: "0.43.0"), // dev
    .package(url: "https://github.com/brightdigit/swift-test-codecov", from: "1.0.0"), // dev
    .package(url: "https://github.com/shibapm/Rocket", from: "1.2.0") // dev
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "AplPi",
      dependencies: []
    ),
    .testTarget(
      name: "AplPiTests",
      dependencies: ["AplPi"]
    )
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let requiredCoverage: Int = 0.0

  let config = PackageConfiguration([
    "komondor": [
      "pre-push": [
        "swift test --enable-code-coverage --enable-test-discovery"
        // swiftlint:disable:next line_length
        // "swift run swift-test-codecov .build/debug/codecov/AplPi.json --minimum \(requiredCoverage)"
      ],
      "pre-commit": [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
