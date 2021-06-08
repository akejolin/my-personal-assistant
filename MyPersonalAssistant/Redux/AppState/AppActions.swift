import LindebrosApiClient
import ReSwift

struct AppActions {
    struct TestAction: Action {
        var payload: String
    }

    struct HelloWorldAction: ConnectedAction {
        let payload: String

        func handle(dispatch: (Action) -> Void, state: MainState) {
            dispatch(TestAction(payload: "hello awesome"))
        }
    }

    struct HelloWorldResponseAction: Action {
        let payload: Any
    }

    struct AppStatusAction: Action {
        let status: AppModels.AppStatus
    }
}
