import Foundation
import Resolver

public extension Resolver {
    
    static func resolveBootstrap() {
        
        register { BootstrapRepositoryImpl() as BootstrapRepository }
        
    }
    
}
