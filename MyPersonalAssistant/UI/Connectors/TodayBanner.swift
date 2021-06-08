import ReSwift
import SwiftUI

struct TodayBanner: Connector, View {
    internal var dispatch: (Action) -> Void
    @ObservedObject private var userState: UserState
    private var greeting: GreetingPhrase

    init(userState: UserState, dispatch: @escaping (Action) -> Void) {
        self.userState = userState
        self.dispatch = dispatch
        greeting = GreetingPhrase.generateGreeting(at: Date())
    }

    var body: some View {
        VStack {
            if let user = userState.user {
                HStack {
                    Text("TodayBanner.TopTitle".localized.uppercased())
                        .font(Font.mobydeskFont(size: 12).figmaFontWeight(.size400))
                        .foregroundColor(.white)
                    Spacer()
                }

                if let booking = user.bookings.first {
                    HStack {
                        Text("\(greeting.stringRepresentaiton) \(user.name ?? user.username)!")
                            .font(Font.mobydeskFont(size: 24).figmaFontWeight(.size500))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.top, 4)

                    HStack {
                        TextFormat(
                            string: greeting.greeting,
                            keys: ["{bookingName}"],
                            replacement: { str -> Text in
                                Text(booking.landlord.name)
                                    .foregroundColor(Color(hex: 0xF2C94C))
                            }
                        ) { txt in
                            Text(txt)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .font(Font.mobydeskFont(size: 20).figmaFontWeight(.size500))
                }
            }
        }
    }
}

extension TodayBanner {
    enum GreetingPhrase: String {
        case morning = "TodayBanner.GreetingPhrase.morning"
        case noon = "TodayBanner.GreetingPhrase.noon"
        case afternoon = "TodayBanner.GreetingPhrase.afternoon"
        case evening = "TodayBanner.GreetingPhrase.evning"

        var stringRepresentaiton: String {
            return rawValue.localized
        }

        var greeting: String {
            switch self {
            case .morning:
                return "TodayBanner.Greeting.pre".localized
            case .noon, .afternoon:
                return "TodayBanner.Greeting.current".localized
            case .evening:
                return "TodayBanner.Greeting.post".localized
            default:
                return "TodayBanner.Greeting.pre".localized
            }
        }

        static func generateGreeting(at date: Date) -> GreetingPhrase {
            let hour = Calendar.current.component(.hour, from: date)

            switch hour {
            case 0 ..< 11:
                return GreetingPhrase.morning
            case 11 ..< 14:
                return GreetingPhrase.noon
            case 14 ..< 18:
                return GreetingPhrase.afternoon
            case 18 ..< 24:
                return GreetingPhrase.evening
            default:
                return GreetingPhrase.morning
            }
        }
    }
}

struct TodayBanner_Previews: PreviewProvider {
    struct Preview: View {
        @State private var isFlipped: Bool = false

        let store: Store<MainState>

        init() {
            store = MainState.createStore()

            let user = UserModels.createFakeUser()

            store.dispatch(UserActions.SetUser(user: user))
        }

        var body: some View {
            VStack {
                TodayBanner(userState: store.state.user, dispatch: store.dispatch)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.black)
        }
    }

    static var previews: some View {
        Preview()
    }
}
