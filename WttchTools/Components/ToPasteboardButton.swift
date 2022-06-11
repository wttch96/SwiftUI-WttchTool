//
//  ToPasteboardButton.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/12.
//

import SwiftUI

///
/// 到粘贴板按钮
///
/// text 读取到粘贴板
///
struct ToPasteboardButton: View {
    @State var showAlert = false
    @Binding var text: String
    
    var body: some View {
        Button("复制加密结果") {
            showAlert = true
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(text, forType: .string)
        }
        .popover(isPresented: $showAlert, content: {
            Text("已保存!")
                .padding()
        })
    }
}

struct ToPasteboardButton_Previews: PreviewProvider {
    
    struct PreviewsWrapper: View {
        @State var text = ""
        
        var body: some View {
            ToPasteboardButton(text: $text)
        }
    }
    
    static var previews: some View {
        PreviewsWrapper()
    }
}
