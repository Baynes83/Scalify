import ProjectDescription
import Foundation

public enum uFeatureTarget: CaseIterable {
    case framework
    case tests
    case examples
    case testing
}

extension Target {
    public static func makeAppTargets(
        name: String,
        deploymentTarget: ProjectDescription.DeploymentTarget,
        dependencies: [ProjectDescription.TargetDependency] = [],
        testDependencies: [String] = []
    ) -> [Target] {
        
        let sourcesPath = "Modules/\(name)/Sources"
        let resourcesPath = "Modules/\(name)/Resources"
        let testsPath = "Modules/\(name)/Tests"
        let uiTestsPath = "Modules/\(name)/UITests"
        
        if !moduleExists(name: name) {
            runTuistCommand("tuist scaffold app --name \(name)")
        }
        
        let appConfigurations: [CustomConfiguration] = [
            .debug(
                name: "Debug",
                settings: [String: SettingValue](),
                xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")
            ),
            .debug(
                name: "Acceptance",
                settings: [String: SettingValue](),
                xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")
            ),
            .release(
                name: "Release",
                settings: [String: SettingValue](),
                xcconfig: .relativeToRoot("Configurations/iOS/iOS-Application.xcconfig")
            )
        ]
        
        let testsConfigurations: [CustomConfiguration] = [
            .debug(
                name: "Debug",
                settings: [String: SettingValue](),
                xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")
            ),
            .debug(
                name: "Acceptance",
                settings: [String: SettingValue](),
                xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")
            ),
            .release(
                name: "Release",
                settings: [String: SettingValue](),
                xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")
            ),
        ]
        
        let targetDependencies = dependencies
        
        return [
            Target(
                name: name,
                platform: .iOS,
                product: .app,
                bundleId: "${inherited}",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(
                    with: [
                        "UILaunchStoryboardName": "LaunchScreen",
                        "UIApplicationSceneManifest": [
                            "UIApplicationSupportsMultipleScenes": false,
                            "UISceneConfigurations": [
                                "UIWindowSceneSessionRoleApplication": [
                                    [
                                        "UISceneConfigurationName": "Default Configuration",
                                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                    ]
                                ]
                            ]
                        ]
                    ]
                ),
                sources: ["\(sourcesPath)/**/*.swift"],
                resources: ["\(resourcesPath)/**/*"],
                dependencies: targetDependencies,
                settings: Settings(configurations: appConfigurations)
            ),
            Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "${inherited}",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["\(testsPath)/**/*.swift"],
                dependencies: [
                    .target(name: name),
                    .xctest
                ] + testDependencies.map({ .target(name: $0) }),
                settings: Settings(configurations: testsConfigurations)
            ),
            Target(
                name: "\(name)UITests",
                platform: .iOS,
                product: .uiTests,
                bundleId: "${inherited}",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["\(uiTestsPath)/**/*.swift"],
                dependencies: [
                    .target(name: name),
                    .xctest
                ] + testDependencies.map({ .target(name: $0) }),
                settings: Settings(configurations: testsConfigurations)
            )
        ]
    }
    
    public static func makeFeatureTargets(
        name: String,
        product: ProjectDescription.Product = .framework,
        deploymentTarget: ProjectDescription.DeploymentTarget,
        dependencies: [ProjectDescription.TargetDependency] = [],
        testDependencies: [String] = [],
        targets: Set<uFeatureTarget> = Set(uFeatureTarget.allCases),
        sdks: [String] = [],
        dependsOnXCTest: Bool = false
    ) -> [Target] {
        
        let rootModuleDir = "Features"
        if !moduleExists(rootModuleDir: rootModuleDir, name: name) {
            runTuistCommand("tuist scaffold feature --name \(name)")
        }
        
        return makeFrameworkTargets(
            name: name,
            rootModuleDir: rootModuleDir,
            deploymentTarget: deploymentTarget,
            dependencies: dependencies,
            testDependencies: testDependencies,
            targets: targets,
            sdks: sdks,
            dependsOnXCTest: dependsOnXCTest
        )
    }
    
    public static func makeCommonTargets(
        name: String,
        product: ProjectDescription.Product = .framework,
        deploymentTarget: ProjectDescription.DeploymentTarget,
        dependencies: [ProjectDescription.TargetDependency] = [],
        testDependencies: [String] = [],
        targets: Set<uFeatureTarget> = Set(uFeatureTarget.allCases),
        sdks: [String] = [],
        dependsOnXCTest: Bool = false
    ) -> [Target] {
        
        let rootModuleDir = "Common"
        if !moduleExists(rootModuleDir: rootModuleDir, name: name) {
            runTuistCommand("tuist scaffold common --name \(name)")
        }
        
        return makeFrameworkTargets(
            name: name,
            rootModuleDir: rootModuleDir,
            deploymentTarget: deploymentTarget,
            dependencies: dependencies,
            testDependencies: testDependencies,
            targets: targets,
            sdks: sdks,
            dependsOnXCTest: dependsOnXCTest
        )
    }
    
    private static func makeFrameworkTargets(
        name: String,
        product: ProjectDescription.Product = .framework,
        rootModuleDir: String,
        deploymentTarget: ProjectDescription.DeploymentTarget,
        dependencies: [ProjectDescription.TargetDependency] = [],
        testDependencies: [String] = [],
        targets: Set<uFeatureTarget> = Set(uFeatureTarget.allCases),
        sdks: [String] = [],
        dependsOnXCTest: Bool = false
    ) -> [Target] {
        
        // Configurations
        let frameworkConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
            .debug(name: "Acceptance", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
            .release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
        ]
        let testsConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
            .debug(name: "Acceptance", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig")),
            .release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
        ]
        
        // Test dependencies
        let targetTestDependencies: [TargetDependency] = [
            .target(name: "\(name)"),
            .xctest,
        ] + testDependencies.map({ .target(name: $0) })
        
        // Target dependencies
        var targetDependencies = dependencies
        targetDependencies.append(contentsOf: sdks.map { .sdk(name: $0) })
        if dependsOnXCTest {
            targetDependencies.append(.xctest)
        }
        
        // Targets
        var projectTargets: [Target] = []
        if targets.contains(.framework) {
            
            let path = "Modules/\(rootModuleDir)/\(name)/Sources"
            
            projectTargets.append(
                Target(
                    name: name,
                    platform: .iOS,
                    product: product,
                    bundleId: "${inherited}.\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: ["\(path)/**/*.swift"],
                    dependencies: targetDependencies,
                    settings: Settings(configurations: frameworkConfigurations)
                )
            )
        }
        if targets.contains(.tests) {
            
            let path = "Modules/\(rootModuleDir)/\(name)/Tests"
            
            projectTargets.append(
                Target(
                    name: "\(name)Tests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "${inherited}.\(name)Tests",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: ["\(path)/**/*.swift"],
                    dependencies: targetTestDependencies,
                    settings: Settings(configurations: testsConfigurations)
                )
            )
        }
        return projectTargets
    }
    
    @discardableResult
    private static func runTuistCommand(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.arguments = ["-c", "\(FileManager.default.currentDirectoryPath)/.tuist-bin/\(command)"]
        task.launchPath = "/bin/zsh"
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        task.waitUntilExit()
        
        return output
    }
    
    private static func moduleExists(rootModuleDir: String? = nil, name: String) -> Bool {
        let rootDir = FileManager.default.currentDirectoryPath
        let rootURL = URL(string: rootDir)!
        var rootModuleDirPath = ""
        if let rootModuleDir = rootModuleDir {
            rootModuleDirPath.append("/\(rootModuleDir)")
        }
        let dataPath = rootURL.appendingPathComponent("Modules\(rootModuleDirPath)/\(name)", isDirectory: true)
        return FileManager.default.fileExists(atPath: dataPath.absoluteString)
    }
}
