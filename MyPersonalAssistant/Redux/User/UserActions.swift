import ReSwift
import SwiftReduxRouter
import LindebrosApiClient


struct Response: Decodable {
   var someProperty: String
}

struct Body: Encodable {
   var name: String
   var title: String
}

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
        
        let client = LindebrosApiClient(
            baseURL: "http://localhost:8081",
            logLevel: .debug
        )
        let request = RequestModel<Response, ErrorResonse, Body>(
          endpoint: "/some/endpoint",
          method: .post,
          data: Body(name: "Awesome", title: "Boss")
        )
        

        
        func handle(dispatch: (Action) -> Void, state: MainState) {
            
            client.call(
              request,
              bearerToken: "bearerToken"
            ) { response in
              if response.isOk {
                print(response.someProperty)
              }
            }
            
            //dispatch(SubmitSuccess(user: UserModels.createFakeUser()))
        }
    }

    struct SubmitSuccess: ConnectedAction {
        func handle(dispatch: (Action) -> Void, state: MainState) {
            dispatch(NavigationActions.Push(path: NavigationPath(RouterView.dismissActionIdentifier), target: "login"))
        }

        var user: UserModels.User
    }
}
