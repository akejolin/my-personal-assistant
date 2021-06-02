import ReSwift
import SwiftReduxRouter

struct UserActions {
    struct SetUser: Action {
        var user: UserModels.User
    }

    struct LogoutUser: Action {}

    struct UpdateUserForm: Action {
        var username: String
        var password: String
    }

    struct SubmitLogin: ConnectedAction {
        func handle(dispatch: (Action) -> Void, state: MainState) {
            dispatch(SubmitSuccess(user: UserModels.createFakeUser()))
        }
    }

    struct SubmitSuccess: ConnectedAction {
        func handle(dispatch: (Action) -> Void, state: MainState) {
            dispatch(NavigationActions.Push(path: NavigationPath(RouterView.dismissActionIdentifier), target: "login"))
        }

        var user: UserModels.User
    }
}
