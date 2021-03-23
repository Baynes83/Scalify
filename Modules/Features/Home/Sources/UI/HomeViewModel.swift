import SwiftUI
import NavigationRouter
import Combine
import Resolver

final class HomeViewModel: RoutableViewModel, ObservableObject {
    
    @Injected private var router: HomeRouter
    
    static var requiredParameters: [String]?
    
    var navigationInterceptionExecutionFlow: NavigationInterceptionFlow?
    
    var routedView: AnyView {
        HomeView(viewModel: self).eraseToAnyView()
    }
    
    init(parameters: [String : String]?) {
        
    }
    
    func onSelectedDetail(id: String) {
        router.selectedDetail(id: id)
    }
    
}
