//
//  ContentView.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/25.
//

import SwiftUI

import AppKit

extension NSTextView {
    open override var frame: CGRect {
        didSet {
//            backgroundColor = .clear //<<here clear
//            drawsBackground = true
            textContainerInset = NSSize(width: 8, height: 10)
        }

    }
}

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                ForEach(toolMenus) { menu in
                    DisclosureGroup(content: {
                        ForEach(menu.children ?? []) { subMenu in
                            NavigationLink(destination: {
                                if let navView = subMenu.view {
                                    navView
                                }
                            }, label: {
                                MenuItemView(menuItem: subMenu)
                            })
                        }
                    }, label: {
                        Text(menu.title)
                    })
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
