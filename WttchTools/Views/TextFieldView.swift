//
//  TextFieldView.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/8.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    
    var title: String
    
    var body: some View {
        VStack {

            TextField(title, text: $text)
                .font(.headline)
                .foregroundColor(.white)
                .tint(.pink)
                //.multilineTextAlignment(.center)    // 对齐方式
        }
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.pink, lineWidth: 2))
        .padding(8)
    }
}
