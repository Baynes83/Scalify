import Foundation

@propertyWrapper
public struct Injected<Repository> {
    
    private var container: Resolver?
    private var name: String?
    private var repository: Repository?
    
    public var wrappedValue: Repository {
        mutating get {
            if repository == nil {
                repository = (container ?? Resolver.root).resolve(
                    Repository.self,
                    name: name
                )
            }
            return repository!
        }
        mutating set {
            repository = newValue
        }
    }
    
    public var projectedValue: Injected<Repository> {
        get {
            return self
        }
        mutating set {
            self = newValue
        }
    }
    
    public init(container: Resolver? = nil, name: String? = nil) {
        self.container = container
        self.name = name
    }
    
    public init() {}
}
