//
//  toDoList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI

struct toDoList: View {
    @State private var addedTask = [String]()
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
                        Section {
                            HStack{
                                TextField("Add Task", text: $newTask)
                                Button (action: {} ) {
                                    Label("", systemImage: "circle")
                                }
                            }
                        }
                        Section {
                            ForEach(addedTask, id:\.self) {task in Text(task)}
                        }
                    }
                    .onSubmit(addNewTask)

                }
                
                
            }.padding(.top,200)
        }
    }
    
    func addNewTask () {
        let task = newTask
        
        guard task.count > 0 else {return}
        
        addedTask.insert(task, at: 0)
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
