import SwiftUI
import NavigationRouter

struct HomeView: RoutableView {
    
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        
            ScrollView {
                
                VStack {
                    ForEach(0..<10) { index in
                        Text("What's this").onTapGesture {
                            viewModel.onSelectedDetail(id: "\(index)")
                        }
                    }
                }
                
        }
        
    }

}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(parameters: nil))
    }
}
