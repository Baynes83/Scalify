import SwiftUI
import NavigationRouter

struct DetailView: RoutableView {
    
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        return Text("DetailView")
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(parameters: nil))
    }
}
