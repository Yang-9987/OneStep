//
//  TimeView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/9.
//

import SwiftUI

struct TimeView: View {

    // 创建一个变量用于记录计时器的状态
    @State var isStart = false

    // 创建一个变量用于记录倒计时的时间
    @State var timeCount = 0

    // 创建一个变量用于控制Picker的显示和隐藏
    @State var isShowPicker = true

    var body: some View {
        VStack{



            // 创建一个Picker用于选择倒计时的时间，选择的值会赋值给timeCount，Picker的显示和隐藏由isShowPicker控制
            if isShowPicker {
                Picker(selection: $timeCount, label: Text("Time")) {
                    ForEach(0..<60) { index in
                        Text("\(index)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .frame(width: 100, height: 100, alignment: .center)
                .clipped()
                .background(Color.red).cornerRadius(50).foregroundColor(.white).padding()
            } else {
                // 创建一个Text用于显示倒计时的时间
                Text("\(timeCount)")
                    .font(.system(size: 100))
                    .foregroundColor(.red)
                    .padding()
            }

            Text("Time")
            // 创建一个按钮
            Button(action: {
                // 按钮的点击事件
                // 判断计时器的状态, 如当前选择的时间是0，则不开始计时并且提示选择大于0的时间
                if isStart {
                    // 如果计时器正在运行，点击按钮后，计时器停止
                    isStart = false
                    // 计时停止后，让Picker可见
                    isShowPicker = true
                } else {
                    // 如果计时器没有运行，点击按钮后，计时器开始运行
                    isStart = true
                    // 当开始计时的时候，让Picker不可见
                    isShowPicker = false

                }
                // 创建一个计时器, 到0是自动停止
                let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    // 每次计时器触发的事件
                    // 判断计时器的状态
                    if isStart {
                        // 如果计时器正在运行，时间减一
                        timeCount -= 1
                        // 如果时间减到0，计时器停止
                        if timeCount == 0 {
                            isStart = false
                        }
                    }
                }
            }) {
                Text(isStart ? "Stop" : "Start")
            }
        }

    }

}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView()
    }
}
