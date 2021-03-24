import SwiftUI
import NavigationRouter
import Resolver

import ScaleFinder

struct MainAppView: RoutableView {
    
    @ObservedObject var viewModel: MainAppViewModel
    
    init(viewModel: MainAppViewModel) {
        self.viewModel = viewModel
        Resolver.register { [self] in self as ScaleFinderRouter }
    }
    
    var body: some View {
        
        switch viewModel.appState {
        case .scaleFinder:
            NavigationRouter.main.viewFor(path: ScaleFinderModule.id)
                .navigationBarTitle("Scalify")
            
        }
    
    }

}

extension MainAppView: ScaleFinderRouter {
    
    func scaleFinderFinished(withResult result: Result<Void, Error>) {
        // No-op
    }
    
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView(viewModel: MainAppViewModel(parameters: nil))
    }
}
