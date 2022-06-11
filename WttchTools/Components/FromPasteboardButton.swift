//
//  FromPasteboardButton.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/11.
//

import SwiftUI

///
/// 从粘贴板按钮
///
/// 读取粘贴板内容到 text
///
struct FromPasteboardButton: View {
    
    @Binding var text: String
    
    var body: some View {
        Button(action: {
            let pasteboard = NSPasteboard.general
            if let pasteboardString = pasteboard.string(forType: .string) {
                text = pasteboardString
            }
        }, label: {
            Text("从粘贴板")
        })
    }
}

struct FromPasteboardButton_Previews: PreviewProvider {
    ///
    /// 直接预览时无法使用 @State 修饰器，所以使用一层包装
    ///
    struct PreviewsWrapper: View {
        @State var text = ""
        var body: some View {
            FromPasteboardButton(text: $text)
        }
    }
    
    static var previews: some View {
        PreviewsWrapper()
    }
}
