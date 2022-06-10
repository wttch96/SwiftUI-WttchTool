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
            Text("作为输入")
            Image(systemName: "arrowshape.turn.up.left.fill")
                .rotationEffect(Angle(degrees: 90))
        })
    }
    
    // MARK: 行为
    func switchText() {
        sourceText = resultText
        resultText = ""
    }
}
