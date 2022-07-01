//
//  ContentView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/25.
//

import SwiftUI

import AppKit

struct ContentView: View {
    @State var selectedItem: MenuItem? = nil
    @State var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility,
            sidebar: {
            // 不能循环生成多个 List, 这样每个 List 的高度将不好调整 (每个 List 都会一样的高度, 而内容却不一样多)
            // 有机会看看 List 的实现, selection 真正获取数据的地方在 NavigationLink 的 value 那里
            // 只是尝试了下这样写可不可以, 结果完美解决了问题
            List(selection: $selectedItem) {
                ForEach(toolMenus) { menu in
                    Section(menu.title) {
                        ForEach(menu.children ?? []) { subMenu in
                            NavigationLink(value: subMenu, label: {
                                MenuItemView(menuItem: subMenu)
                            })
                        }
                    }
                }
            }
            // 导航栏宽度
            .frame(width: 200)
        }, detail: {
            if let item = selectedItem {
                item.view
            } else {
                Text("default page")
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
