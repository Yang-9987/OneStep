//
//  CoreDataProvider.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/25.
//

import Foundation
import CoreData

class CoreDataProvider {

    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer

    private init() {

        // register transformers
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))

        persistentContainer = NSPersistentContainer(name: "OneStepModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing OneStepModel \(error)")
            }
        }
    }
}
