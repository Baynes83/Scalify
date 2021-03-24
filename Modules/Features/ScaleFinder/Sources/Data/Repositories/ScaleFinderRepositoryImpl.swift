import Foundation
import Combine
import Utils

final class ScaleFinderRepositoryImpl: ScaleFinderRepository {
    
    func getScales(notes: String) -> AnyPublisher<[Scale], Error> {
        
        var urlComponents = URLComponents(string: "http://www.tofret.com/reverse-chord-finder.php")!
        urlComponents.queryItems = [
            URLQueryItem(name: "return-type", value: "json"),
            URLQueryItem(name: "notes", value: notes)
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { json -> [ScaleDto] in
                let result = try JSONDecoder().decode(RootDto.self, from: json.data)
                return result.scales
            }
            .map { $0.mapToDomain() }
            .eraseToAnyPublisher()
        
    }
    
}
