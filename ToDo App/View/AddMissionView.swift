//
//  AddMissionView.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 04/01/2023.
//

import SwiftUI

struct AddMissionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var missionVM : MissionViewModel
    @State var title: String = ""
    @State var mission: String = ""
    @State var recompense: String = ""
    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    var body: some View {
        
      
            VStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Text("Annuler")
                    }
                    Spacer()
                    Text("Ajouter une mission")
                        
                    Spacer()
                    Button {
                        missionVM.addItem(title: title, mission: mission, recompense: recompense)
                        dismiss()
                    } label: {
                        Text("Ajouter")
                    }
                } .padding()
                
                Form{
                    Section("Ajouter une Mission") {
                        TextField("", text: $title, prompt: Text("Titre"))
                        TextField("", text: $mission, prompt: Text("Mission"))
                        TextField("", text: $recompense, prompt: Text("Récompense"))
                    }
                        Section("ajouter une alerte") {
                            DatePicker(
                                "Heure",
                                selection: $date,
                                in: dateRange,
                                displayedComponents: [.hourAndMinute]
                            )
                            DatePicker(
                                "Date",
                                selection: $date,
                                in: dateRange,
                                displayedComponents: [.date]
                            )
                         
                        }
                
            }
        
       
    }
    }
}


struct AddMissionView_Previews: PreviewProvider {
    static var previews: some View {
        AddMissionView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
