//
//  toDoList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
import SwiftData
struct toDoList: View {
    @Environment(\.modelContext) private var context
    @Query private var tasks: [Tasks];

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
                           
                            
                            ForEach(tasks) { task in
                                HStack{
                                    Text(task.taskText)
                                    Spacer()
                                    Button (action: {} ) {
                                        Label("", systemImage: "star")
                                    }
                                    
                                    Button (action: {} ) {
                                        Label("", systemImage: "circle")
                                    }
                                    
                                    
                                }.swipeActions {
                                    Button(action:
                                            {context.delete(task)
                                    }) {
                                        Label("", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                                
                            }
                            
                        }
                        
                        Section(header: Text("Simple").foregroundColor(.green).bold().font(.system(size: 16))) {
                            
                            
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
                            HStack {
                                TextField("Add Task", text: $newTask, onCommit: { addNewTask(task: Tasks(taskText: newTask, taskPoints: 5))})
                                
                            }
                            
                        }
                        
                        Section(header: Text("Moderate").foregroundColor(.yellow).bold().font(.system(size: 16))) {
                          
                            
                            
                            ForEach(addedTasks["Medium"] ?? [], id:\.self) {task in
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
                            HStack {
//                                TextField("Add Task", text: $newTask, onCommit:{ addNewTask(section: "Medium")})
                            }
                            
                        }
                        Section (header: Text("Difficult").foregroundColor(.red).bold().font(.system(size: 16))){
                            
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
                            
                        
                        HStack {
//                            TextField("Add Task", text: $newTask, onCommit: { addNewTask(section: "Hard")})
//                        }
                    }
                }
                    .scrollContentBackground(.hidden)
                    
//                    .onSubmit{(addNewTask(section: "hard"))
                    }
                }
                
            }.padding(.top,200)
        }
    }
    
    func addNewTask(task: Tasks) {
        task.taskText = task.taskText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard task.taskText.count > 0 else { return }
        context.insert(task)
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
