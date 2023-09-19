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
    
    @State private var showingSettingsView: Bool = false
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
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
                            .accentColor(themes[self.theme.themeSettings].themeColor)
                    } // TOOLBAR ITEM
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showingSettingsView.toggle()
                        }) {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        } // BUTTON
                        .accentColor(themes[self.theme.themeSettings].themeColor)
                        .sheet(isPresented: $showingSettingsView) {
                            SettingsScene()
                        } // SHEET
                    } // TOOLBAR ITEM
                } // TOOLBAR
                
                if todos.count == 0 {
                    EmptyListView()
                }
            } // ZSTACK
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView()
            }// SHEET
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    } // GROUP
            // TODO why my toolbar items shaking forever but button not?
                    .onAppear(perform: {
                        withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: true)) {
                            self.animatingButton.toggle()
                        }
                    })
                    
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    } //BUTTON
                    .accentColor(themes[self.theme.themeSettings].themeColor)
                } // ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
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
