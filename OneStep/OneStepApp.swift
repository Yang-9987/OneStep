//
//  OneStepApp.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/25.
//

import SwiftUI

@main
struct OneStepApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
