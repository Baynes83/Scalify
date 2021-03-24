import Foundation
import Utils

struct RootDto: Decodable {
    
    let scales: [ScaleDto]
    
    private enum CodingKeys: String, CodingKey {
        case scales
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let decodedScales = try container.decode(DecodedArray<DecodedArray<ScaleDto>>.self, forKey: .scales)
        
        var scales = [ScaleDto]()
        decodedScales.forEach { decodedModes in
            decodedModes.forEach {
                scales.append($0)
            }
        }
        
        self.scales = scales
        
    }
    
}
