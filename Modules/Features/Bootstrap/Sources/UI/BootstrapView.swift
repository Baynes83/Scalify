import SwiftUI

struct BootstrapView: View {
    
    @ObservedObject private var viewModel: BootstrapViewModel
    
    init(viewModel: BootstrapViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        return Text("BootstrapView")
            .onAppear(perform: viewModel.onResume)
    }

}

struct BootstrapView_Previews: PreviewProvider {
    
    struct HelperRouter: BootstrapRouter {
        func bootstrapFinished(withResult result: Result<BootstrapState, Error>) {
        }
    }
    
    static var previews: some View {
        BootstrapView(viewModel: BootstrapViewModel(router: HelperRouter()))
    }
}
