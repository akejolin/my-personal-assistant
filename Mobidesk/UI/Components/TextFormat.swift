//
//  TextFormat.swift
//  Mobidesk
//
//  Created by Andreas Linde on 2021-04-13.
//

import SwiftUI

struct TextFormat: View {
    var string: String
    var keys: [String]
    var replacement: (String) -> Text
    var applyModifiersOnText: (String) -> Text

    private var render: Text {
        var result = [string]

        for key in keys {
            result = result
                .map { item -> [String] in
                    let sliced = item.components(separatedBy: key)
                    print(sliced)
                    return sliced
                }
                .map { items -> [String] in
                    var newItems = [String]()
                    var index = 0
                    for item in items {
                        if index != 0 {
                            newItems.append(key)
                        }
                        newItems.append(item)
                        index += 1
                    }
                    return newItems
                }
                .flatMap { $0 }
        }

        var txt = Text("")
        for item in result {
            if let found = keys.filter({ $0 == item }).first {
                txt = txt + replacement(found)
            } else {
                txt = txt + applyModifiersOnText(item)
            }
        }
        return txt
    }

    var body: some View {
        render
    }
}

struct TextFormat_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFormat(string: "Hello {user1}!. How are you today? {user2}, have a nice day!", keys: ["{user1}", "{user2}"], replacement: { txt in
                if txt == "{user1}" {
                    return Text("Andy").font(Font.mobydeskFont(size: 40))
                        .foregroundColor(.blue)
                } else {
                    return Text("Awesome").font(Font.mobydeskFont(size: 40))
                        .foregroundColor(.yellow)
                    }

            }) { txt in
                Text(txt).font(Font.mobydeskFont(size: 20)).foregroundColor(Color.red)
            }
        }
    }
}
