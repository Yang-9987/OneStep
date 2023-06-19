//
//  TimerModel.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/13.
//

import Foundation
import SwiftUI

class TimerModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate  {

    @Published var progress: CGFloat = 1.0
    @Published var timeStringValue: String = "00:00"
    @Published var isRunning: Bool = false
    @Published var addNewTimer: Bool = false

    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0

    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0

    @Published var isFinished: Bool = false

    override init() {
        super.init()
        self.authorizedNotification()
    }



    func authorizedNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (_, _) in
        }

        UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {

        completionHandler([.sound, .banner])
    }



    func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)){
            isRunning = true
        }
        timeStringValue = "\(hours == 0 ? "" : "\(hours):")\(minutes >= 10 ? "\(minutes):" : "0\(minutes):")\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        totalSeconds = hours * 3600 + minutes * 60 + seconds
        staticTotalSeconds = totalSeconds
        addNewTimer = false
        addNotification()
    }

    func stopTimer() {
        withAnimation {
            isRunning = false
            hours = 0
            minutes = 0
            seconds = 0
            progress = 1
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timeStringValue = "00:00"
    }

    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        hours = totalSeconds / 3600
        minutes = (totalSeconds / 60) % 60
        seconds = totalSeconds % 60
        timeStringValue = "\(hours == 0 ? "" : "\(hours):")\(minutes >= 10 ? "\(minutes):" : "0\(minutes):")\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        if hours == 0 && seconds == 0 && minutes == 0 {
            isRunning = false
            isFinished = true
        }
    }

    func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Timer"
        content.subtitle = "Congratulations!"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))

        UNUserNotificationCenter.current().add(request)
    }

}
