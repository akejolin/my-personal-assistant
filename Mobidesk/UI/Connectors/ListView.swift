import ReSwift
import SwiftReduxRouter
import SwiftUI

struct ListView: Connector, View {
    @ObservedObject var searchState: SearchState
    @ObservedObject var userState: UserState

    var dispatch: (Action) -> Void

    let padding: CGFloat = 24

    var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMMM"
        formatter.locale = Locale.current
        return formatter.string(from: Date())
    }

    var body: some View {
        ScrollView {
            Spacer().frame(height: 67)

            HStack {
                Button(action: {
                    dispatch(NavigationActions.Push(path: NavigationPath("test"), target: "test"))
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 32, height: 32)

                        Image("settings")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .colorMultiply(Color.white)
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .contentShape(Rectangle())
                    }
                }
                Spacer()
            }
            .padding([.leading, .trailing], padding)
            .padding(.bottom, 24)

            HStack {
                // Today
                Text(today)
                    .font(Font.mobydeskFont(size: 13).figmaFontWeight(.size700))
                    .foregroundColor(Color(hex: 0xEBEBF5))
                    .opacity(0.66)
                Spacer()
            }
            .padding([.leading, .trailing], padding)

            if userState.isLoggedIn {
                TodayBanner(userState: userState, dispatch: dispatch)
                    .padding([.leading, .trailing], padding)
            }
            
            MDTextField(value: searchState.searchText, placeholder: "ListView.SearchField.Placeholder".localized, icon: "search", onChange: { _ in }) { searchText in
                dispatch(SearchActions.UpdateSearchFieldAction(searchText: searchText))
            }
            .padding([.leading, .trailing], 24)
            .padding(.top, 42)
        }
        .navigationBarHidden(true)
    }
}
