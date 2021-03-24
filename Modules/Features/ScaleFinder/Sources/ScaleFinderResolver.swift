import Foundation
import Resolver


public extension Resolver {
    
    static func resolveScaleFinder() {
        
        register { ScaleFinderRepositoryImpl() as ScaleFinderRepository }
        
    }
    
}
