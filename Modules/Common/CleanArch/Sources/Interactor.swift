import Foundation
import Combine

public protocol Interactor {
    associatedtype T: RequestValues
    associatedtype U
    associatedtype V: Error
    
    func buildInteractorPublisher(requestValues: T) -> AnyPublisher<U, V>
    
    func execute(withRequestValues requestValues: T) -> AnyPublisher<U, V>
    
}

public extension Interactor {
    
    func execute(withRequestValues requestValues: T) -> AnyPublisher<U, V> {
        buildInteractorPublisher(requestValues: requestValues)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

public extension Interactor where T == EmptyRequestValues {
    
    func execute() -> AnyPublisher<U, V> {
        buildInteractorPublisher(requestValues: EmptyRequestValues())
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
