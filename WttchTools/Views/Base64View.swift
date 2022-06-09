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
    @State var keyStr = ""
    @State var showHmac = false

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
                HStack {
                    Toggle("HMAC加密", isOn: $showHmac)
                }
                if showHmac {
                    TextEditorView(text: $keyStr)
                        .frame(maxHeight: 80)
                }
                TextEditorView(text: $resultText)
            }
        }
        .padding()
    }
    
    // MARK: 行为
    
    ///
    /// 进行 base64 编码
    ///
    func base64Encoding() {
        let data = sourceText.data(using: .utf8) ?? Data()
        let key = keyStr.data(using: .utf8) ?? Data()
        let hmacData = HMAC<SHA256>.authenticationCode(for: data, using: SymmetricKey(data: key))
        resultText =  hmacData.map{
            String(format: "%02hhx", $0)
        }.joined()
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
