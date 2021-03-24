import SwiftUI

public protocol ScaleFinderRouter {

    func scaleFinderFinished(withResult result: Result<Void, Error>)

}
