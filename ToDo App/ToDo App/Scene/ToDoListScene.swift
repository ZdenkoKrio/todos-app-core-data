//
//  ToDoListScene.swift
//  ToDo App
//
//  Created by Zdenko Čepan on 18.09.2023.
//

import SwiftUI

struct ToDoListScene: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: ToDo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<ToDo>
    
    @State private var showingAddTodoView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                        } // HSTACK
                    } // EACH
                    .onDelete(perform: deleteTodo)
                } // LIST
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    } // TOOLBAR ITEM
                    
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
                
                if todos.count == 0 {
                    EmptyListView()
                }
            } // ZSTACK
        } // NAVIGATION
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            viewContext.delete(todo)
            
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ToDoListScene_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListScene()
    }
}
