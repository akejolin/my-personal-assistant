import SwiftUI

struct ActionButtonView<Content: View>: View {
    enum ActionButtonType {
        case cta, secondary
    }

    private var type: ActionButtonType
    private var disabled: Bool
    private var content: () -> Content
   
    private var action: () -> Void

    init(_ type: ActionButtonType, action: @escaping () -> Void,
         disabled: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.type = type
        self.action = action
        self.content = content
        self.disabled = disabled
    }

    var color: Color {
        switch type {
        case .cta:
            return Color(hex: 0xFECD00)
        case .secondary:
            return Color.clear
        }
    }

    var borderColor: Color {
        switch type {
        case .cta:
            return Color.clear
        case .secondary:
            return Color(hex: 0x484848)
        }
    }

    var borderWidth: CGFloat {
        switch type {
        case .cta:
            return 0
        case .secondary:
            return 1
        }
    }

    var body: some View {
        Button(action: action) {
            HStack {
                self.content()
            }
            .font(Font.mobydeskFont(size: 14).figmaFontWeight(.size700))
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .contentShape(Rectangle())
            .clipped()
            .foregroundColor(.white)
            .background(color)
            .border(borderColor, width: borderWidth)
            .cornerRadius(28)
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            Spacer()
            ActionButtonView(.cta, action: {}) {
                Text("Awesome")
            }
            
            ActionButtonView(.cta, action: {}, disabled: true) {
                Text("Awesome")
            }

            ActionButtonView(.secondary, action: {}) {
                Text("Awesome")
            }

            Spacer()
        }
        .padding()
        .background(Color.black)
    }
}
