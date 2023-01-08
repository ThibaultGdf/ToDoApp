//
//  DetailView.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 04/01/2023.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var missionVM : MissionViewModel
    @ObservedObject var newItem: Item
    @State var editItem: Item?
    @State var title: String = ""
    @State var mission: String = ""
    @State var recompense: String = ""
    @State var isPresented = false
    private let url = URL(string: "https://www.appcoda.com")!
    
    var body: some View {
        ZStack{
            
            Color.lightBlue
                .ignoresSafeArea()
            
            VStack{
                Text(newItem.title ?? "")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                HStack{
                    Button {
                        missionVM.deleteItem(item: newItem)
                        dismiss()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.darkRed)
                                .frame(width: 110, height: 50)
                            Text("Supprimer")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button {
                        isPresented.toggle()
                        
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.gray)
                                .frame(width: 110, height: 50)
                            Text("Modifier")
                                .foregroundColor(.white)
                        }
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.darkGreen)
                            .frame(width: 110, height: 50)
                        
                        ShareLink(item: url) {
                            Text("Partager")
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Spacer()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(.back)
                    Text("Mission")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Text(newItem.mission ?? "")
                    .foregroundColor(.white)
                
                Spacer()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(.back)
                    Text("Récompense")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }
                
                Text(newItem.recompense ?? "")
                    .foregroundColor(.white)
                Spacer()
                
                
            } .padding(30)
            
                .sheet(isPresented: $isPresented) {
                    EditMissionView(item: newItem)
                    
                }
        
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    static var item: Item = {
        let context = persistence.container.viewContext
        let item = Item(context: context)
        item.title = "Titre"
        item.mission = "Mission"
        item.recompense = "Récompense"
        return item
    }()
    
    static var previews: some View {
        DetailView(newItem: item, editItem: item)
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
