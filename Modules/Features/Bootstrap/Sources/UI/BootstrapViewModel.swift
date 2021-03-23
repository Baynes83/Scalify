import SwiftUI
import Combine

final class BootstrapViewModel: ObservableObject {
    
    private let router: BootstrapRouter
    private let getBootstrapStateInteractor = GetBootstrapStateInteractor()
    
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(router: BootstrapRouter) {
        self.router = router
    }
    
    func onResume() {
        
        getBootstrapStateInteractor
            .execute()
            .receive(on: RunLoop.main)
            .sink (
                receiveCompletion: { [weak self] completion in
                    
                    switch completion {
                    case .failure(let error):
                        self?.router.bootstrapFinished(withResult: .failure(error))
                    case .finished:
                        break
                    }
                    
                }, receiveValue: { [weak self] bootstrapState in
                    self?.router
                        .bootstrapFinished(withResult: .success(bootstrapState))
                })
            .store(in: &cancellableSet)
        
    }
    
}
