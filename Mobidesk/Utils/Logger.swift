import Foundation
import ReSwift
import SwiftUI

public enum LogLevel: Int {
    case none, debug, info, warning, error

    func getEmoj() -> String {
        switch self {
        case .debug:
            return "🏷"
        case .info:
            return "💬"
        case .warning:
            return "⚠️"
        case .error:
            return "❌"
        default:
            return ""
        }
    }
}

final class Logger {
    var logLevel: LogLevel {
#if DEBUG
        return .debug
#else
        return .none
#endif
    }

    static var shared: Logger = {
        Logger()
    }()

    static func getFileName(_ path: String?) -> String {
        guard let path = path else { return "" }
        return (path as NSString).lastPathComponent.components(separatedBy: ".")[0]
    }

    static func getFunctionName(_ name: String?) -> String {
        guard let name = name else { return "" }
        return name.components(separatedBy: "(")[0]
    }

    func debug(_ obj: Any, functionName: String? = #function, line: Int? = #line, path: String? = #file) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let lineStr = line != nil ? "[\(line ?? 0)]" : ""
            self?.publish(
                message: "\(Logger.getFileName(path)).\(Logger.getFunctionName(functionName))\(lineStr):",

                obj: obj,
                level: .debug
            )
        }
    }

    func info(_ obj: Any, functionName: String? = #function, line: Int? = #line, path: String? = #file) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let lineStr = line != nil ? "[\(line ?? 0)]" : ""
            self?.publish(
                message: "\(Logger.getFileName(path)).\(Logger.getFunctionName(functionName))\(lineStr):",
                obj: obj,
                level: .info
            )
        }
    }

    func warning(_ obj: Any, functionName: String? = #function, line: Int? = #line, path: String? = #file) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let lineStr = line != nil ? "[\(line ?? 0)]" : ""
            self?.publish(
                message: "\(Logger.getFileName(path)).\(Logger.getFunctionName(functionName))\(lineStr):",
                obj: obj,
                level: .warning
            )
        }
    }

    func error(_ obj: Any, functionName: String? = #function, line: Int? = #line, path: String? = #file) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let lineStr = line != nil ? "[\(line ?? 0)]" : ""
            self?.publish(
                message: "\(Logger.getFileName(path)).\(Logger.getFunctionName(functionName))\(lineStr):",
                obj: obj,
                level: .error
            )
        }
    }

    func publish(message: String, obj: Any, level: LogLevel) {
        guard level.rawValue >= logLevel.rawValue else {
            return
        }
        print("\(level.getEmoj()) \(message)", obj)
    }

    struct InView: View {
        init(_ str: String) {
            Logger.shared.info(str)
        }

        var body: some View {
            AnyView(EmptyView().frame(width: 0, height: 0))
        }
    }
}
