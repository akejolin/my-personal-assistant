import ReSwift
import Foundation
let loggerMiddleware: Middleware<Any> = { _, _ in
    { next in
        { action in
            DispatchQueue.global(qos: .background).async {
                Logger.shared.publish(
                    message: "⚡️Action:",
                    obj: action,
                    level: .debug
                )
            }
            
            
            return next(action)
        }
    }
}
