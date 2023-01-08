//
//  ToDo_AppApp.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 04/01/2023.
//

import SwiftUI

@main
struct ToDo_AppApp: App {
    let persistenceController = PersistenceController.shared
    private let notificationManager = NotificationManager()

    init() {
        setupNotifications()
    }

    @StateObject var missionVM = MissionViewModel()
    var body: some Scene {
      
        WindowGroup {
            HomeView(notificationManager: notificationManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(missionVM)
        }
    }
    
    private func setupNotifications() {
        notificationManager.notificationCenter.delegate = notificationManager
        notificationManager.handleNotification = handleNotification

        requestNotificationsPermission()
    }

    private func handleNotification(notification: UNNotification) {
        print("<<<DEV>>> Notification received: \(notification.request.content.userInfo)")
    }

    private func requestNotificationsPermission() {
        notificationManager.requestPermission(completionHandler: { isGranted, error in
            if isGranted {
                // handle granted success
            }

            if let _ = error {
                // handle error

                return
            }
        })
    }
}
