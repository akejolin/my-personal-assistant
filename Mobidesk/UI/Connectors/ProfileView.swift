//
//  ProfileView.swift
//  Mobidesk
//
//  Created by Andreas Linde on 2021-04-12.
//

import ReSwift
import SwiftUI
import SwiftReduxRouter

struct ProfileView: Connector, View {
    @ObservedObject var userState: UserState
    var dispatch: (Action) -> Void

    var body: some View {
        LoginWall(userState: userState, jailView: {
            Button(action: {
                dispatch(NavigationActions.Push(
                    path: NavigationPath("login"),
                    target: "login"
                ))
            }) {
                Text("Login to Continue")
            }
        }) {
            
            VStack{
                if let user = userState.user {
                    Text("Hello \(user.name ?? "")")
                }
                Button(action: {
                    dispatch(UserActions.LogoutUser())
                }) {
                    Text("Log out")
                }
            }
            
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    struct ConnectedPrewview: View {
        @State private var isFlipped: Bool = false

        let store: Store<MainState>

        init() {
            store = MainState.createStore()
        }

        var body: some View {
            ProfileView(
                userState: store.state.user,
                dispatch: store.dispatch
            )
        }
    }

    static var previews: some View {
        ConnectedPrewview()
    }
}
