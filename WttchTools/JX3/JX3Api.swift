//
//  JX3Api.swift
//  WttchTools
//
//  Created by Wttch on 2022/11/7.
//

import Foundation

class JX3Api {
    
    // https://helper.jx3box.com/api/item/search?keyword=%E9%87%8D%E5%89%91&page=1&limit=15&client=std
    func searchItem(_ keyword: String) -> AnyObject? {
        let urlStr = "https://helper.jx3box.com/api/item/search?keyword=\(keyword)&page=1&limit=15&client=std"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url = URL(string: urlStr) {
            let task = getSession().dataTask(with: url) { (data, response, error) in
                print(String(data: data!, encoding: .utf8))
            }
            task.resume()
            return nil
        } else {
            NSLog("网络请求错误: URL 错误!")
            return nil
        }
    }
    
    func getSession() -> URLSession {
        return URLSession.shared
    }
}
