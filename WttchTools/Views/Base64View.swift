//
//  HashView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import SwiftUI
import CryptoKit
import WttchCoreLibrary



///
/// Base64 编码
///
struct Base64View: View {
    
    // MARK: 状态
    @State var sourceText: String = ""
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
                        ImmediatelyButton(source: $sourceText, target: $resultText)
                        FromPasteboardButton(text: $sourceText)
                        Spacer()
                        actionPicker
                    }
                    .onAppear {
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
                        ToPasteboardButton(text: $resultText)
                        SwitchTextButton(sourceText: $sourceText, resultText: $resultText)
                    }
                    TextEditorView(text: $resultText)
                }
                .padding()
            }
        }
    }

    // MARK: 视图
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
