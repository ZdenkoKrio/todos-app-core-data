//
//  ToDoListScene.swift
//  ToDo App
//
//  Created by Zdenko Čepan on 18.09.2023.
//

import SwiftUI

struct ToDoListScene: View {
    
    @State private var showingAddTodoView: Bool = false
    
    var body: some View {
        NavigationView {
            List(1 ..< 5) { item in
                Text("vv")
            } // LIST
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    } // BUTTON
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView()
                    }// SHEET
                } // TOOLBAR ITEM
            } // TOOLBAR
        } // NAVIGATION
    }
}

struct ToDoListScene_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListScene()
    }
}
