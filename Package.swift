// swift-tools-version:5.10
import PackageDescription

let package = Package(
  name: "FormSheetTextView",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "FormSheetTextView",
      targets: ["FormSheetTextView"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
        name: "FormSheetTextView",
        dependencies: [],
        path: "Sources"
    ),
    .testTarget(
      name: "FormSheetTextViewTests",
      dependencies: ["FormSheetTextView"]),
  ]
)