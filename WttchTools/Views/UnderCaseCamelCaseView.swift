//
//  UnderCaseCamelCaseView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import SwiftUI
import WttchCoreLibrary

///
/// 下划线、驼峰命名法互转
///
struct UnderCaseCamelCaseView: View {
    @State private var sourceText: String = ""
    @State private var resultText: String = ""
    @State private var action = ActionTag.toUnderCase
    
    private enum ActionTag: String, RadioTag {
        case toUnderCase = "toUnderCase"
        case toCamelCase = "toCamelCase"
    }
    
    private var actionItems = [
        RadioItem(text: "转下划线", tag: ActionTag.toUnderCase),
        RadioItem(text: "转驼峰", tag: ActionTag.toCamelCase),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VSplitView {
                VStack {
                    HStack {
                        Text("输入:")
                        ImmediatelyButton(source: $sourceText, target: $resultText)
                        FromPasteboardButton(text: $sourceText)
                        Spacer()
                        RadioPicker(items: actionItems, selection: $action)
                            .onChange(of: action) { newValue in
                                onAction()
                            }
                    }
                    TextEditorView(text: $sourceText)
                        .onChange(of: sourceText) { newValue in
                            onAction()
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
    
    // MARK: 函数
    func onAction() {
        if action == .toUnderCase {
            resultText = sourceText.camelCase2UnderCase()
        } else {
            resultText = sourceText.underCase2CamelCase()
        }
    }
}

struct UnderCaseCamelCaseView_Previews: PreviewProvider {
    static var previews: some View {
        UnderCaseCamelCaseView()
    }
}
