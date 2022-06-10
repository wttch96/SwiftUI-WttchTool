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
    
    // MARK: 状态
    @State var sourceText = ""
    @State var resultText = ""
    @State var keyStr = ""
    @State var showHmac = false

    @State var showAlert = false
    @State var action = Action.encode
    
    enum Action: String {
        case decode = "decode"
        case encode = "encode"
    }
    
    var body: some View {
        GeometryReader {geometry in
            VSplitView {
                VStack {
                    HStack {
                        Text("输入:")
                        immediatelyButton
                        fromPasteboardButton
                        Spacer()
                        actionPicker
                    }
    //                HStack {
    //                    Toggle("HMAC", isOn: $useHmac)
    //                        .toggleStyle(SwitchToggleStyle())
    //
    //                    if useHmac {
    //                        TextField("xxx", text: $sourceText)
    //                            .frame(width: 480)
    //                    }
    //
    //                    Spacer()
    //                }
                    TextEditorView(text: $sourceText)
                        .onChange(of: sourceText) { newValue in
                            doAction()
                        }
                }
                .padding()
                .frame(height: geometry.size.height / 2)
                VStack {
                    HStack {
                        Spacer()
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
                .padding()
            }
        }
    }
    // MARK: 视图
    
    var immediatelyButton: some View {
        Button(action: {
            let pasteboard = NSPasteboard.general
            sourceText = pasteboard.string(forType: .string) ?? ""
            doAction()
            pasteboard.setString(resultText, forType: .string)
        }, label: {
            Image(systemName: "bolt.fill")
        })
        .help("读取粘贴板进行转换，并将结果复制到粘贴板")
    }
    
    var fromPasteboardButton: some View {
        Button(action: {
            let pasteboard = NSPasteboard.general
            sourceText = pasteboard.string(forType: .string) ?? ""
        }, label: {
            Text("从粘贴板")
        })
    }
    
    var actionPicker: some View {
        Picker(selection: $action, label: Text("")) {
            Label("Base64编码", systemImage: "rectangle.compress.vertical").tag(Action.encode)
            Label("Base64解码", systemImage: "rectangle.expend.vertical").tag(Action.decode)
        }
        .pickerStyle(RadioGroupPickerStyle())
        .horizontalRadioGroupLayout()
        .onChange(of: action) { newValue in
            doAction()
        }
    }
    
    
    // MARK: 行为
    
    func doAction() {
        if action == Action.encode {
            resultText = sourceText.base64EncodedString()
//            let data = sourceText.data(using: .utf8) ?? Data()
//            let key = keyStr.data(using: .utf8) ?? Data()
//            let hmacData = HMAC<SHA256>.authenticationCode(for: data, using: SymmetricKey(data: key))
//            resultText =  hmacData.map{
//                String(format: "%02hhx", $0)
//            }.joined()
        } else {
            resultText = sourceText.base64DecodedString()
        }
    }
}

struct HashView_Previews: PreviewProvider {
    static var previews: some View {
        Base64View()
    }
}
