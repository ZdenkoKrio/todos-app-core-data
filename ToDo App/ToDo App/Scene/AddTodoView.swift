//
//  AddTodoView.swift
//  ToDo App
//
//  Created by Zdenko Čepan on 18.09.2023.
//

import SwiftUI
//import CoreData

struct AddTodoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let priorities = ["High", "Normal", "Low"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Todo", text: $name)
                    
                    Picker("Piority", selection: $priority) {
                        ForEach(priorities, id:\.self) {
                            Text($0)
                        }
                    } // PICKER
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if self.name != "" {
                            let newToDo = ToDo(context: viewContext)
                            //newToDo.id = UUID()
                            newToDo.name = self.name
                            newToDo.priority = self.priority
                            
                            do {
                                try viewContext.save()
                                print("New ToDo: \(newToDo.name ?? "") Priority: \(newToDo.priority ?? "")")
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        } //IF
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    } // BUTTON
                } // FORM
                
                Spacer()
            } // VSTACK
            .navigationTitle("New ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    } // BUTTON
                } // ITEM
            } // TOOLBAR
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            } // ALERT
        } // NAVIGATION
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
