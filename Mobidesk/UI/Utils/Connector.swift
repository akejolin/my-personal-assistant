import Foundation
import ReSwift

protocol Connector {
    var dispatch: (Action) -> Void { get }
}
