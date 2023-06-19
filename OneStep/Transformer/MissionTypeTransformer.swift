//
//  MissionTypeTransformer.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/7.
//

import Foundation
import UIKit

class MissionTypeTransformer: ValueTransformer {

    override func transformedValue(_ value: Any?) -> Any? {

        guard let missionType = value as? MissionType else { return nil }

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: missionType, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }

    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {

        guard let data = value as? Data else { return nil }

        do {
            let missionType = try NSKeyedUnarchiver.unarchivedObject(ofClass: MissionType.self, from: data)
            return missionType
        } catch {
            return nil
        }

    }

}

