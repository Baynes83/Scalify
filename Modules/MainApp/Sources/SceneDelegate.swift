import UIKit
import SwiftUI
import NavigationRouter

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let mainView = NavigationRouter.main.viewControllerFor(path: MainModule.id) else {
            return
        }

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController(rootViewController: mainView)
            navigationController.navigationBar.prefersLargeTitles = true
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
