//
//  SwitchTextButton.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/30.
//

import SwiftUI

struct SwitchTextButton: View {
    
    @Binding var sourceText: String
    @Binding var resultText: String
    
    var body: some View {
        Button(action: switchText, label: {
            Image(systemName: "arrow.up")
            Text("交换")
        })
    }
    
    // MARK: 行为
    func switchText() {
        sourceText = resultText
        resultText = ""
    }
}
