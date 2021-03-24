import ProjectDescription
import ProjectDescriptionHelpers

private let appName = "Scalify"
private let deploymentTarget = ProjectDescription.DeploymentTarget.iOS(targetVersion: "13.0", devices: [.iphone])

let configurations: [CustomConfiguration] = [
    .debug(
        name: "Debug",
        settings: [
            "PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: "com.github.baynes83.\(appName).debug")
        ],
        xcconfig: .relativeToRoot("Configurations/Base/Configurations/Debug.xcconfig")
    ),
    .debug(
        name: "Acceptance",
        settings: [
            "PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: "com.github.baynes83.\(appName).acc")
        ],
        xcconfig: .relativeToRoot("Configurations/Base/Configurations/Debug.xcconfig")
    ),
    .release(
        name: "Release",
        settings: [
            "PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: "com.github.baynes83.\(appName)")
        ],
        xcconfig: .relativeToRoot("Configurations/Base/Configurations/Release.xcconfig")
    )
]

func targets(name: String) -> [Target] {
    var targets = [Target]()
    targets += Target.makeAppTargets(
        name: "MainApp",
        deploymentTarget: deploymentTarget,
        dependencies: [
            .target(name: "ScaleFinder"),
            .target(name: "Resolver"),
            .target(name: "SPMDependencies")
        ]
    )
    targets += Target.makeFeatureTargets(
        name: "ScaleFinder",
        deploymentTarget: deploymentTarget,
        dependencies: [
            .target(name: "SPMDependencies"),
            .target(name: "Resolver"),
            .target(name: "CleanArch"),
            .target(name: "Utils")
        ]
    )
    targets += Target.makeCommonTargets(
        name: "SPMDependencies",
        product: .dynamicLibrary,
        deploymentTarget: deploymentTarget,
        dependencies: [
            .package(product: "NavigationRouter")
        ],
        testDependencies: [
            .package(product: "SnapshotTesting")
        ]
    )
    targets += Target.makeCommonTargets(
        name: "Resolver",
        deploymentTarget: deploymentTarget
    )
    targets += Target.makeCommonTargets(
        name: "CleanArch",
        deploymentTarget: deploymentTarget
    )
    targets += Target.makeCommonTargets(
        name: "Utils",
        deploymentTarget: deploymentTarget
    )
    return targets
}


let project = Project(
    name: appName,
    packages: [
        .package(url: "https://github.com/corteggo/NavigationRouter", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", .upToNextMajor(from: "1.8.1"))
    ],
    settings: Settings(configurations: configurations),
    targets: targets(name: appName)
)
