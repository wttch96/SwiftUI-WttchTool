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
struct MenuItem: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let icon: String?
    let title: String
    let children: [MenuItem]?
    
    var hashValue: Int {
        return id.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (o1: MenuItem, o2: MenuItem) -> Bool {
        return o1.id == o2.id
    }

    var view: AnyView?
    
    init(icon: String? = nil, title: String, children: [MenuItem]) {
        self.icon = icon
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
    MenuItem(icon: "text.alignleft", title: "文本处理", children: [
        MenuItem(icon: "clock.fill", title: "时间转换", view: TimestampConverterView()),
        MenuItem(icon: "xmark", title: "下划线/驼峰互转", view: UnderCaseCamelCaseView())
    ]),
    MenuItem(icon: "option", title: "编码", children: [
        MenuItem(icon: "list.dash", title: "Base64", view: Base64View()),
        MenuItem(icon: "list.dash", title: "URL", view: Text("URL")),
        MenuItem(icon: "list.dash", title: "URI", view: Text("URI"))
    ]),
    MenuItem(title: "摘要", children: [
        // md5, hmacMD5
        MenuItem(icon: "list.dash", title: "MD5", view: MD5ToolView()),
        // sha1, sha224, sha256, sha384, sha512,
        // with hmac
        MenuItem(icon: "list.dash", title: "散列/哈希", view: Text("SHA"))
    ]),
    MenuItem(title: "对称加密", children: [
        MenuItem(icon: "list.dash", title: "AES", view: AESEncryptView()),
        MenuItem(icon: "list.dash", title: "DES", view: Text("DES")),
        MenuItem(icon: "list.dash", title: "RC4", view: Text("RC4")),
        MenuItem(icon: "list.dash", title: "Rabbit", view: Text("Rabbit")),
        MenuItem(icon: "list.dash", title: "TripleDes", view: Text("TripleDes"))
    ]),
    MenuItem(title: "非对称加密", children: [
        MenuItem(icon: "list.dash", title: "RSA", view: Text("RSA")),
        MenuItem(icon: "list.dash", title: "DSA", view: Text("DSA")),
        MenuItem(icon: "list.dash", title: "ECC", view: Text("ECC")),
        MenuItem(icon: "list.dash", title: "DH", view: Text("DH"))
    ]),
    MenuItem(title: "数字证书", children: [
        MenuItem(icon: "list.dash", title: "数字证书", view: Text("数字证书"))
    ])
]
