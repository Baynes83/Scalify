import ProjectDescription
let nameAttribute: Template.Attribute = .required("name")

let appTemplateContents = """
import SwiftUI

@main
struct Main {
    static func main() {
        if #available(iOS 14.0, *) {
            \(nameAttribute).main()
        } else {
            UIApplicationMain(
                CommandLine.argc,
                CommandLine.unsafeArgv,
                nil,
                NSStringFromClass(AppDelegate.self)
            )
        }
    }
}

@available(iOS 14.0, *)
struct \(nameAttribute): App {
    var body: some Scene {
        WindowGroup {
            Text("\(nameAttribute)")
        }
    }
}
"""

let appDelegateTemplate = """
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
"""

let sceneDelegateTemplate = """
import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = \(nameAttribute)View()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
"""

let template = Template(
    description: "App module template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "iOS"),
    ],
    files: [
        .string(path: "Modules/\(nameAttribute)/Sources/\(nameAttribute).swift",
                contents: appTemplateContents),
        .string(path: "Modules/\(nameAttribute)/Sources/AppDelegate.swift",
                contents: appDelegateTemplate),
        .string(path: "Modules/\(nameAttribute)/Sources/SceneDelegate.swift",
                contents: sceneDelegateTemplate),
        .file(path: "Modules/\(nameAttribute)/UITests/\(nameAttribute)UITests.swift",
              templatePath: "../stencils/uiTests.stencil"),
        .file(path: "Modules/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
              templatePath: "../stencils/unitTests.stencil"),
        .file(path: "Modules/\(nameAttribute)/Resources/assets.xcassets/Contents.json",
              templatePath: "../stencils/xcassets.stencil"),
        .file(path: "Modules/\(nameAttribute)/Resources/assets.xcassets/AppIcon.appiconset/Contents.json",
              templatePath: "../stencils/appIcon.stencil"),
        .file(path: "Modules/\(nameAttribute)/Sources/UI/\(nameAttribute)View.swift",
              templatePath: "../stencils/swiftuiView.stencil")
    ]
)
