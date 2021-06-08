import Combine
import Foundation
import ReSwift

class UserState: StateType, ObservableObject {
    @Published fileprivate(set) var isLoggedIn = false
    @Published fileprivate(set) var user: UserModels.User? = nil
    @Published fileprivate(set) var auth = UserModels.Auth(bearerToken: "", type: .anonymous)
    @Published fileprivate(set) var form = UserModels.LoginForm(data: UserModels.LoginFormData(username: "", password: ""))
}

extension UserState {
    static func reducer(action: Action, state: UserState?) -> UserState {
        let state = state ?? UserState()

        switch action {
        
        case let a as UserActions.SetUser:
            state.isLoggedIn = true
            state.user = a.user
        case _ as UserActions.LogoutUser:
            state.isLoggedIn = false
            state.user = nil
        case let a as UserActions.UpdateUserForm:
            state.form.data = UserModels.LoginFormData(username: a.username, password: a.username)
        case let a as UserActions.SubmitSuccess:
            state.user = a.user
            state.isLoggedIn = true
        default:
            break
        }
        return state
    }
}

extension UserState: Encodable {
    enum CodingKeys: CodingKey {
        case isLoggedIn
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isLoggedIn, forKey: .isLoggedIn)
    }
}


