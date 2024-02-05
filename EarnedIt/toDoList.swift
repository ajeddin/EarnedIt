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
    @Environment(\.colorScheme) var colorScheme
    @State private var addedTasks: [String: [String]] = ["Easy": [], "Medium": [], "Hard": []]
    @State var presentedSheet : Bool = false;
    @State private var newTask1 = ""
    @State private var newTask2 = ""
    @State private var newTask3 = ""

    
    var body: some View {
        ZStack{
            VStack{
                WavePage(buttonShwn:false,height1: 160 , height2: 190, isOn: true,duration1: 20,duration2: 25, showingText: true, headerText: "To-Do List",isPresented:$presentedSheet)
            }.sheet(isPresented: $presentedSheet, content: {
                toDoListSheet()
            })
            VStack{
                NavigationStack{
                    List {
//                        if tasks.filter({ $0.isChecked }).count > 0 {
//                        Section(header: Text("Favorites").foregroundColor(.green).bold().font(.system(size: 16))) {
//                            
//                            
//                            ForEach(tasks) { task in
//                                
//                                if (task.isChecked == true){
//                                    
//                                    HStack{
//                                        Text(task.taskText)
//                                        Spacer()
//                                        Button (action: {} ) {
//                                            Label("", systemImage: "star")
//                                        }
//                                        
//                                        Button (action: {} ) {
//                                            Label("", systemImage: "circle")
//                                        }
//                                        
//                                        
//                                    }.swipeActions {
//                                        Button(action:
//                                                {context.delete(task)
//                                        }) {
//                                            Label("", systemImage: "trash")
//                                        }
//                                        .tint(.red)
//                                    }}
//                                
//                            }
//                            
//                        }
//                    }
                        Section(header: Text("Simple").foregroundColor(.green).bold().font(.system(size: 16))) {
                            
                            
                            ForEach(tasks) { task in
                                if (task.taskPoints == 5){
                                    
                                    HStack{
                                        Button (action: {
                                            task.isChecked.toggle()
                                           try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isChecked ? "circle.fill" : "circle" )
                                        }.buttonStyle(.plain)
                                            .tint(.clear)
                                        Text(task.taskText)
                                        Spacer()
                                        Button (action: {
                                            task.isFav.toggle()
                                           try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isFav ? "bookmark.fill" : "bookmark" )

                                        }.buttonStyle(.plain)
                                            .tint(.clear)
                                        
                                        
                                        
                                    }
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    .swipeActions {
                                        Button(action:
                                                {context.delete(task)
                                        }) {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }}
                                
                                
                            }
                            HStack {
                                TextField("Add Task", text: $newTask1
                                ).foregroundColor(colorScheme == .dark ? Color.white : Color.black)

                                .disableAutocorrection(true)
                                    .onSubmit() {
                                        addNewTask(task: Tasks(taskText: newTask1, taskPoints: 5))
                                            newTask1 = ""
                                    }
//                                Button{
//
//                                }label:{
//                                    Image(systemName: "checkmark").foregroundColor(Color.white)
//                                }
                                
//                                Button (action: {} ) {
//                                    Label("", systemImage: "star")
//                                }
                            }
                            
                        }
                        
                        Section(header: Text("Moderate").foregroundColor(.yellow).bold().font(.system(size: 16))) {
                          
                            
                            
                            ForEach(tasks) { task in
                                if (task.taskPoints == 10){
                                    HStack{
                                        Button (action: {
                                            task.isChecked.toggle()
                                           try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isChecked ? "circle.fill" : "circle" )
                                        }.buttonStyle(.plain)
                                            .tint(.clear)
                                        Text(task.taskText)
                                        
                                        Spacer()
                                        
                                        
                                        Button (action: {
                                            task.isFav.toggle()
                                           try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isFav ? "bookmark.fill" : "bookmark" )

                                        }.foregroundColor(Color.white)

                                        .buttonStyle(.plain)
                                            .tint(.clear)
                                      
                                        
                                    }
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    .swipeActions {
                                        Button(action:
                                                {context.delete(task)
                                        }) {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }}
                                
                            }
                            HStack {
                                TextField("Add Task", text: $newTask2
                                ).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .disableAutocorrection(true)
                                    .onSubmit() {
                                        addNewTask(task: Tasks(taskText: newTask2, taskPoints: 10))
                                        newTask2 = ""
                                    }}

                            
                            
                        }
                        Section (header: Text("Difficult").foregroundColor(.red).bold().font(.system(size: 16))){
                            
                            ForEach(tasks) { task in
                                if (task.taskPoints == 15){
                                    
                                    HStack{
                                        Button (action: {
                                            task.isChecked.toggle()
                                           try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isChecked ? "circle.fill" : "circle" )
                                        }
//                                        .buttonStyle(.plain)
                                            .tint(.clear)
                                        
                                        Text(task.taskText)
                                        Spacer()
                                        
                                        Button (action: {
                                            task.isFav.toggle()
                                           try? context.save()
                                        } ) {
                                                Label("", systemImage: task.isFav ? "bookmark.fill" : "bookmark" )

                                        }
//                                        .buttonStyle(.plain)
                                            .tint(.clear)
                                        
                                        
                                       
                                        
                                        
                                    }
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    .buttonStyle(.plain)

                                    .swipeActions {
                                        Button(action:
                                                {context.delete(task)
                                        }) {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }}
                                
                            }
                            
                        
                            HStack {
                                TextField("Add Task", text: $newTask3
                                ).foregroundColor(colorScheme == .dark ? Color.white : Color.black)

                                .disableAutocorrection(true)
                                    .onSubmit() {
                                        addNewTask(task: Tasks(taskText: newTask3, taskPoints: 15))
                                        newTask3 = ""
                                    }}

                }
                    .scrollContentBackground(.hidden)
                    
//                    .onSubmit{(addNewTask(section: "hard"))
                    }                                            .tint(.clear)

                }
                
            }.padding(.top,200)
        }     }
    
    func addNewTask(task: Tasks) {
        task.taskText = task.taskText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard task.taskText.count > 0 else { return }

        context.insert(task)
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
