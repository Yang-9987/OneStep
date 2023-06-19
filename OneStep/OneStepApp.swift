//
//  OneStepApp.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/25.
//

import SwiftUI

@main
struct OneStepApp: App {

    @StateObject var timerModel: TimerModel = .init()

    @Environment(\.scenePhase) var phase
    @State var lastActiveTimeStamp: Date = Date()
    var body: some Scene {
        WindowGroup {
//            HomeView()
            ContentView()
                .environmentObject(timerModel)
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
        .onChange(of: phase) { newValue in
            if timerModel.isRunning {
                if newValue == .background{
                    lastActiveTimeStamp = Date()
                }
                if newValue == .active{
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if timerModel.totalSeconds - Int(currentTimeStampDiff) <= 0 {
                        timerModel.isRunning = false
                        timerModel.totalSeconds = 0
                        timerModel.isFinished = true
                    } else {
                        timerModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                }
            }
        }
    }
}
