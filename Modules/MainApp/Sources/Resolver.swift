import Foundation
import Resolver
import NavigationRouter

import ScaleFinder

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        Resolver.defaultScope = Resolver.application
        
        register { NavigationRouter.main }
        RoutableModulesFactory.loadRoutableModules()
        
        resolveScaleFinder()
    }
    
}
