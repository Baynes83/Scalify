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
            .target(name: "Bootstrap"),
            .target(name: "Home"),
            .target(name: "Detail"),
            .target(name: "Resolver"),
            .target(name: "SPMDependencies")
        ]
    )
    targets += Target.makeFeatureTargets(
        name: "Bootstrap",
        deploymentTarget: deploymentTarget,
        dependencies: [
            .target(name: "SPMDependencies"),
            .target(name: "Resolver"),
            .target(name: "CleanArch"),
        ]
    )
    targets += Target.makeFeatureTargets(
        name: "Home",
        deploymentTarget: deploymentTarget,
        dependencies: [
            .target(name: "SPMDependencies"),
            .target(name: "Resolver"),
            .target(name: "CleanArch")
        ]
    )
    targets += Target.makeFeatureTargets(
        name: "Detail",
        deploymentTarget: deploymentTarget,
        dependencies: [
            .target(name: "SPMDependencies"),
            .target(name: "Resolver"),
            .target(name: "CleanArch")
        ]
    )
    targets += Target.makeCommonTargets(
        name: "SPMDependencies",
        product: .dynamicLibrary,
        deploymentTarget: deploymentTarget,
        dependencies: [
            .package(product: "NavigationRouter")
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
    return targets
}


let project = Project(
    name: appName,
    packages: [
        .package(url: "https://github.com/corteggo/NavigationRouter", .upToNextMajor(from: "1.0.0"))
    ],
    settings: Settings(configurations: configurations),
    targets: targets(name: appName)
)
