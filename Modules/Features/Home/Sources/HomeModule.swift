import NavigationRouter

public final class HomeModule: RoutableModule {
    
    public static let id = "/home"
    
    public init() {}
    
    public func registerRoutes() {
        let homeRoute = NavigationRoute(path: Self.id, type: HomeViewModel.self)
        NavigationRouter.bind(route: homeRoute)
    }
    
}
