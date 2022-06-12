//
//  MD5ToolView.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/12.
//

import SwiftUI
import CryptoKit

struct MD5ToolView: View {
    
    @State var sourceText: String = ""
    @State var resultText: String = ""
    @State var hmac: String = ""
    @State var showHmac = false
    
    var body: some View {
        GeometryReader { geometry in
            VSplitView {
                VStack {
                    HStack {
                        Text("输入:")
                        ImmediatelyButton(source: $sourceText, target: $resultText)
                        FromPasteboardButton(text: $sourceText)
                        Spacer()
                    }
                    HStack {
                        Toggle("HMAC:", isOn: $showHmac)
                            .toggleStyle(SwitchToggleStyle())
                            .onChange(of: showHmac) { newValue in
                                onAction()
                            }
                        if showHmac {
                            TextField("请输入HMAC密钥", text: $hmac)
                                .onChange(of: hmac) { newValue in
                                    onAction()
                                }
                        }
                        Spacer()
                    }
                    TextEditorView(text: $sourceText)
                        .onChange(of: sourceText) { newValue in
                            onAction()
                        }
                }
                .padding()
                VStack {
                    TextEditorView(text: $resultText)
                }
                .padding()
            }
        }
    }

    // MARK: 函数
    func onAction() {
        let data = sourceText.data(using: .utf8) ?? Data()
        if showHmac {
            let key = hmac.data(using: .utf8) ?? Data()
            let hmacData = HMAC<Insecure.MD5>.authenticationCode(for: data, using: SymmetricKey(data: key))
            resultText =  hmacData.map {
                String(format: "%02hhx", $0)
            }.joined()
        } else {
            var md5 = Insecure.MD5()
            md5.update(data: data)
            let result = md5.finalize()
            resultText = result.map {
                String(format: "%02hhx", $0)
            }.joined()
        }
    }
}

struct MD5ToolView_Previews: PreviewProvider {
    static var previews: some View {
        MD5ToolView()
    }
}
