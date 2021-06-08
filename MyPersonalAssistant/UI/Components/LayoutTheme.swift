import SwiftUI
import UIKit
struct LayoutTheme<Content: View>: View {
    private var content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        VStack {
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
    
    static func setupThemeForUIKit() {
        
    }
}



struct LayoutTheme_Previews: PreviewProvider {
    static var previews: some View {
        LayoutTheme() {
            
        }
    }
}
