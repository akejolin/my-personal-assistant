import ReSwift
import SwiftUI
import SwiftReduxRouter
struct LoginView: Connector, View {
    @ObservedObject var userState: UserState
    var dispatch: (Action) -> Void
    var session: NavigationSession

    var body: some View {
        VStack {
            MDTextField(value: userState.form.data.username, placeholder: "Ditt användarnamn", onChange: { text in
                dispatch(UserActions.UpdateUserForm(username: text, password: userState.form.data.password))
            }, onCommit: { text in
                dispatch(UserActions.UpdateUserForm(username: text, password: userState.form.data.password))
            })

            MDTextField(value: userState.form.data.password, placeholder: "Ditt lösenord", type: .securedField, onChange: { text in
                dispatch(UserActions.UpdateUserForm(username: userState.form.data.username, password: text))
            }, onCommit: { text in
                dispatch(UserActions.UpdateUserForm(username: userState.form.data.username, password: text))
            })

            ActionButtonView(.cta, action: {
                dispatch(UserActions.SubmitLogin())
            }) {
                HStack {
                    Text("Logga in")
                }
            }
        }
        .padding(16)
        .background(Color.black)
    }
}

struct LoginView_Previews: PreviewProvider {
    struct LoginWallPreview: View {
        @State private var isFlipped: Bool = false

        let store: Store<MainState>

        init() {
            store = MainState.createStore()
        }

        var body: some View {
            LoginView(
                userState: store.state.user,
                dispatch: store.dispatch,
                session: NavigationSession(name: "", path: NavigationPath(""))
            )
        }
    }

    static var previews: some View {
        LoginWallPreview()
    }
}
