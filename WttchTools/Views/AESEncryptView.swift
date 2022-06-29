//
//  AESEncryptView.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/21.
//

import SwiftUI
import CryptoSwift

///
/// AES 加密模式
///
enum AESMode: String, CaseIterable {
    // 电码本模式，分组单独加密
    case ecb = "ECB"
    // 密码分组链接
    case cbc = "CBC"
    // 计算器模式
    case ctr = "CTR"
    // 输出反馈模式
    case ofb = "OFB"
    // 密码反馈模式
    case cfb = "CFB"
}

///
/// 填充模式
///
enum PaddingMode: String, CaseIterable {
    case noPadding = "noPadding"
    case zeroPadding = "zeroPadding"
    case pkcs7 = "pkcs7"
    case pkcs5 = "pkcs5"
    case iso78164 = "ios788164"
    case iso10126 = "iso10126"
    
    ///
    /// 将自定义枚举转换为加密算法内的枚举
    ///
    /// 目前还不知道什么高级用法，后面学会了进行替换
    ///
    var padding: Padding {
        switch self {
            case .noPadding: return .noPadding
            case .zeroPadding: return .zeroPadding
            case .pkcs7: return .pkcs7
            case .pkcs5: return .pkcs5
            case .iso10126: return .iso10126
            case .iso78164: return .iso78164
        }
    }
}

///
/// AES 加密
///
struct AESEncryptView: View {
    
    @State var inputText = ""
    @State var outputText = ""
    @State var aesMode = AESMode.ecb
    @State var paddingMode = PaddingMode.noPadding
    
    var body: some View {
        GeometryReader { geometry in
            VSplitView {
                VStack {
                    HStack {
                        Picker("加密模式", selection: $aesMode) {
                            ForEach(AESMode.allCases, id: \.rawValue) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                        Picker("填充模式", selection: $paddingMode) {
                            ForEach(PaddingMode.allCases, id: \.rawValue) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                    }
                    HStack {
                        Button("xxxx", action: {
                            do {
                                var key = [UInt8]("1234567887654321".bytes)
                                var iv = [UInt8]("xteskkkkkkkkkkkk".bytes)
                                var aes = try AES(key: key,
                                                  blockMode: CBC(iv: iv), padding: paddingMode.padding)
                                var v = try aes.encrypt([UInt8]("test".bytes))
                                outputText = v.map{
                                        String(format: "%02hhx", $0)
                                     }.joined()
                            } catch {
                                switch (error) {
                                case AES.Error.invalidKeySize:
                                    NSLog("invalidKeySize")
                                default:
                                    NSLog(error.localizedDescription)
                                }
                            }
                        })
                        
                    }
                    TextEditorView(text: $inputText)
                }
                .padding()
                VStack {
                    TextEditorView(text: $outputText)
                }
                .padding()
            }
        }
    }
}

struct AESEncryptView_Previews: PreviewProvider {
    static var previews: some View {
        AESEncryptView()
    }
}
