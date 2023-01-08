//
//  BackView.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 06/01/2023.
//

import SwiftUI

struct BackView : View {
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [.back, .darkBlue]),
                       startPoint: .top, endPoint: .bottom)
        
        .ignoresSafeArea(edges: .top)
        
    }
}
