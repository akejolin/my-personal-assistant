//
//  LaunchScreenView.swift
//  Mobidesk
//
//  Created by Andreas Linde on 2021-04-07.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var opacity: CGFloat = 1
    @State private var scaling: CGFloat = 0

    var animationCompleted: () -> Void
    var body: some View {
        ZStack {
            Color("launchcolor")
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Image("logo")
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(Double(opacity))
        .scaleEffect(scaling)
        .onAppear {
            withAnimation(.spring(response: 0.70)) {
                scaling = 10
            }
            withAnimation(.spring(response: 0.55)) {
                opacity = 0
            }
        }
        .onAnimationCompleted(for: scaling) {
            animationCompleted()
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView {}
    }
}
