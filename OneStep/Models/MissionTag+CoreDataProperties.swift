//
//  MissionTag+CoreDataProperties.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/25.
//

import Foundation
import CoreData
import UIKit

extension MissionTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MissionTag> {
        return NSFetchRequest<MissionTag>(entityName: "MissionTag")
    }

    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var desc: String

}

extension MissionTag: Identifiable {

}
