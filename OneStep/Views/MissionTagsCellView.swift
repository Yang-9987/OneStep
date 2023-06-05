//
//  MissionTagsCellView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/6/4.
//

import SwiftUI

struct MissionTagsCellView: View {

    let missionTag: MissionTag
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundColor(Color(missionTag.color))
            Text(missionTag.name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .opacity(0.4)
                .padding([.trailing], 10)
        }
    }
}

struct MissionTagsCellView_Previews: PreviewProvider {
    static var previews: some View {
        MissionTagsCellView(missionTag: PreviewData.missionTag)
    }
}
