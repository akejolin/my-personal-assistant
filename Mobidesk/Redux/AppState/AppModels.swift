import Foundation

struct AppModels {
    enum AppStatus: String, Codable {
        case notLauched, launching, launched
    }
}
