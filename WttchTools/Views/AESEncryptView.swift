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
enum AESMode: String, PickerItem {
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
    
    var value: String {
        return self.rawValue
    }
}

///
/// 填充模式
///
enum PaddingMode: String, PickerItem {
    case noPadding = "noPadding"
    case zeroPadding = "zeroPadding"
    case pkcs7 = "pkcs7"
    case pkcs5 = "pkcs5"
    case iso78164 = "ios788164"
    case iso10126 = "iso10126"
    
    var value: String {
        return self.rawValue
    }
    
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
    @State var keyText = ""
    @State var ivText = ""
    @State var aesMode = AESMode.ecb
    @State var paddingMode = PaddingMode.noPadding
    
    @State var keyLen = 0
    @State var keyValid = false
    
    var body: some View {
        GeometryReader { geometry in
            VSplitView {
                VStack {
                    HStack {
                        EnumPicker(title:"加密模式", selection: $aesMode)
                            .frame(maxWidth: 200)
                        EnumPicker(title:"填充模式", selection: $paddingMode)
                            .frame(maxWidth: 200)
                        if aesMode != .ecb {
                            TextField("iv偏移量", text: $ivText)
                        }
                        Spacer()
                    }
                    HStack {
                        TextField("密钥", text: $keyText)
                            .foregroundColor(keyValid ? .green : .red)
                            .onChange(of: keyText) { value in
                                let len =  value.lengthOfBytes(using: .utf8)
                                switch (len * 8) {
                                case 128:
                                    keyLen = 128
                                    keyValid = true
                                case 192:
                                    keyLen = 192
                                    keyValid = true
                                case 256:
                                    keyLen = 256
                                    keyValid = true
                                default:
                                    keyValid = false
                                }
                            }
                    }
                    HStack {
                        Button("加密", action: {
                            do {
                                let key = [UInt8](keyText.bytes)
                                let iv = [UInt8](ivText.bytes)
                                let aes = try AES(key: key,
                                                  blockMode: CBC(iv: iv), padding: paddingMode.padding)
                                let v = try aes.encrypt([UInt8](inputText.bytes))
                                outputText = v.map{
                                        String(format: "%02hhx", $0)
                                     }.joined()
                            } catch {
                                switch (error) {
                                case AES.Error.invalidKeySize:
                                    keyValid = false
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
                    HStack {
                        Text("\(keyValid ? "当前密码长度:\(keyLen)" : "")")
                        Text("\(keyValid ? "" : "密码长度不符合要求")")
                            .foregroundColor(.red)
                        Spacer()
                    }
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
