public struct DecodedArray<T: Decodable>: Decodable {

    public typealias DecodedArrayType = [T]

    private var array: DecodedArrayType

    // Define DynamicCodingKeys type needed for creating decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }

    public init(from decoder: Decoder) throws {

        // Create decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = DecodedArrayType()

        // Loop through each keys in container
        for key in container.allKeys {
            // Decode T using key & keep decoded T object in tempArray
            let decodedObject = try container.decode(T.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        // Finish decoding all T objects. Thus assign tempArray to array.
        array = tempArray
    }
}

// Transform DecodedArray into custom collection
extension DecodedArray: Collection {

    // Required nested types, that tell Swift what our collection contains
    public typealias Index = DecodedArrayType.Index
    public typealias Element = DecodedArrayType.Element

    // The upper and lower bounds of the collection, used in iterations
    public var startIndex: Index { return array.startIndex }
    public var endIndex: Index { return array.endIndex }

    // Required subscript, based on a dictionary index
    public subscript(index: Index) -> Iterator.Element {
        get { return array[index] }
    }

    // Method that returns the next index when iterating
    public func index(after i: Index) -> Index {
        return array.index(after: i)
    }
}
