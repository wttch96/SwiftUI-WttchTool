//
//  HashView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import SwiftUI
import CryptoKit

struct HashView: View {
    
    @State var sourceText = ""
    @State var resultText = ""
    
    
    var hashText: String {
        let sourceData = sourceText.data(using: .utf8) ?? Data()
        let key = "wttch".data(using: .utf8) ?? Data()
        let hmacData = HMAC<Insecure.MD5>.authenticationCode(for: sourceData, using: SymmetricKey(data: key))
        
        
        return hmacData.map{
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    var body: some View {
        VStack {
            Button("转换") {
                resultText = hashText
            }
            VStack {
                ZStack {
                    TextEditor(text: $sourceText)
                        .frame(width: 400, height: 200)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(.pink, lineWidth: 2))
                HStack {
                    Button("Base64加密") {
                        
                    }
                    Button("Base64加密") {
                        
                    }
                    Button("复制加密结果") {
                        
                    }
                }
                ZStack {
                    TextEditor(text: $resultText)
                        .frame(width: 400, height: 200)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(.pink, lineWidth: 2))
            }
            HStack {
                ZStack {
                    TextEditor(text: $sourceText)
                        .frame(width: 200, height: 150)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(.pink, lineWidth: 2))
                ZStack {
                    TextEditor(text: $resultText)
                        .frame(width: 200, height: 150)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(.pink, lineWidth: 2))
            }
            .padding()
        }
    }
}

struct HashView_Previews: PreviewProvider {
    static var previews: some View {
        HashView()
    }
}
