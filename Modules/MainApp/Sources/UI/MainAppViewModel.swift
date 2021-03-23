import SwiftUI
import NavigationRouter

final class MainAppViewModel: RoutableViewModel, ObservableObject {
    
    @Published var appState: AppState = .bootstrap
    
    static var requiredParameters: [String]?
    
    var navigationInterceptionExecutionFlow: NavigationInterceptionFlow?
    
    init(parameters: [String : String]?) {
        
    }
    
    var routedView: AnyView {
        MainAppView(viewModel:self).eraseToAnyView()
    }
    
}
