import SwiftUI
import NavigationRouter
import Combine
import Resolver

struct ScaleFinderViewModelOutput: Identifiable {
    
    let id = UUID()
    let value: String
    
}

final class ScaleFinderViewModel: RoutableViewModel, ObservableObject {
    
    static var requiredParameters: [String]?
    
    @Published var input: String = ""
    @Published var output: [ScaleFinderViewModelOutput] = []
    
    var navigationInterceptionExecutionFlow: NavigationInterceptionFlow?
    
    var routedView: AnyView {
        ScaleFinderView(viewModel: self).eraseToAnyView()
    }
    
    @Injected private var router: ScaleFinderRouter
    @Injected private var getScalesInteractor: GetScalesInteractor
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(parameters: [String : String]?) {}
    
    func onSearch() {
        let requestValues = GetScalesRequestValues(notes: input)
        getScalesInteractor
            .execute(withRequestValues: requestValues)
            .replaceError(with: [Scale]())
            .receive(on: RunLoop.main)
            .map { scales in
                scales.compactMap {
                    ScaleFinderViewModelOutput(
                        value: "\($0.rootNote) \($0.mode): \($0.notes)"
                    )
                }
            }
            .assign(to: \.output, on: self)
            .store(in: &cancellableSet)

    }
    
}
