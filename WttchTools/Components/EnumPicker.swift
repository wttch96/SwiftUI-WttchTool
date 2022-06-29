        //
//  EnumPicker.swift
//  Wtt chTools
//
//  Created by Wttch on 2022/6/27.
//

import SwiftUI

///
/// 枚举选择器的协议
///
protocol PickerItem: Hashable, CaseIterable {
    var value: String { get }
}

///
/// 枚举选择器
///
struct EnumPicker<T>: View where T : PickerItem{
    // 标题
    var title: String? = nil
    // 选择器选择的对象
    @Binding var selection: T
    
    // 获取枚举的所有 case, 用来迭代生成选项
    private func allCase() -> [T] {
        return Array(T.allCases)
    }
    
    var body: some View {
        Picker(title ?? "", selection: $selection) {
            ForEach(allCase(), id: \.value) { mode in
                Text(mode.value).tag(mode)
            }
        }
    }
}

struct EnumPicker_Previews: PreviewProvider {
    
    enum Item: String, PickerItem {
        case A = "A"
        case B = "B"
        case other = "其他"
        var value: String {
            return self.rawValue
        }
    }
    
    struct PreviewsWrapper: View {
        @State var select: Item = .A
        
        var body: some View {
            EnumPicker(title: "选择", selection: $select)
        }
    }
    
    static var previews: some View {
        PreviewsWrapper()
    }
}
