import Foundation
import Combine

final class BootstrapRepositoryImpl: BootstrapRepository {
    
    func getUserIsAuthenticated() -> AnyPublisher<Bool, Error> {
        return Future { promise in
            promise(.success(true))
        }.eraseToAnyPublisher()
    }
    
}
