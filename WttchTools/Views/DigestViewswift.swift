//
//  DigestViewswift.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/8.
//

import SwiftUI

struct DigestViewswift: View {
    @State var resultText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            TextEditor(text: $resultText)
                .background(.red)
                .foregroundColor(.cyan)
            
            TextField("hmac", text: $resultText)
            
            TextEditorView(text: $resultText)
            
            TextFieldView(text: $resultText, title: "请输入hmac密钥")
            
            TextEditorView(text: $resultText)
        }
    }
}

struct DigestViewswift_Previews: PreviewProvider {
    static var previews: some View {
        DigestViewswift()
    }
}
