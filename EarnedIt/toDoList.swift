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
    @Query private var defaults: [UserChoices];
    @State private var isEditing: Bool = false

    @Environment(\.colorScheme) var colorScheme
    @State private var addedTasks: [String: [String]] = ["Easy": [], "Medium": [], "Hard": []]
    @State private var newTask1 = ""
    @State private var newTask2 = ""
    @State private var newTask3 = ""
    @State private var points: Int = 0
    @State var presentedSheet = false


    
    var body: some View {
        ZStack{
            VStack{
                WavePage(buttonShwn:false,height1: 160 , height2: 190, isOn: true,duration1: 20,duration2: 25, showingText: true, headerText: "To-Do List",isPresented:$presentedSheet)
            }
            VStack{
                NavigationStack{
                    List {
//                        if tasks.filter({ $0 }).count > 0 {}
                        

                        Section(header: Text("Simple").foregroundColor(.green).bold().font(.system(size: 16))) {
                            
                            
                            ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })) { task in
                                if (task.taskPoints == 5){
                                    
                                    HStack{
                                        Button (action: {
                                            task.isChecked.toggle()
                                           try? context.save()
                                            
                                            if task.isChecked {
                                                defaults[0].points  += 5

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
                               

                            }
                            
                        }
                        
                        Section(header: Text("Moderate").foregroundColor(.yellow).bold().font(.system(size: 16))) {
                          
                                
                                ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })){ task in
                                    if (task.taskPoints == 10){
                                        HStack{
                                            Button (action: {
                                                task.isChecked.toggle()
                                                try? context.save()
                                                
                                                if task.isChecked {
                                                    defaults[0].points += 10
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
                            
                            ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })){ task in
                                if (task.taskPoints == 20){
                                    
                                    HStack{
                                        Button (action: {
                                            task.isChecked.toggle()
                                           try? context.save()
                                            
                                            if task.isChecked {
                                                defaults[0].points  += 20

                                            }
                                            
                                        } ) {
                                            Label("", systemImage: task.isChecked ? "circle.fill" : "circle" )
                                        }
//                                        .buttonStyle(.plain)
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
                                        addNewTask(task: Tasks(taskText: newTask3, taskPoints: 20))
                                        newTask3 = ""
                                    }}

                }.tint(.clear)
                    .scrollContentBackground(.hidden)
                    
//                    .onSubmit{(addNewTask(section: "hard"))
                    }
//                    .background(Color.clear)
//                    .listRowBackground(Color.clear)

                    
                    
                    .listStyle(PlainListStyle())
//.tint(.clear)

                }
//                .tint(.clear)
                
            }.padding(.top,200).tint(.clear)
        }     }
    
    func addNewTask(task: Tasks) {
        task.taskText = task.taskText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard task.taskText.count > 0 else { return }

        context.insert(task)
        
       
    }
}
        
     


    #Preview {
        toDoList()
    }
