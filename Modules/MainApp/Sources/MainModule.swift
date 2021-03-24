import NavigationRouter

final class MainModule: RoutableModule {
    
    static let id = "/"
    
    func registerRoutes() {
        let mainRoute = NavigationRoute(path: Self.id, type: MainAppViewModel.self, requiresAuthentication: false)
        NavigationRouter.bind(route: mainRoute)
    }
    
}
