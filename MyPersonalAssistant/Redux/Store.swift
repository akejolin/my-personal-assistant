import ReSwift
import SwiftReduxRouter

/// Connect all states by adding a property to the State struct
struct MainState: StateType {
    private(set) var app: AppState
    private(set) var user: UserState
    private(set) var navigation: NavigationState
    private(set) var search: SearchState
}

extension MainState {
    static func createStore(initState: MainState? = nil) -> Store<MainState> {
        let middleware: [Middleware<MainState>] = {
            var _middleware: [Middleware<MainState>] = []

#if DEBUG
            // Log the state to Remote dev tools
            let monitorMiddleware = MonitorMiddleware.make(configuration: Configuration())
            _middleware.append(connectedMiddleware)
            _middleware.append(loggerMiddleware)
            _middleware.append(trackingMiddleware)
            _middleware.append(monitorMiddleware)

#endif
            return _middleware
        }()

        return Store<MainState>(reducer: Self.reducer, state: initState, middleware: middleware)
    }

    /// Add all state reducers to the State this method is returning
    static func reducer(action: Action, state: MainState?) -> MainState {
        return MainState(
            app: AppState.reducer(action: action, state: state?.app),
            user: UserState.reducer(action: action, state: state?.user),
            navigation: navigationReducer(action: action, state: state?.navigation),
            search: SearchState.reducer(action: action, state: state?.search)
        )
    }
}

extension MainState {
    static var initState: MainState {
        let navInitState = NavigationState(
            sessions: [
                NavigationSession(
                    name: "list",
                    path: NavigationPath("list"),
                    tab: NavigationTab(name: "Utforska", icon: "search", selectedIcon: "search")
                ),
                NavigationSession(
                    name: "profile",
                    path: NavigationPath("profile"),
                    tab: NavigationTab(name: "Profil", icon: "profile", selectedIcon: "profile")
                )
            ]
        )
        
        return MainState(app: AppState(), user: UserState(), navigation: navInitState, search: SearchState())
    }
}
