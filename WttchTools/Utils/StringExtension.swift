//
//  StringExtension.swift
//  WttchTools
//
//  Created by Wttch on 2022/5/26.
//

import Foundation


///
/// 转换为下划线命名的正则, 分两组, 使用正则将 aA 转换为 a_a
///
fileprivate let pattern = "([A-Z])"
fileprivate let regex = try! NSRegularExpression(pattern: pattern, options: [])

extension String {
    
    
    ///
    /// 将下划线字符串转换为驼峰字符串
    ///
    /// - Returns: 驼峰命名格式的字符串
    func underCase2CamelCase() -> String {
        return self
            .split(separator: "_")  // 分割下划线
            .map { String($0) }  // 将子串转换为字符串
            .enumerated()  // 将数字转换为 index, element 这样的列表形式
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() } // 从第一个子串开始大些首字母
            .joined() // 拼接子串
    }
    
    ///
    /// 将驼峰字符串转换为下划线命名格式
    ///
    /// 分两组, 使用正则将 aA 转换为 a_a
    ///
    /// - Returns: 下划线命名格式的字符串
    func camelCase2UnderCase() -> String {
        let range = NSRange(location: 1, length: self.count - 1)
        // 类似 idea 的替换（应该是公共的方式，只是用 idea 的正则替换多些）
        // in: 替换的目标字符串
        // range: 替换范围
        // withTemplate: 替换模版, $1_$2 将第一个匹配的分组和第二个匹配分组命中的串使用 "_" 连接
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "_$1").lowercased()
    }
}
