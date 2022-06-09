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
    
    var body: some View {
        VStack {
            HStack {
                Button("现在", action: {
                    inputTime = Date.now.ISO8601Format()
                })
                Button("从粘贴板", action: {
                    
                })
                Button(action: {
                    
                }, label: {
                    Label("清空", systemImage: "xmark.square")
                })
                Button(action: {
                    
                }, label: {
                    Image(systemName: "gearshape.fill")
                })
                Spacer()
            }
            
            TextField("时间串", text: $inputTime)
            Picker("xxx", selection: $select, content: {
                ForEach(0..<10) {index in
                    Label("test\(index)", systemImage: "").tag("\(index)")
                }
            })
            
            Spacer()
        }
        .padding()
    }
}

struct TimestampConverterView_Previews: PreviewProvider {
    static var previews: some View {
        TimestampConverterView()
    }
}
