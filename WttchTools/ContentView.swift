//
//  ContentView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/25.
//

import SwiftUI

import AppKit

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(toolMenus) { menu in
                        Section(menu.title, content: {
                            ForEach(menu.children ?? []) { subMenu in
                                NavigationLink(destination: {
                                    if let navView = subMenu.view {
                                        navView
                                    }
                                }, label: {
                                    MenuItemView(menuItem: subMenu)
                                })
                            }
                        })
                        .font(.headline)
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
