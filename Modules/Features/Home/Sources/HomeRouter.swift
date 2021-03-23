import SwiftUI

public protocol HomeRouter {

    func homeFinished(withResult result: Result<Void, Error>)
    
    func selectedDetail(id: String)

}
