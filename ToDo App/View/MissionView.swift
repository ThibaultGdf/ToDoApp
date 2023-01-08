//
//  ContentView.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 04/01/2023.
//

import SwiftUI
import CoreData

struct MissionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var showingSheet = false
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.dueDate, ascending: true), NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    let notificationManager: NotificationManager

    var body: some View {
        ZStack{
            Color.lightBlue
                .ignoresSafeArea()
            VStack {
                ForEach(items) { item in
                    NavigationLink {
                        DetailView(newItem: item, editItem: item)
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 60)
                                .foregroundColor(.back)
                                
                            Text(item.title!)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .font(.system(size: 25))
//                                .onAppear {
//                                                 scheduleNotification(triggerDate: item.dueDate!, taskContent: "\(item.title!): le \(item.dueDate!)")
//                                             }
                        }
                    } 
                }
                
             
                
                .onDelete(perform: deleteItems)
            }
            
            
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showingSheet.toggle()
                    } label :{
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddMissionView()
                    }
                }
            }
            .refreshable {
                print("Actualisation")
            }
        }
    }

    private func scheduleNotification(triggerDate: Date, taskContent: String) {
        let notificationId = UUID()
        let content = UNMutableNotificationContent()
        content.body = "New notification \(notificationId)"
        content.sound = UNNotificationSound.default
        content.userInfo = [
            "notificationId": "\(notificationId)" // additional info to parse if need
        ]

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: NotificationHelper.getTriggerDate(triggerDate: triggerDate)!,
                repeats: false
        )

        notificationManager.scheduleNotification(
                id: "\(notificationId)",
                content: content,
                trigger: trigger)
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView(notificationManager: NotificationManager()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
