//
//  Serialization.swift
//  ReSwiftMonitor
//
//  Created by 大澤卓也 on 2018/02/01.
//  Copyright © 2018年 Takuya Ohsawa. All rights reserved.
//

import Foundation
import CoreGraphics

protocol Monitorable {
    var monitorValue: Any { get }
}

extension Monitorable {
    var monitorValue: Any { return self }
}

extension String: Monitorable {}
extension Int: Monitorable {}
extension CGFloat: Monitorable {}
extension Double: Monitorable {}

extension Array: Monitorable {
    var monitorValue: Any {
        return map { MonitorSerialization.convertValueToDictionary($0) }
    }
}

extension Dictionary: Monitorable {
    var monitorValue: Any {
        var monitorDict: [String: Any] = [:]

        for (key, value) in self {
            monitorDict["\(key)"] = MonitorSerialization.convertValueToDictionary(value)
        }

        return monitorDict
    }
}

struct MonitorSerialization {
    private init() {}

    static func convertValueToDictionary(_ value: Any) -> Any? {
        if let v = value as? Monitorable {
            return v.monitorValue
        }

        var mirror = Mirror(reflecting: value)

        if mirror.displayStyle == .class, let obj = value as? Encodable {
            do {
                return try obj.asDictionary()
            } catch let e {
                print("e", e)
            }
        }

        var result: [String: Any] = [:]

        for (key, child) in mirror.children {
            guard let key = key else {
                continue
            }

            result[key] = MonitorSerialization.convertValueToDictionary(child)
        }

        return result
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        // encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(self)

        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
