import Foundation

struct ScaleDto: Decodable {

    let rootNote: String
    let mode: String
    let notes: String

    init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()
        
        let notes = try container.decode(String.self)
        
        self.rootNote = container.codingPath[1].stringValue // Contains rootNote in json structure
        self.mode = container.codingPath[2].stringValue // Contains mode in json structure
        self.notes = notes
    
    }
}

extension ScaleDto {
    
    func mapToDomain() -> Scale {
        
        Scale(
            rootNote: self.rootNote,
            mode: self.mode,
            notes: self.notes
        )
        
    }
    
}

extension Array where Element == ScaleDto {
    
    func mapToDomain() -> [Scale] {
        map { $0.mapToDomain() }
    }
    
}

