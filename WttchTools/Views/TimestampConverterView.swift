//
//  TimestampConverterView.swift
//  WttchTools
//
//  Created by Wttch on 2022/6/8.
//

import SwiftUI

struct TimestampConverterView: View {
    
    @State var inputTime = ""
    @State var select = ""
    
    @State var timer: Timer? = nil
    @State var now: Date = .now
    
    var body: some View {
        VStack {
            HStack {
                Text("输入:")
                Button("现在", action: {
                    inputTime = Date.now.ISO8601Format()
                })
                Button("从粘贴板", action: {
                    let pasteboard = NSPasteboard.general
                    if let string = pasteboard.string(forType: .string) {
                        inputTime = string.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                })
                Button(action: {
                    
                }, label: {
                    Label("清空", systemImage: "xmark.square")
                })
                Button(action: {
                    
                }, label: {
                    Image(systemName: "gearshape.fill")
                })
                Text("\(now)")
                Spacer()
            }
            
            TextField("时间串", text: $inputTime)
            Picker("xxx", selection: $select, content: {
                ForEach(0..<10) {index in
                    Label("test\(index)", systemImage: "").tag("\(index)")
                }
            })
            TextField("", text: $inputTime)
                .disabled(true)
                .textSelection(.enabled)
            Button(action: {
                
            }, label: {
                Image(systemName: "doc.on.doc.fill")
            })
            
            Spacer()
        }
        .padding()
        .navigationTitle("时间转换")
        .onAppear(perform: self.onAppear)
        .onDisappear(perform: self.onDisappear)
    }
    
    
    // MARK: 函数
    func onAppear() {
        NSLog("开始计时")
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in 
            now = Date.now
        }
    }
    
    func onDisappear() {
        NSLog("停止计时")
        timer?.invalidate()
    }
}

struct TimestampConverterView_Previews: PreviewProvider {
    static var previews: some View {
        TimestampConverterView()
    }
}
