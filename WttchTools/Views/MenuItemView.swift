//
//  MenuItemView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/28.
//

import SwiftUI

///
/// 菜单导航栏的视图，通过使用菜单实体生成导航的 Label
///
struct MenuItemView: View {
    let menuItem: MenuItem
    
    var body: some View {
        HStack(spacing: 8) {
            if let icon = menuItem.icon {
                Image(systemName: icon)
            }
            Text(menuItem.title)
        }
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(menuItem: MenuItem(icon: "xmark", title: "标题", view: Circle()))
    }
}
