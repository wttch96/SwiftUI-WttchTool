//
//  JX3Util.swift
//  WttchTools
//
//  Created by Wttch on 2022/11/8.
//

import Foundation

public class JX3Util {
    
    /// 将游戏内的形如`<Text>text="****" font="**" **=***</text>`的字符串进行解析
    /// 返回一个包含font、text等属性的对象，方便进行进一步的渲染或者其他处理。
    public static func extractTextContent(_ textStr: String?) -> String {
        guard let text = textStr else {
            return ""
        }
        
        let xmlString = "<xml>" + text + "</xml>"
        var result = xmlString.replacingOccurrences(of: "<Text>(.*?)</text>", with: "<span $1></span>", options: .regularExpression, range: nil)
        result  = result.replacingOccurrences(of: "=(\\d+)", with: "='$1'", options: .regularExpression, range: nil)
        NSLog(result)
        var ret = [[:]]
        do {
            let xml = try XMLDocument(data: result.data(using: .utf8)!)
            let spans = xml.rootElement()?.elements(forName: "span")
            for span in spans! {
                var ret1: [String:String] = [:]
                for attr in span.attributes ?? [] {
                    NSLog("\(attr.localName) \(attr.stringValue)")
                    ret1[attr.localName!] = attr.stringValue!
                }
                ret.append(ret1)
            }
        } catch {
            NSLog(error.localizedDescription)
        }
        return "<div>\(result)</div>"
    }
}

//
//     * 将游戏内的形如`<Text>text="****" font="**" **=***</text>`的字符串进行解析
//     * 返回一个包含font、text等属性的对象，方便进行进一步的渲染或者其他处理。
//     * @param {String} str
//     */
//    extractTextContent(str) {
//        if (!str || typeof str !== "string") return [];
//        let result = [];
//        const innerHTML = str.replace(/<Text>(.*?)<\/text>/gimsy, `<span $1></span>`);
//        let $ = cheerio.load(`<div>${innerHTML}</div>`);
//        let spans = $('span');
//        if (!spans.length) return [];
//        for (let span of spans)
//            result.push(Object.assign({}, span.attribs));
//        return result;
//    },
