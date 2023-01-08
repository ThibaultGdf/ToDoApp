//
//  HomeView.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 05/01/2023.
//

import SwiftUI

struct HomeView: View {
    let content = UNMutableNotificationContent()
    let notificationManager: NotificationManager
    var body: some View {
        NavigationView{
            ZStack{
                
                Color.lightBlue
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack{
                        
                        Spacer()
                        Spacer()
                        
                        Text("ToDo")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.back)
                                .padding(30)
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 0)
                        .frame(height: 250)
                        .foregroundColor(.back)
                    
                    NavigationLink {
                        
                        MissionView(notificationManager: NotificationManager())
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.back)
                                .frame(height: 50)
                            Text(">   Acceder aux missions   <")
                                .foregroundColor(.white)
                        } .padding(40)
                        
                    }
                    
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(.back)
                        .ignoresSafeArea()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(notificationManager: NotificationManager())
    }
}
