//
//  PreviewData.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/26.
//

import Foundation

class PreviewData {

      static var missionTag: MissionTag {
          let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
          let request = MissionTag.fetchRequest()
          return (try? viewContext.fetch(request).first) ?? MissionTag()
      }

}
