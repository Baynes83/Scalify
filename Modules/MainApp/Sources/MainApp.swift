import SwiftUI
import NavigationRouter
import UIKit

@main
struct Main {
    static func main() {
//        if #available(iOS 14.0, *) {
//            RoutableModulesFactory.loadRoutableModules()
//            MainApp.main()
//        } else {
            UIApplicationMain(
                CommandLine.argc,
                CommandLine.unsafeArgv,
                nil,
                NSStringFromClass(AppDelegate.self)
            )
//        }
    }
}

//@available(iOS 14.0, *)
//struct MainApp: App {
//    var body: some Scene {
//        WindowGroup {
//            NavigationRouter.main.viewFor(path: MainModule.id)
//        }
//    }
//}
