import Foundation
import Combine

protocol ScaleFinderRepository {
    
    func getScales(notes: String) -> AnyPublisher<[Scale], Error>
    
}
