import Foundation
import Combine

protocol BootstrapRepository {
    
    func getUserIsAuthenticated() -> AnyPublisher<Bool, Error>
    
}
