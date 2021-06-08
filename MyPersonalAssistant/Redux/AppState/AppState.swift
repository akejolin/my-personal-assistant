import Combine
import Foundation
import ReSwift

class AppState: StateType, ObservableObject {
    @Published fileprivate(set) var helloWorld = ""
    @Published fileprivate(set) var status: AppModels.AppStatus = .notLauched
}

extension AppState {
    static func reducer(action: Action, state: AppState?) -> AppState {
        let state = state ?? AppState()

        switch action {
        case let a as AppActions.TestAction:
            state.helloWorld = a.payload

        case let a as AppActions.AppStatusAction:
            state.status = a.status
        default:
            break
        }
        return state
    }
}

extension AppState: Encodable {
    enum CodingKeys: CodingKey {
        case helloWorld, status
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(helloWorld, forKey: .helloWorld)
        try container.encode(status, forKey: .status)
    }
}
