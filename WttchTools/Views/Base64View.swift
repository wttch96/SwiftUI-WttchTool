//
//  HashView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import SwiftUI
import CryptoKit

///
/// Base64 编码
///
struct Base64View: View {
    
    @State var sourceText = ""
    @State var resultText = ""

    @State var showAlert = false
    
    var body: some View {
        VStack {
            VStack {
                TextEditorView(text: $sourceText)
                HStack {
                    Button(action: base64Encoding, label: {
                        Image(systemName: "arrowtriangle.right.and.line.vertical.and.arrowtriangle.left.fill")
                        Text("Base64编码")
                    })
                    Button(action: base64Decoding, label: {
                        Image(systemName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right.fill")
                        Text("Base64解码")
                    })
                    
                    Button("复制加密结果") {
                        showAlert = true
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(resultText, forType: .string)
                    }
                    .popover(isPresented: $showAlert, content: {
                        Text("已保存!")
                            .padding()
                    })
                    SwitchTextButton(sourceText: $sourceText, resultText: $resultText)
                }
                TextEditorView(text: $resultText)
            }
        }
    }
    
    // MARK: 行为
    
    ///
    /// 进行 base64 编码
    ///
    func base64Encoding() {
        resultText = sourceText.base64EncodedString()
    }
    
    ///
    /// 进行 base64 解码
    ///
    func base64Decoding() {
        resultText = sourceText.base64DecodedString()
    }
}

struct HashView_Previews: PreviewProvider {
    static var previews: some View {
        Base64View()
    }
}
