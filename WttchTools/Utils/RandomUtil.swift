//
//  RandomUtil.swift
//  WttchTools
//
//  Created by Wttch on 2022/7/1.
//

import Foundation

extension String {
    ///
    /// 生成随机字符串,
    ///
    /// - parameter length: 生成的字符串的长度
    ///
    /// - returns: 随机生成的字符串
    ///
    static func random(length: Int) -> String {
        // 随机字母列表
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234456789"
        var ranStr = ""
        for _ in 0 ..< length {
            // 长度大小的随机数
            let index = Int(arc4random_uniform(UInt32(characters.count)))
            // 从随机字母表中选择字母追加
            ranStr.append(characters[characters.index(characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}


