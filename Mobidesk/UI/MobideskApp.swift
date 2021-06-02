import ReSwift
import SwiftReduxRouter
import SwiftUI

@main
struct MobideskApp: App {
    let store: Store<MainState>
    init() {
        store = MainState.createStore(initState: MainState.initState)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
