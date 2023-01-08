//
//  TaskViewModel.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 05/01/2023.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    
    @Published var editTask: String = "Today"
    
}
