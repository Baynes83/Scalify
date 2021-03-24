import SwiftUI
import NavigationRouter

struct ScaleFinderView: RoutableView {
    
    @ObservedObject var viewModel: ScaleFinderViewModel
    
    init(viewModel: ScaleFinderViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        
        ScrollView {
            
            VStack {
                TextField("Enter note(s)", text: $viewModel.input)
                
                Button("Find scales") {
                    viewModel.onSearch()
                }
                
                ForEach(viewModel.output, id: \.id) { output in
                    Text(output.value)
                }
                .padding(.vertical)
                
            }.padding(.horizontal)
            
        }
        
    }

}

struct ScaleFinderView_Previews: PreviewProvider {
    
    static var previews: some View {
        ScaleFinderView(viewModel: ScaleFinderViewModel(parameters: nil))
    }
}
