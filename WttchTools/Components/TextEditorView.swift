//
//  TextEditorView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import SwiftUI


///
/// 配置通用的 NSTextView 属性，主要用来设置 TextEditor 等的默认行为
///
extension NSTextView {
    open override var frame: CGRect {
        didSet {
            // 清除背景颜色
            backgroundColor = .clear
            // 绘制背景
            drawsBackground = true
            // 边距：会影响一些组件的正常使用，不建议使用
            // textContainerInset = NSSize(width: 8, height: 10)
        }

    }
}

///
/// 自定义文本输入视图
///
/// 因为 TextEditor 一些属性不方便设置，所以结合 NSTextView 的扩展方法来做些默认属性修改从而达到需要的效果
///
struct TextEditorView: View {
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .font(.headline)
            .foregroundColor(.white)
            //.multilineTextAlignment(.center)    // 对齐方式
            // 模拟 NSTextView textContainerInset 效果
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            // NSTextView 的默认背景颜色，会根据暗色模式进行修改
            .background(Color(nsColor: NSColor.textBackgroundColor))
            .cornerRadius(8)
    }
}


struct TextEditorView_Previews: PreviewProvider {
    
    ///
    /// 直接预览时无法使用 @State 修饰器，所以使用一层包装
    ///
    struct TextEditorViewWrapper: View {
        @State var input = ""
        var body: some View {
            TextEditorView(text: $input)
        }
    }
    
    static var previews: some View {
        TextEditorViewWrapper()
    }
}
