//
//  RegularMission+CoreDataProperties.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/7.
//
//

import Foundation
import CoreData
import UIKit


extension RegularMission {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegularMission> {
        return NSFetchRequest<RegularMission>(entityName: "RegularMission")
    }

    @NSManaged public var bubuImg: UIImage?
    @NSManaged public var completeFlag: Bool
    @NSManaged public var createDate: Date?
    @NSManaged public var missionOrder: MissionType?
    @NSManaged public var statusFlag: Int64
    @NSManaged public var tag: MissionTag?
    @NSManaged public var targetNum: Int64
    @NSManaged public var targetOrder: TargetType?
    @NSManaged public var targetTime: Double
    @NSManaged public var title: String?

}

extension RegularMission : Identifiable {

}
