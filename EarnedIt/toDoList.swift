//
//  toDoList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

// take components out and make them computed properties in the same view.
// abstract a view whose pattern is used multiple times and make a detail view for it
import SwiftUI
import SwiftData
import UIKit
struct toDoList: View {
    @Environment(\.modelContext) private var context
    @Query private var tasks: [Tasks];
    @Query private var defaults: [UserChoices];
    @State private var isEditing: Bool = false


    @Environment(\.colorScheme) var colorScheme
    @State private var addedTasks: [String: [String]] = ["Easy": [], "Medium": [], "Hard": []]
    @State private var newTask1 = ""
    @State private var newTask2 = ""
    @State private var newTask3 = ""
    @State private var points: Int = 0
    @State var presentedSheet = false
    @State private var animationAmount = 1.0

    
    
    @Environment(\.accessibilityReduceMotion) var ReduceMotion;
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack{
            VStack{
                WavePage(buttonShwn:false,height1: 160 , height2: 192, isOn: !ReduceMotion,duration1: 20,duration2: 25, showingText: true, headerText: "To-Do List",isPresented:$presentedSheet,showButton:true)
                
            }
            VStack{
                List {
                    //                        if tasks.filter({ $0 }).count > 0 {}
                    Group{
                        
                        Section(header: Text("Simple").foregroundColor(.green).bold().font(.system(size: 16))) {
                            
                            
//                            ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })) { task in
                            ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })) { task in

                                if (task.taskPoints == 5){
                                    
                                    HStack{
                                        Button (action: {
                                            withAnimation {
                                                    task.isChecked.toggle()
                                                }
                                            try? context.save()
                                            
                                            if task.isFav {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                    withAnimation {
                                                        task.isChecked.toggle()
                                                    }
                                                    try? context.save()
                                                }}
                                            
                                            if task.isChecked {
                                                defaults[0].points += 5
                                                
                                                withAnimation { if task.isChecked && !task.isFav {
                                                    task.isChecked.toggle()
                                                    context.delete(task)
                                                    
                                                }
                                                }
                                            }
                                        } ) {
                                            Label("", systemImage: task.isChecked ? "circle.fill" : "circle" )
                                        }.buttonStyle(.plain)
                                            .tint(.clear)
                                        Text(task.taskText)
                                        
                                        Spacer()
                                        Button (action: {
                                            withAnimation {  task.isFav.toggle()}
                                            try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isFav ? "bookmark.fill" : "bookmark" )
                                            
                                        }.buttonStyle(.plain)
                                            .tint(.clear)
                                        
                                        
                                    }
                                    
                                    .foregroundColor(Color("ForegroundColor"))
                                    .swipeActions {
                                        Button(action:
                                                {context.delete(task)
                                        }) {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }}
                                
                                
                            }
                            addTaskField1
                            
                        }
                        
                        Section(header: Text("Moderate").foregroundColor(.yellow).bold().font(.system(size: 16))) {
                            
                            
                            ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })){ task in
                                if (task.taskPoints == 10){
                                    HStack{
                                        Button (action: {
                                            withAnimation {
                                                    task.isChecked.toggle()
                                                }
                                            try? context.save()
                                            
                                            if task.isFav {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                    withAnimation {
                                                        task.isChecked.toggle()
                                                    }
                                                    try? context.save()
                                                }}
                                            
                                            if task.isChecked {
                                                defaults[0].points += 10
                                                
                                                withAnimation { if task.isChecked && !task.isFav {
                                                    task.isChecked.toggle()
                                                    context.delete(task)
                                                    
                                                }
                                                }
                                            }
                                        } ) {
                                            Label("", systemImage: task.isChecked ? "circle.fill" : "circle" )
                                        }.buttonStyle(.plain)
                                            .tint(.clear)
                                        Text(task.taskText)
                                        
                                        Spacer()
                                        
                                        
                                        Button (action: {
                                            withAnimation {  task.isFav.toggle()}
                                            try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isFav ? "bookmark.fill" : "bookmark" )
                                            
                                        }
                                        
                                        .tint(.clear)
                                        
                                        
                                    }
                                    .foregroundColor(Color("ForegroundColor"))
                                    .swipeActions {
                                        Button(action:
                                                {context.delete(task)
                                        }) {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }
                                }
                                
                            }
                            addTaskField2

                            
                            
                        }
                        Section (header: Text("Difficult").foregroundColor(.red).bold().font(.system(size: 16))){
                            
                            ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })){ task in
                                if (task.taskPoints == 20){
                                    
                                    HStack{
                                        Button (action: {
                                            withAnimation {
                                                task.isChecked.toggle()
                                            }
                                            try? context.save()
                                            
                                            if task.isFav {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                    withAnimation {
                                                        task.isChecked.toggle()
                                                    }
                                                    try? context.save()
                                                }}
                                            
                                            if task.isChecked {
                                                defaults[0].points += 20
                                                
                                                withAnimation {
                                                    if task.isChecked && !task.isFav {
                                                        task.isChecked.toggle()
                                                        
                                                        context.delete(task)
                                                    }
                                                    
                                                }
                                            }
                                        } ) {
                                            Label("", systemImage: task.isChecked ? "circle.fill" : "circle" )
                                        }
                                        .tint(.clear)
                                        
                                        Text(task.taskText)
                                        Spacer()
                                        Button (action: {
                                            withAnimation {
                                                task.isFav.toggle()}
                                            try? context.save()
                                        } ) {
                                            Label("", systemImage: task.isFav ? "bookmark.fill" : "bookmark" )
                                            
                                        }
                                        .tint(.clear)
                                        
                                    }
                                    .foregroundColor(Color("ForegroundColor"))
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
                            addTaskField3
                            
                        }
                    }
                }.scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .tint(.clear)
                    .animation(.default, value: tasks)
                
            }.padding(.top,200).tint(.clear)
            
        }  .onTapGesture {
            dismissKeyboard()
            newTask3 = ""
            newTask2 = ""
            newTask1 = ""

        }
    }
    
    var addTaskField3: some View {
        HStack {
            Spacer(minLength: 4)
           Image(systemName: "plus.circle")
                .foregroundColor(Color("AccentColor"))

            TextField("Add Task", text: $newTask3)

                .bold()
                .foregroundColor(Color("ForegroundColor"))
                .disableAutocorrection(true)
                .tint(.orange)

                .onSubmit() {
                    addNewTask(task: Tasks(taskText: newTask3, taskPoints: 20))
                    newTask3 = ""
                }.submitLabel(.done)
        }
    }
    
    var addTaskField2: some View {
        HStack {
            Spacer(minLength: 4)
           Image(systemName: "plus.circle")
                .foregroundColor(Color("AccentColor"))

            TextField("Add Task", text: $newTask2)

                .bold()
                .foregroundColor(Color("ForegroundColor"))
//                .accentColor(.yellow)
                .disableAutocorrection(true)
                .onSubmit() {
                    addNewTask(task: Tasks(taskText: newTask2, taskPoints: 10))
                    newTask2 = ""
                }.submitLabel(.done)
        }
    }
    
    var addTaskField1: some View {
        HStack {
            Spacer(minLength: 4)
           Image(systemName: "plus.circle")
                .foregroundColor(Color("AccentColor"))
            
            TextField("Add Task", text: $newTask1)

                .bold()
                .foregroundColor(Color("ForegroundColor"))
                .disableAutocorrection(true)
                .tint(.orange)

                .onSubmit() {
                    addNewTask(task: Tasks(taskText: newTask1, taskPoints: 5))
                    newTask1 = ""
                }.submitLabel(.done)
        }
    }

    
    
    
    func addNewTask(task: Tasks) {
        task.taskText = task.taskText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard task.taskText.count > 0 else { return }

        context.insert(task)
        
       
    }
    
    func completeBookmarkedTask () {
        
    }
    
    func completeNonBookmarkedTask () {
        
    }
    
    
    
}
        
     


    #Preview {
        toDoList()
    }
