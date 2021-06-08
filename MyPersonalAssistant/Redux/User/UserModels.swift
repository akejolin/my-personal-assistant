import Foundation

struct UserModels {
    enum AuthType: String, Codable {
        case identified
        case anonymous
    }

    struct Auth: Codable {
        var bearerToken: String
        var type: AuthType

        init(bearerToken: String, type: UserModels.AuthType) {
            self.bearerToken = bearerToken
            self.type = type
        }
    }

    struct User: Identifiable, Codable {
        var id = UUID()
        var username: String
        var name: String?
        var familyName: String?
        var bookings: [Booking]

        init(username: String = "", name: String? = nil, familyName: String? = nil, bookings: [Booking] = []) {
            self.username = username
            self.name = name
            self.familyName = familyName
            self.bookings = bookings
        }
    }

    enum BookingState {
        case before, active, after, unknown
    }
    
    struct Booking: Identifiable, Codable {
        var id = UUID()
        var startDate: Date
        var endDate: Date
        var price: Price
        var landlord: Landlord

        var bookingState: BookingState {
            let today = Date()
            let beforeRange = Date(timeIntervalSinceReferenceDate: today.timeIntervalSince1970) ... startDate
            
            if beforeRange.contains(today) {
                return BookingState.before
            }
            let activeRange = startDate ... endDate
            if activeRange.contains(today) {
                return BookingState.active
            }
            
            let postRange = endDate ... Date(timeIntervalSinceReferenceDate: 10000000.0)
            if postRange.contains(today) {
                return BookingState.after
            }
            
            return BookingState.unknown
        }
    }

    struct Price: Codable {
        var amount: Int
        var currency: Currency
    }

    enum Currency: String, Codable {
        case sek

        var stringRepresentation: String {
            switch self {
            case .sek:
                return "kr"
            }
        }
    }

    struct Landlord: Identifiable, Codable {
        var id = UUID()
        var landloardID: String
        var name: String
        var address: String?
        var zipcode: String?
        var city: String?
        var country: String?
        var website: String?
    }

    enum LoginFormState: String, Codable {
        case start, subbmitting, validationError, subbmitted
    }

    struct LoginFormData: Codable {
        var username: String
        var password: String
    }

    struct LoginForm: Codable {
        var state: LoginFormState = .start
        var data: LoginFormData
        var response: FormModels.FormResponse<FormModels.EmptyModel>?
    }
    
    
    static func createFakeUser() -> User{
        let booking = UserModels.Booking(
            startDate: Date().addingTimeInterval(-3600),
            endDate: Date().addingTimeInterval(3600),
            price: UserModels.Price(amount: 200, currency: .sek),
            landlord: UserModels.Landlord(
                landloardID: "Andysplace",
                name: "Andys sommarstuga",
                address: "Hästskovägen 12",
                zipcode: "10000",
                city: "Fållökna Flen",
                country: "Sverige"
            )
        )

        return UserModels.User(username: "andylindebros@gmail.com", name: "Andy", bookings: [booking])
    }
}
