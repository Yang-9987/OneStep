//
//  TimerView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/15.
//

import SwiftUI

struct TimerView: View {

    @EnvironmentObject var timerModel : TimerModel

    var body: some View {
        VStack {
            Text("Timer")
                .font(.title2.bold())
                .foregroundColor(.white)
            GeometryReader { proxy in
                VStack(spacing: 15) {
                    ZStack {
                        // 白底圆圈
                        Circle()
                            .fill(.white.opacity(0.03))
                            .padding(-40)
                        // 渐变白色圆圈
                        Circle()
                            .trim(from: 0, to: timerModel.progress)
                            .stroke(.white.opacity(0.03), lineWidth: 80)
                        // 紫色圆圈
                        Circle()
                            .stroke(Color.purple, lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        // 蓝色实心填充
                        Circle()
                            .fill(Color("DARK BLUE"))
                        // 进度条
                        Circle()
                            .trim(from: 0, to: timerModel.progress)
                            .stroke(Color.purple.opacity(0.7), lineWidth: 10)
                        // 进度条小点
                        GeometryReader { proxy in
                            let size = proxy.size

                            Circle()
                                .fill(Color.purple)
                                .frame(width: 30, height: 30)
                                .overlay {
                                    Circle().fill(.white).padding(5)
                                }
                                .frame(width: size.width, height: size.height, alignment: .center)
                                .offset(x: size.width / 2)
                                .rotationEffect(.init(degrees: timerModel.progress * 360))
                        }

                        Text(timerModel.timeStringValue)
                            .font(.system(size: 45, weight: .light))
                            .rotationEffect(.init(degrees: 90))
                            .animation(.none, value: timerModel.progress)
                    }
                    .padding(60)
                    .frame(width: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: timerModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                    Button {
                        if timerModel.isRunning {
                            timerModel.stopTimer()
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        } else {
                            timerModel.addNewTimer = true
                        }

                    } label: {
                        Image(systemName: !timerModel.isRunning ? "timer" : "pause")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background {
                                Circle()
                                    .fill(.purple)
                            }
                            .shadow(color: .purple, radius: 8, x: 0, y: 0)
                    }

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .background {
            Color("DARK BLUE")
                .ignoresSafeArea(.all, edges: .all)
        }
        .overlay(content: {
            ZStack {
                Color.black
                    .opacity(timerModel.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        timerModel.hours = 0
                        timerModel.minutes = 0
                        timerModel.seconds = 0
                        timerModel.addNewTimer = false
                    }

                NewTimerView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: timerModel.addNewTimer ? 0 : 400)
            }
            .animation(.easeInOut, value: timerModel.addNewTimer)
        })
        .preferredColorScheme(.dark)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if timerModel.isRunning {
                timerModel.updateTimer()
            }
        }
        .alert("Congratulations!", isPresented: $timerModel.isFinished) {
            Button("Start New" ,role: .cancel) {
                timerModel.stopTimer()
                timerModel.addNewTimer = true
            }
            Button("Cancel", role: .destructive) {
                timerModel.stopTimer()
            }
        }
    }

    @ViewBuilder
    func NewTimerView() -> some View {
        VStack(spacing: 15) {
            Text("Add New Timer")
                .font(.title2.bold())

            HStack(spacing: 15) {
                Text("\(timerModel.hours) hr")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 24, hint: "hr") { value in
                            timerModel.hours = value
                        }
                    }

                Text("\(timerModel.minutes) min")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 60, hint: "min") { value in
                            timerModel.minutes = value
                        }
                    }

                Text("\(timerModel.seconds) sec")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 24, hint: "sec") { value in
                            timerModel.seconds = value
                        }
                    }
            }
            .padding(.top, 20)

            Button {
                timerModel.startTimer()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background {
                        Capsule()
                            .fill(.purple)
                    }
            }
            .disabled(timerModel.seconds == 0)
            .opacity(timerModel.seconds == 0 ? 0.5 : 1)
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("DARK BLUE"))
                .ignoresSafeArea()
        }
    }

    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, onclick: @escaping (Int) -> ()) -> some View {
        ForEach(0...maxValue, id: \.self) { value in
            Button("\(value) \(hint)") {
                onclick(value)
            }
        }
    }

}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimerModel())
    }
}
