//
//  DatePicker.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 06/01/2023.
//

import SwiftUI

struct DatePicker<Label> where Label : View {
    @State private var date = Date()

    var body: some View {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
    }
