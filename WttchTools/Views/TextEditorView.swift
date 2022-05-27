//
//  TextEditorView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    
    var body: some View {
        VStack {

            TextEditor(text: $text)
                .font(.headline)
                .foregroundColor(.white)
                .tint(.pink)
                //.multilineTextAlignment(.center)    // 对齐方式
        }
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.pink, lineWidth: 2))
        .padding()
    }
}
