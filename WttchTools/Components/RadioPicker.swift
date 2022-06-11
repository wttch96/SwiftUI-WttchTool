//
//  RadioPicker.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/11.
//

import SwiftUI

///
/// 使用 Picker 制作的 Radio 选择器
///
/// T 单选器需要实现 RadioTag 协议，将单选器的所有选项声明在 items 字段中
///
struct RadioPicker<T>: View where T: RadioTag {
    // 单选器的标题
    var title: String? = nil
    // 单选器的选项列表
    var items: [RadioItem<T>]
    // 单选器选择的数据
    @Binding var selection: T
    
    var body: some View {
        Picker(selection: $selection, label: Text(title ?? "")) {
            ForEach(items, id: \.tag) { item in
                if let icon = item.icon {
                    Label(item.text, systemImage: icon).tag(item.tag)
                } else {
                    Text(item.text).tag(item.tag)
                }
            }
        }
        // 单选器风格
        .pickerStyle(RadioGroupPickerStyle())
        .horizontalRadioGroupLayout()
    }
}

struct RadioPicker_Previews: PreviewProvider {
    
    enum Item: String, RadioTag {
        case item1 = "item1"
        case item2 = "item2"
    }
    
    struct PreviewsWrapper: View {
        @State var item: Item = .item1
        var body: some View {
            RadioPicker(title: "测试题目", items: [
                RadioItem(text: "item1", tag: Item.item1),
                RadioItem(text: "item2", icon: "2.square", tag: Item.item2),
            ], selection: $item)
        }
    }
    
    
    static var previews: some View {
        PreviewsWrapper()
    }
}
