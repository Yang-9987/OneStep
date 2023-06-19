//
//  BubuImgTransformer.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/19.
//

import Foundation
import UIKit
import CoreData

class UIImageTransformer: ValueTransformer {

    override func transformedValue(_ value: Any?) -> Any? {


        guard let bubuImg = value as? UIImage else { return nil }

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: bubuImg, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }

    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {

        guard let data = value as? Data else { return nil }

        do {
            let bubuImg = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            return bubuImg
        } catch {
            return nil
        }

    }

}
