import Foundation
import CleanArch
import Combine
import Resolver

final class GetBootstrapStateInteractor: Interactor {
    
    @Injected private var appStateRepository: BootstrapRepository
    
    typealias T = EmptyRequestValues
    typealias U = BootstrapState
    typealias V = Error
    
    func buildInteractorPublisher(requestValues: EmptyRequestValues) -> AnyPublisher<BootstrapState, Error> {
        appStateRepository.getUserIsAuthenticated()
        .map { isAuthenticated -> BootstrapState in
            if isAuthenticated {
                return .authenticated
            }
            
            return .unauthenticated
        }.eraseToAnyPublisher()
    }
    
}
