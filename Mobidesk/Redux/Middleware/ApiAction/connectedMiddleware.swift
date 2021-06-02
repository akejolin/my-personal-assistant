import Foundation
import ReSwift

protocol ConnectedAction: Action {
    func handle(dispatch: (Action) -> Void, state: MainState)
}

let connectedMiddleware: Middleware<MainState> = { dispatch, state in
    { next in
        { action in

            switch action {
            case let a as ConnectedAction:
                let nextAction: Void = next(action)

                guard let state = state() else {
                    return nextAction
                }

                a.handle(dispatch: dispatch, state: state)
                return nextAction
            default:
                break
            }
            return next(action)
        }
    }
}
