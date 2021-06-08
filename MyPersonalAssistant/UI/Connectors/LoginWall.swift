import ReSwift
import SwiftUI
/**
 Flips between two views depending on if the user is logged in or not.
 This is view is similar to `SignInContainerController`.
 */
struct LoginWall<JailView: View, LoggedInContent: View>: View {
    /// The jail view is the view that is shown when the user is not logged in
    private let jailView: () -> JailView

    /// loggedInContent is the view that is shown when the user is logged in
    private let loggedInContent: () -> LoggedInContent

    /// The observed user object from the user service. Any change from this object will trigger a new rendering
    @ObservedObject private var userState: UserState

    /// State of the flip view. We need this state to be able to define what view we should present
    @State private var isLoggedIn: Bool = false

    /// We need this state since ios13 and ios14 triggers onAppear differently
    @State private var initialState: Bool = true

    // This is a workaround for iPhone11 pro to get updates when keyboard frame is changed. We just to need to observe changes of the frame to trigger this view to get rendered.
    @ObservedObject private var keyboardResponder = KeyboardResponder()

    init(
        userState: UserState,
        @ViewBuilder jailView: @escaping () -> JailView,
        @ViewBuilder loggedInContent: @escaping () -> LoggedInContent
    ) {
        self.userState = userState
        self.jailView = jailView
        self.loggedInContent = loggedInContent
    }

    var body: some View {
        FlipView(
            front: jailView,
            back: loggedInContent,
            isFlipped: $isLoggedIn
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        .onReceive(userState.$user, perform: { currentUser in

            /// This is a workaround to make ios13 and ios14 to behave equally
            if initialState {
                self.isLoggedIn = userState.isLoggedIn
                initialState = false
                return
            }
            // Trigger an animation in the flip view
            withAnimation(.easeOut(duration: 0.6)) {
                self.isLoggedIn = userState.isLoggedIn
            }
        })
        .onAppear {
            // set the initial presented view.
            self.initialState = false
            self.isLoggedIn = userState.isLoggedIn
        }
    }
}

struct LoginWall_Previews: PreviewProvider {
    struct LoginWallPreview: View {
        @State private var isFlipped: Bool = false

        let store: Store<MainState>

        init() {
            store = MainState.createStore()
        }

        var body: some View {
            LoginWall(
                userState: store.state.user,
                jailView: {
                    VStack {
                        Button(action: {
                            store.dispatch(UserActions.SetUser(user: UserModels.User()))
                        }) {
                            Text("Please, log in")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                }
            ) {
                VStack {
                    Button(action: {
                        store.dispatch(UserActions.LogoutUser())
                    }) {
                        Text("Log me out")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
            }
        }
    }

    static var previews: some View {
        LoginWallPreview()
    }
}
