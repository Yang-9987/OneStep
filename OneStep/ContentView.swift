//
//  ContentView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/15.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var timerModel: TimerModel

    var body: some View {
        TimerView()
            .environmentObject(timerModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
