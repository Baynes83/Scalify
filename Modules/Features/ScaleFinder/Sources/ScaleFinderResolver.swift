import Foundation
import Resolver

public extension Resolver {
    
    static func resolveScaleFinder() {
        
        register { GetScalesInteractor() as GetScalesInteractor }
        register { ScaleFinderRepositoryImpl() as ScaleFinderRepository }
        
    }
    
}
