//
//  MissionService.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/4.
//

import Foundation
import CoreData
import UIKit

class MissionService {

    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }

    static func save() throws {
        try viewContext.save()
    }

    static func saveMissionTag(_ name: String, _ color: UIColor) throws {
        let missionTag = MissionTag(context: viewContext)
        missionTag.name = name
        missionTag.color = color
        try save()
    }

}
