//
//  toDoList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI

struct toDoList: View {
    @State private var addedTasks: [String: [String]] = ["Easy": [], "Medium": [], "Hard": []]
    @State var presentedSheet : Bool = false;
    @State private var newTask = ""
    
    var body: some View {
        ZStack{
            VStack{
                WavePage(height1: 160 , height2: 190, isOn: true,duration1: 20,duration2: 25, showingText: true, headerText: "To-Do List",points: 30,isPresented:$presentedSheet)
            }.sheet(isPresented: $presentedSheet, content: {
                toDoListSheet()
            })
            VStack{
                NavigationStack{
                    List {
//                        Section {
//                            HStack{
//                                TextField("Add Task", text: $newTask)
//                            }
//                        }
                        Section(header: Text("Favorites").foregroundColor(.green).bold().font(.system(size: 16))) {
                           
                            
                            ForEach(addedTasks["Easy"] ?? [], id:\.self) {task in
                                HStack{
                                    Text(task)
                                    Spacer()
                                    Button (action: {} ) {
                                        Label("", systemImage: "star")
                                    }
                                    
                                    Button (action: {} ) {
                                        Label("", systemImage: "circle")
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        Section(header: Text("Simple").foregroundColor(.green).bold().font(.system(size: 16))) {
                            HStack {
                                TextField("Add Task", text: $newTask, onCommit: { addNewTask(section: "Easy")})
                                
                            }
                            
                            ForEach(addedTasks["Easy"] ?? [], id:\.self) {task in
                                HStack{
                                    Text(task)
                                    Spacer()
                                    Button (action: {} ) {
                                        Label("", systemImage: "star")
                                    }
                                    
                                    Button (action: {} ) {
                                        Label("", systemImage: "circle")
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        Section(header: Text("Moderate").foregroundColor(.yellow).bold().font(.system(size: 16))) {
                            HStack {
                                TextField("Add Task", text: $newTask, onCommit:{ addNewTask(section: "Medium")})
                            }
                            
                            
                            ForEach(addedTasks["Medium"] ?? [], id:\.self) {task in
                                HStack{
                                    Text(task)
                                    
                                    Spacer(minLength: 50)
                                    
                                    
                                    Button (action: {} ) {
                                        Label("", systemImage: "star")
                                    }
                                    Button (action: {} ) {
                                        Label("", systemImage: "circle")
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                        Section (header: Text("Difficult").foregroundColor(.red).bold().font(.system(size: 16))){
                            HStack {
                                TextField("Add Task", text: $newTask, onCommit: { addNewTask(section: "Hard")})
                            }
                            ForEach(addedTasks["Hard"] ?? [], id:\.self) {task in
                                HStack{
                                    
                                    Text(task)
                                    Spacer()
                                    
                                    Button (action: {} ) {
                                        Label("", systemImage: "star")
                                    }
                                    
                                    
                                    Button (action: {} ) {
                                        Label("", systemImage: "circle")
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    .onSubmit{(addNewTask(section: "hard"))
                    }
                }
                
                
            }.padding(.top,200)
        }
    }
    
    func addNewTask(section: String) {
        let task = newTask.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard task.count > 0 else { return }
        
        addedTasks[section, default: []].insert(task, at: 0)
        newTask = ""
    }
}
        
    struct toDoListSheet: View{
        var body: some View{
            
            Text("Hello TODO")
        }
    }
            


    #Preview {
        toDoList()
    }
