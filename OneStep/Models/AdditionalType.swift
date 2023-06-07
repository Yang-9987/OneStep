//
//  AdditionalType.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/7.
//

import Foundation


public class MissionType: NSObject, NSCoding {
    var name: String

    init(name: String) {
        self.name = name
    }

    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
    }

    required public init?(coder: NSCoder) {
        guard let name = coder.decodeObject(forKey: "name") as? String
        else { return nil }

        self.name = name
    }
}

public class TargetType: NSObject, NSCoding {
    var name: String

    init(name: String) {
        self.name = name
    }

    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
    }

    required public init?(coder: NSCoder) {
        guard let name = coder.decodeObject(forKey: "name") as? String
        else { return nil }

        self.name = name
    }
}
