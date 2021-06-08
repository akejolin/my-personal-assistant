import Foundation
import SwiftUI

/** Observes the Keyboard */
class KeyboardResponder: ObservableObject {
    @Published var isOpen: Bool = false

    var center: NotificationCenter

    init(center: NotificationCenter = .default) {
        self.center = center
        self.center.addObserver(self, selector: #selector(keyBoardIsShown(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        self.center.addObserver(self, selector: #selector(keyBoardIsHidden(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func keyBoardIsShown(notification: Notification) {
        isOpen = true
    }

    @objc func keyBoardIsHidden(notification: Notification) {
        isOpen = false
    }
}
