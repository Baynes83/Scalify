import SwiftUI
import NavigationRouter
import Resolver

import Bootstrap
import Home
import Detail
import Profile

struct MainAppView: RoutableView {
    
    @ObservedObject var viewModel: MainAppViewModel
    
    init(viewModel: MainAppViewModel) {
        self.viewModel = viewModel
        Resolver.register { [self] in self as HomeRouter } 
    }

    var body: some View {
        
        switch viewModel.appState {
        case .bootstrap:
            BootstrapFactory.create(router: self)
        case .home:
            
            TabView {
                NavigationRouter.main.viewFor(path: HomeModule.id)
                    .tabItem {
                        Image(systemName: "house.circle")
                        Text("Home")
                    }
                
                ProfileFactory.create(router: self)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
            }.navigationBarTitle("Main")
            
        }
    
    }

}

extension MainAppView: BootstrapRouter {
    
    func bootstrapFinished(withResult result: Result<BootstrapState, Error>) {
        
        switch result {
        case .success(let bootstrapState):
            switch bootstrapState {
            case .authenticated:
                viewModel.appState = .home
            case .unauthenticated:
                viewModel.appState = .bootstrap
            }
        case .failure(let error):
            // TODO: handle error
            print(error)
        }
        
    }
    
}

extension MainAppView: HomeRouter {

    func selectedDetail(id: String) {
        NavigationRouter.main.navigate(toPath: DetailModule.id)
    }
    
    func homeFinished(withResult result: Result<Void, Error>) {
        
    }
    
}

extension MainAppView: ProfileRouter {
    
    func profileFinished(withResult result: Result<Void, Error>) {
        
    }
    
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView(viewModel: MainAppViewModel(parameters: nil))
    }
}
