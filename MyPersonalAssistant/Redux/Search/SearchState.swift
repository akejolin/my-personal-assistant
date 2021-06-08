import Combine
import Foundation
import ReSwift

class SearchState: StateType, ObservableObject {
    @Published fileprivate(set) var searchText = ""
}

extension SearchState {
    static func reducer(action: Action, state: SearchState?) -> SearchState {
        let state = state ?? SearchState()

        switch action {
        case let a as SearchActions.UpdateSearchFieldAction:
            state.searchText = a.searchText
        default:
            break
        }
        return state
    }
}

extension SearchState: Encodable {
    enum CodingKeys: CodingKey {
        case searchText
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(searchText, forKey: .searchText)
    }
}
