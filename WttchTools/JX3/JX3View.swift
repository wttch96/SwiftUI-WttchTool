//
//  JX3View.swift
//  WttchTools
//
//  Created by Wttch on 2022/11/7.
//

import SwiftUI
import WebKit

struct JX3View: View {
    @State var text: String = ""
    @State var textStyle: [JX3StyleText] = []
    @State var texts: [JX3StyleTextLine] = []
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onAppear {
                    // JX3Api().searchItem("岚尘")
                    let text = "<Text>text=\"使用：本周每获得5000点战阶积分，可以开启一次瑰石\\n获得如下的装备，每周最多开启二个。\\n\" font=105 </text><Text>text=\"[怒鳞翻江·碎月重剑]\" name=\"iteminfolink\" eventid=513 script=\"this.nVersion=0 this.dwTabType=6 this.dwIndex=27689 this.OnItemLButtonDown=function() OnItemLinkDown(this) end\" font=100 r=255 g=40 b=255 </text><Text>text=\"，\" font=100 </text><Text>text=\"[怒鳞翻江·碎月轻剑]\" name=\"iteminfolink\" eventid=513 script=\"this.nVersion=0 this.dwTabType=6 this.dwIndex=27688 this.OnItemLButtonDown=function() OnItemLinkDown(this) end\" font=100 r=255 g=40 b=255 </text><Text>text=\"。\" font=100 </text>"
                    textStyle = JX3Util.extractTextContent(text)
                    texts = JX3Util.texts(textStyle)
                }
            VStack(alignment: .leading, spacing: 0) {
                ForEach(texts, content: { textLine in
                    HStack(spacing: 0) {
                        ForEach(textLine.texts, content: { text in
                            Text("\(text.styles["text"]!)".replacingOccurrences(of: "\\n", with: "\n"))
                                .foregroundColor(text.color)
                        })
                    }
                })
            }
            AttributedText(htmlContent: text)
        }
    }
}

struct JX3View_Previews: PreviewProvider {
    static var previews: some View {
        JX3View()
    }
}


struct AttributedText: NSViewRepresentable {
    let htmlContent: String
    
    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText(htmlContent: "<h1>This is HTML String</h1>")
    }
}
