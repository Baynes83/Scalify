import NavigationRouter

public final class ScaleFinderModule: RoutableModule {
    
    public static let id = "/scale_finder"
    
    public init() {}
    
    public func registerRoutes() {
        let route = NavigationRoute(path: Self.id, type: ScaleFinderViewModel.self)
        NavigationRouter.bind(route: route)
    }
    
}
