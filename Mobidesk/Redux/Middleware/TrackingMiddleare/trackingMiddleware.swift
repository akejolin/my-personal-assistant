import Foundation
import ReSwift


let trackingMiddleware: Middleware<MainState> = { dispatch, state in
    { next in
        { action in

            
            return next(action)
        }
    }
}
