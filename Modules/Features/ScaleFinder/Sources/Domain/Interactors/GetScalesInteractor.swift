import Foundation
import CleanArch
import Combine
import Resolver

struct GetScalesRequestValues: RequestValues {
    
    let notes: String
    
}

final class GetScalesInteractor: Interactor {
    
    @Injected private var repository: ScaleFinderRepository
    
    typealias T = GetScalesRequestValues
    typealias U = [Scale]
    typealias V = Error
    
    func buildInteractorPublisher(requestValues: GetScalesRequestValues) -> AnyPublisher<[Scale], Error> {
        repository.getScales(notes: requestValues.notes)
            .eraseToAnyPublisher()
    }
    
}
