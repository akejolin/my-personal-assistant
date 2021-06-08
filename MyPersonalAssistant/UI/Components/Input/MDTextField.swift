import SwiftUI

struct MDTextField: View {
    enum FieldType {
        case textField, securedField
    }

    var value: String
    var placeholder: String
    var type: FieldType = .textField
    var icon: String? = nil
    var onChange: (String) -> Void
    var onCommit: (String) -> Void

    @State private var text: String = ""

    var fieldView: some View {
        VStack {
            switch type {
            case .textField:
                BetterTextField(
                    value: value,
                    text: $text,
                    onChange: onChange,
                    onCommit: onCommit
                )
            case .securedField:
                BetterSecureTextField(
                    value: value,
                    text: $text,
                    onChange: onChange,
                    onCommit: onCommit
                )
            }
        }
    }

    var body: some View {
        VStack {
            ZStack {
                if text.count == 0 {
                    HStack {
                        if let icon = self.icon {
                            Image(icon)
                                .resizable()
                                .renderingMode(.template)
                                .colorMultiply(Color(hex: 0x4F4F4F))
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                        }
                        Text(placeholder)
                            .foregroundColor(Color(hex: 0x222222))
                            .font(Font.mobydeskFont(size: 14))
                    }
                }

                fieldView
                .foregroundColor(Color(hex: 0x222222))
                .font(Font.mobydeskFont(size: 14))
                .background(Color.clear)

                .multilineTextAlignment(.center)
            }
            .padding(7)
        }

        .background(Color.white)
        .cornerRadius(35)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            MDTextField(
                value: "",
                placeholder: "Var vill du jobba?",
                icon: "search",
                onChange: { _ in }
            ) { _ in }
            
            MDTextField(
                value: "",
                placeholder: "Lösenord",
                type: .securedField,
                onChange: { _ in }
            ) { _ in }
                
            Spacer()
        }
        .padding()
        .background(Color.black)
    }
}

struct BetterSecureTextField: View {
    var value: String
    @Binding var text: String
    var onChange: (String) -> Void
    var onCommit: (String) -> Void

    var body: some View {
        SecureField(
            "",
            text: Binding<String>(
                get: {
                    text
                },
                set: {
                    text = $0

                    if $0.count > 2 {
                        onChange(text)
                    }
                }
            ), onCommit: {
                UIApplication.shared.endEditing()
                onCommit(text)
            }
        ).onAppear {
            text = value
        }
    }
}

struct BetterTextField: View {
    var value: String
    @Binding var text: String
    var onChange: (String) -> Void
    var onCommit: (String) -> Void

    var body: some View {
        TextField(
            "",
            text: Binding<String>(
                get: {
                    text
                },
                set: {
                    text = $0

                    if $0.count > 2 {
                        onChange(text)
                    }
                }
            ), onCommit: {
                UIApplication.shared.endEditing()
                onCommit(text)
            }
        ).onAppear {
            text = value
        }
    }
}
