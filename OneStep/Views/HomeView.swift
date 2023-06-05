//
//  ContentView.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/25.
//

import SwiftUI

struct HomeView: View {

    @FetchRequest(sortDescriptors: [])
    private var missionTagResults: FetchedResults<MissionTag>

    @State private var isAddingNewMissionTag: Bool = false

    var body: some View {
        NavigationStack {
            MissionTagsView(missionTags: missionTagResults)
            Spacer()
            Button {
                isAddingNewMissionTag = true
            } label: {
                Text("Add NewMissionTag")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.headline)
            }.padding()
        }
        .sheet(isPresented: $isAddingNewMissionTag) {
            NavigationView {
                AddNewTagView { name, color in
                    do {
                        try MissionService.saveMissionTag(name, color)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
