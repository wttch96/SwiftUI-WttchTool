//
//  JX3Util.swift
//  WttchTools
//
//  Created by Wttch on 2022/11/8.
//

import Foundation
import SwiftUI

public struct JX3StyleTextLine: Identifiable {
    public typealias ID = Int
    public var id: Int
    public var texts: [JX3StyleText] = []
}

public struct JX3StyleText : Identifiable {
    public typealias ID = Int
    public var id: Int
    public var styles: [String: String]
    public var color: Color? {
        get {
            if let rStr = styles["r"], let gStr = styles["g"], let bStr = styles["b"] {
                if let r = Int(rStr), let g = Int(gStr), let b = Int(bStr) {
                    return Color(cgColor: CGColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1))
                }
            }
            return nil
        }
    }
}



/// https://github.com/JX3BOX/jx3box-common/blob/master/js/utils.js
public class JX3Util {
    public static func texts(_ texts: [JX3StyleText]) -> [JX3StyleTextLine] {
        var result: [JX3StyleTextLine] = []
        var line : [JX3StyleText] = []
        for text in texts {
            let textStr = "\(text.styles["text"]!)".replacingOccurrences(of: "\\n", with: "\n")
            var t = text
            t.styles["text"] = textStr.replacingOccurrences(of: "\n$", with: "", options: .regularExpression, range: nil)
            line.append(t)
            if textStr.hasSuffix("\n") {
                result.append(JX3StyleTextLine(id: text.id, texts: line))
                line = []
            }
        }
        if !line.isEmpty {
            result.append(JX3StyleTextLine(id: -1, texts: line))
        }
        return result
    }
    
    /// 将游戏内的形如`<Text>text="****" font="**" **=***</text>`的字符串进行解析
    /// 返回一个包含font、text等属性的对象，方便进行进一步的渲染或者其他处理。
    public static func extractTextContent(_ textStr: String?) -> [JX3StyleText] {
        guard let text = textStr else {
            return []
        }
        // xml字符串
        var xmlString = "<xml>" + text + "</xml>"
        // 替换<Text>***</text>为<span ***></span>
        xmlString = xmlString.replacingOccurrences(of: "<Text>(.*?)</text>", with: "<span $1></span>", options: .regularExpression, range: nil)
        // swift xml库解析时属性的值必须为带引号的
        xmlString  = xmlString.replacingOccurrences(of: "=(\\d+)", with: "='$1'", options: .regularExpression, range: nil)
        var results: [JX3StyleText] = []
        var i = 0
        do {
            // 提取span的所有属性
            let xml = try XMLDocument(xmlString: xmlString)
            let spans = xml.rootElement()?.elements(forName: "span")
            for span in spans! {
                var result : [String:String] = [:]
                for attr in span.attributes ?? [] {
                    if let key = attr.localName, let val = attr.stringValue {
                        result[key] = val
                    }
                }
                if !result.isEmpty {
                    let styleText = JX3StyleText(id: i, styles: result)
                    results.append(styleText)
                    i += 1
                }
            }
        } catch {
            NSLog(error.localizedDescription)
        }
        return results
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
