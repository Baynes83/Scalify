import SwiftUI
import NavigationRouter
import Combine
import Resolver

final class DetailViewModel: RoutableViewModel, ObservableObject {
    
    @Injected private var router: DetailRouter
    
    static var requiredParameters: [String]?
    var navigationInterceptionExecutionFlow: NavigationInterceptionFlow?
    
    var routedView: AnyView {
        DetailView(viewModel: self).eraseToAnyView()
    }
    
    init(parameters: [String : String]?) {
        
    }
    
}
