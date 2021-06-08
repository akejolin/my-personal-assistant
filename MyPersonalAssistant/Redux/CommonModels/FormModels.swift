import Foundation

protocol FormData {
    func identifiyField() -> String
}

struct FormModels {
    
    struct FieldItem<ValueType: Codable>: Identifiable, Codable {
        var id = UUID()
        var fieldID: String
        var value:[ValueType]
    }

    struct FormError: Codable {
        var fieldID: String
        var errors: FieldError
    }

    struct FieldError: Codable {
        var message: String
    }

    struct FormResponse<T:Codable>: Codable {
        var message: String
        var error: [FormError]?
        var data: T
    }
    
    struct EmptyModel: Codable {}
}
