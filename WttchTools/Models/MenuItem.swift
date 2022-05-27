//
//  MenuItem.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/25.
//

import SwiftUI
import Foundation

///
/// 菜单
///
struct MenuItem: Identifiable {
    let id: String = UUID().uuidString
    let icon: String?
    let title: String
    let children: [MenuItem]?

    var view: AnyView?
    
    init(title: String, children: [MenuItem]) {
        self.icon = nil
        self.title = title
        self.children = children
        self.view = nil
    }
    
    init<V>(icon: String? = nil, title: String, children: [MenuItem]? = nil, view: V? = nil) where V: View {
        self.icon = icon
        self.title = title
        self.children = children
        self.view = AnyView(view)
    }
}


///
/// 菜单的目录结构
///
let toolMenus: [MenuItem] = [
    MenuItem(title: "文本处理", children: [
        MenuItem(icon: "xmark", title: "下划线/驼峰互转", view: UnderCaseCamelCaseView())
    ]),
    MenuItem(title: "编码", children: [
        MenuItem(icon: "list.dash", title: "base64", view: HashView())
    ])
]
