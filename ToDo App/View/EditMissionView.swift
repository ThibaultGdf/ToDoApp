//
//  EditMissionView.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 05/01/2023.
//

import SwiftUI
import CoreData

struct EditMissionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var missionVM : MissionViewModel
    @ObservedObject var item : Item
    @State var title: String = ""
    @State var mission: String = ""
    @State var recompense: String = ""
    var body: some View {
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Text("Annuler")
                }
                
                Spacer()
                Text("Modifier la mission")
                Spacer()
                Button {
                    missionVM.editItem(item: item, title: title, mission: mission, recompense: recompense)
                    dismiss()
                } label: {
                    Text("Enregistrer")
                }
            } .padding()
            
            Form{
                Section("Modifier la mission") {
                    TextField("", text: $title, prompt: Text("Titre"))
                    TextField("", text: $mission, prompt: Text("Mission"))
                    TextField("", text: $recompense, prompt:   Text("Récompense"))
            }
        }
        }
        .onAppear{
            title = item.title ?? ""
            mission = item.mission ?? ""
            recompense = item.mission ?? ""
        }
        
}

}

struct EditMissionView_Previews: PreviewProvider {
    static var previews: some View {
        EditMissionView(item: Item())
    }
}
