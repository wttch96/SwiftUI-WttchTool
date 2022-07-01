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
    // 电码本模式，分组单独加密, 不需要 iv
    case ecb = "ECB"
    // 密码分组链接, iv 大小必须和块大小一致
    case cbc = "CBC"
    // 计算器模式, iv 大小必须和块大小一致
    case ctr = "CTR"
    // 输出反馈模式, iv 大小必须和块大小一致
    case ofb = "OFB"
    // 密码反馈模式, iv 大小须和块大小一致或者 cfb8 模式(默认为cfb128模式)和 AES 块大小一致(128)
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
            case .zeroPadding: return .zeroPadding
            // 不需要填充, 也就意味着你对你的数据分割完全信任, 如果分割失败将会报错
            case .noPadding: return .noPadding
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
                        EnumPicker(title:"填充模式", selection: $paddingMode)
                            .frame(maxWidth: 200)
                        EnumPicker(title:"加密模式", selection: $aesMode)
                            .frame(maxWidth: 200)
                        if aesMode != .ecb {
                            TextField("iv偏移量", text: $ivText)
                        }
                        Spacer()
                    }
                    HStack {
                        Text("密钥")
                        TextField("请输入密钥", text: $keyText)
                            .foregroundColor(keyValid ? .green : .red)
                            .frame(maxWidth: 320)
                            .onChange(of: keyText, perform: onKeyTextChange)
                        Text("\(keyValid ? "长度:\(keyLen)" : "长度不符合要求")")
                            .foregroundColor(keyValid ? .green : .red)
                        Spacer()
                    }
                    HStack {
                        Button("加密", action: encrypt)
                        Button("随机", action: example)
                        Spacer()
                    }
                    TextEditorView(text: $inputText)
                }
                .padding()
                VStack {
                    TextEditorView(text: $outputText)
                    HStack {
                        Text("\(keyValid ? "" : "密码长度不符合要求")")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                .padding()
            }
        }
    }
    
    // MARK: 方法
    
    ///
    /// 根据选择的模式和 iv 生成 BlockMode
    ///
    private var blockMode: BlockMode {
        let iv = [UInt8](ivText.bytes)
        switch aesMode {
            case .cbc:
                return CBC(iv: iv)
            case .cfb:
                return CFB(iv: iv)
            case .ctr:
                return CTR(iv: iv)
            case .ecb:
                return ECB()
            case .ofb:
                return OFB(iv: iv)
        }
    }
    
    
    ///
    /// 监听密钥文本变化
    ///
    /// - Parameter value: 密钥文本
    ///
    private func onKeyTextChange(value: String) {
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
    
    ///
    /// 加密
    ///
    private func encrypt() {
        do {
            let key = [UInt8](keyText.bytes)
            let aes = try AES(key: key,
                              blockMode: blockMode, padding: paddingMode.padding)
            let resoultData = try aes.encrypt([UInt8](inputText.bytes))
            outputText = resoultData.map{
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
            outputText = ""
        }
    }

    ///
    /// 举个栗子
    ///
    private func example() {
        let blockSize = Int(arc4random_uniform(3) * 8 + 16)
        keyText = String.random(length: blockSize)
        inputText = String.random(length: blockSize)
        ivText = String.random(length: 16)
        encrypt()
    }
}

struct AESEncryptView_Previews: PreviewProvider {
    static var previews: some View {
        AESEncryptView()
    }
}
