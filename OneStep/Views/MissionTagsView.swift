//
//  MissionTagsView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/4.
//

import SwiftUI

struct MissionTagsView: View {

    let missionTags: FetchedResults<MissionTag>

    var body: some View {
        NavigationStack {

            if missionTags.isEmpty {
                Spacer()
                Text("No Tags found")
            } else {
                ForEach(missionTags) { tag in
                    VStack {
                        MissionTagsCellView(missionTag: tag)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading], 10)
                            .font(.title3)
                        Divider()
                    }
                }
            }
        }
    }
}

//struct MissionTagsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionTagsView()
//    }
//}
