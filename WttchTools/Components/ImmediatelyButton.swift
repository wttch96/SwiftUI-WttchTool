//
//  ImmediatelyButton.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/11.
//

import SwiftUI

///
/// 快速执行的 Button
///
/// 从粘贴板读取数据到 source 字段中，等待 delay 秒（因为监听 onChange 可能会导致延迟）后，将 target 保存到粘贴板去
///
struct ImmediatelyButton: View {
    // 输入，从粘贴板读取
    @Binding var source: String
    // 输出，延迟 delay 秒将结果添加到粘贴板
    @Binding var target: String
    // 延迟
    var delay = 0.2
    
    var body: some View {
        Button(action: {
            let pasteboard = NSPasteboard.general
            source = pasteboard.string(forType: .string) ?? ""
            NSLog("从粘贴板: \(source)")
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                NSLog("到粘贴板: \(target)")
                pasteboard.clearContents()
                pasteboard.setString(target, forType: .string)
            }
        }, label: {
            Image(systemName: "bolt.fill")
        })
        .help("读取粘贴板进行转换，并将结果复制到粘贴板")
    }
}

struct ImmediatelyButton_Previews: PreviewProvider {
    ///
    /// 直接预览时无法使用 @State 修饰器，所以使用一层包装
    ///
    struct PreviewsWrapper: View {
        @State var sourceText = ""
        @State var resultText = ""
        var body: some View {
            ImmediatelyButton(source: $sourceText, target: $resultText)
        }
    }
    
    static var previews: some View {
        PreviewsWrapper()
    }
}
