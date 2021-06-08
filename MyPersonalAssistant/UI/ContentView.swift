import ReSwift
import SwiftReduxRouter
import SwiftUI

struct ContentView: View {
    let store: Store<MainState>
    @ObservedObject private var appState: AppState
    @ObservedObject private var navigationState: NavigationState
    init(store: Store<MainState>) {
        self.store = store
        appState = store.state.app
        navigationState = store.state.navigation
    }

    var body: some View {
        ZStack {
            Routing(store: store)

            if appState.status != .launched {
                LaunchScreenView {
                    store.dispatch(AppActions.AppStatusAction(status: .launched))
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    struct MockStoreView: View {
        let store: Store<MainState>
        init() {
            store = MainState.createStore()
            store.dispatch(AppActions.TestAction(payload: "Andy"))
        }

        var body: some View {
            ContentView(store: store)
        }
    }

    static var previews: some View {
        MockStoreView()
    }
}
