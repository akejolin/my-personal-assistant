import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xFF) / 255,
            G: Double((hex >> 08) & 0xFF) / 255,
            B: Double((hex >> 00) & 0xFF) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
