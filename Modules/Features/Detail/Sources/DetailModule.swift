import NavigationRouter

public final class DetailModule: RoutableModule {
    
    public static let id = "/detail"
    
    public init() {}
    
    public func registerRoutes() {
        let detailRoute = NavigationRoute(path: Self.id, type: DetailViewModel.self)
        NavigationRouter.bind(route: detailRoute)
    }
    
}
