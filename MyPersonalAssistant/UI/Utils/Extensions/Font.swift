import SwiftUI


extension Font {
    static func mobydeskFont(size: CGFloat) -> Font {
        Font.custom("Helvetica Neue", size: size)
    }
}

extension Font {
    enum FigmaFontWeight {
        case size200, size400, size500, size700
    }
    func figmaFontWeight(_ size: FigmaFontWeight) -> Font {
        var retr: Font = self
        switch size{
        case .size200:
            retr = self.weight(.thin)
        
        case .size400:
            retr = self.weight(.regular)
        case .size500:
            retr = self.weight(.medium)
        case .size700:
            retr = self.weight(.bold)
        }
        return retr
    }
}
