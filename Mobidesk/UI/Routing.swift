
import ReSwift
import SwiftReduxRouter
import SwiftUI
import UIKit

struct Routing: View {
    var store: Store<MainState>
    @ObservedObject var navigationState: NavigationState

    init(store: Store<MainState>) {
        self.store = store
        navigationState = store.state.navigation
    }

    var body: some View {
        RouterView(
            navigationState: navigationState,
            routes: [
                // List route
                RouterView.Route(
                    path: "list",
                    render: { _, _, _ in
                        AnyView(
                            ListView(
                                searchState: store.state.search,
                                userState: store.state.user,
                                dispatch: store.dispatch
                            )
                        )
                    }
                ),

                // Test route
                RouterView.Route(
                    path: "test",
                    render: { session, _, _ in
                        AnyView(
                            Button(action: {
                                store.dispatch(
                                    NavigationActions.Push(
                                        path: NavigationPath(RouterView.dismissActionIdentifier
                                        ),
                                        target: session.name
                                    )
                                )
                            }) {
                                Text("You are testing me!")
                            }
                        )
                    }
                ),

                // profile route
                RouterView.Route(
                    path: "profile",
                    render: { session, _, _ in
                        AnyView(
                            ProfileView(userState: store.state.user, dispatch: store.dispatch)
                                .navigationBarHidden(true)
                        )
                    }
                ),

                // Login route
                RouterView.Route(
                    path: "login",
                    render: { session, _, _ in
                        AnyView(
                            LayoutTheme {
                                LoginView(userState: store.state.user, dispatch: store.dispatch, session: session)
                            }
                            .navigationBarHidden(true)
                        )
                    }
                ),
            ],
            tintColor: .white,
            setSelectedPath: { session in
                store.dispatch(NavigationActions.SetSelectedPath(session: session))
            },
            onDismiss: { session in
                store.dispatch(NavigationActions.SessionDismissed(session: session))
            }
        )
    }
}
