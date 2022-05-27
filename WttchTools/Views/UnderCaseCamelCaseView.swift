//
//  UnderCaseCamelCaseView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import SwiftUI

///
/// 下划线、驼峰命名法互转
///
struct UnderCaseCamelCaseView: View {
    @State private var sourceText: String = ""
    @State private var resultText: String = ""
    
    var body: some View {
        VStack {
            TextEditorView(text: $sourceText)
                .frame(height: 200)
            HStack {
                Button(action: {
                    resultText = sourceText.camelCase2UnderCase()
                }, label: {
                    Text("驼峰转下划线")
                })
                Button(action: {
                    resultText = sourceText.underCase2CamelCase()
                }, label: {
                    Text("下划线转驼峰")
                })
                
                Button(action: {
                    sourceText = resultText
                    resultText = ""
                }, label: {
                    Text("交换")
                    Image(systemName: "arrow.up")
                })
                Spacer()
                
                Image(systemName: "arrow.down")
            }
            .padding(.horizontal, 30)
            TextEditorView(text: $resultText)
                .frame(height: 200)
        }
    }
}

struct UnderCaseCamelCaseView_Previews: PreviewProvider {
    static var previews: some View {
        UnderCaseCamelCaseView()
    }
}
