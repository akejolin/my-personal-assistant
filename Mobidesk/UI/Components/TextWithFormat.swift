//import SwiftUI
//
//struct TextWithFormat: Text {
//    var strFormat: String
//    var key: String
//    var replacement: some View
//    
//    
//    init(_ strFormat: String) {
//        self.strFormat = strFormat
//        
//        let txts = strFormat.components(separatedBy: key)
//        
//        let views = txts.map { item -> Text in
//            
//            return Text(item).foregroundColor(.red)
//        }
//        
//        var txt: Text = Text("")
//        
//        var index = 0
//        for item in views {
//            if index != 0 {
//                txt = txt + replacement
//            }
//            txt = txt + item
//            index += 1
//        }
//        return txt
//    }
//    
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct TextWithFormat_Previews: PreviewProvider {
//    static var previews: some View {
//        TextWithFormat()
//    }
//}
