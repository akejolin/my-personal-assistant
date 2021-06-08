import ReSwift

struct SearchActions {
    struct UpdateSearchFieldAction: ConnectedAction {
        
        var searchText: String
        
        func handle(dispatch: (Action) -> Void, state: MainState) {
            // more to come
        }
    }
}
