import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

}

extension String {
    func components<T>(separatedBy separators: [T]) -> [String] where T : StringProtocol {
        var result = [self]
        for separator in separators {
            result = result
                .map { $0.components(separatedBy: separator)}
                .flatMap { $0 }
        }
        return result
    }
}
