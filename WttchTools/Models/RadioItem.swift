//
//  RadioItem.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/11.
//

import SwiftUI

///
/// 单选器的 tag 协议
///
protocol RadioTag: Hashable {
    
}

///
/// 单选器的一个选项声明
///
struct RadioItem<T> where T: RadioTag {
    // 单选器的文字
    var text: String
    // 单选器的图标，可选
    var icon: String? = nil
    // 单选器tag的实际内容，需要实现 RadioTag 协议
    var tag: T
}
