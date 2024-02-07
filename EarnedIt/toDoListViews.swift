////
////  toDoListViews.swift
////  EarnedIt
////
////  Created by Mohamed Midani on 2/7/24.
////
//
//import Foundation
//import SwiftUI
//import SwiftData
//
//struct toDoList: View {
//    @Environment(\.modelContext) private var context
//    @Query private var tasks: [Tasks]
//    @Query private var defaults: [UserChoices]
//    @State private var isEditing: Bool = false
//
//    @Environment(\.colorScheme) var colorScheme
//    @State private var addedTasks: [String: [String]] = ["Easy": [], "Medium": [], "Hard": []]
//    @State private var newTask1 = ""
//    @State private var newTask2 = ""
//    @State private var newTask3 = ""
//    @State private var points: Int = 0
//    @State private var presentedSheet = false
//
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//
//    var body: some View {
//        ZStack {
//            VStack {
//                WavePage(buttonShwn: false, height1: 160, height2: 192, isOn: !reduceMotion, duration1: 20, duration2: 25, showingText: true, headerText: "To-Do List", isPresented: $presentedSheet)
//            }
//            VStack {
//                List {
//                    ToDoSection(title: "Simple", color: .green, points: 5, tasks: tasks)
//                    ToDoSection(title: "Moderate", color: .yellow, points: 10, tasks: tasks)
//                    ToDoSection(title: "Difficult", color: .red, points: 20, tasks: tasks)
//                }
//                .scrollContentBackground(.hidden)
//                .background(Color.clear)
//            }
//            .padding(.top, 200)
//        }
//    }
//
//   
//}
//
//struct ToDoSection: View {
//    let title: String
//    let color: Color
//    let points: Int
//    @State var tasks: [Tasks]
//    
//
//
//    @State private var newTask = ""
//
//    var body: some View {
//        Section(header: Text(title).foregroundColor(color).bold().font(.system(size: 16))) {
//            ForEach(tasks.sorted(by: { $0.isFav && !$1.isFav })) { task in
//                if task.taskPoints == points {
//                    ToDoRow(tasks: tasks, task: task)
//                }
//            }
//            addTaskField
//        }
//
//    }
//
//    var addTaskField: some View {
//        HStack {
//            Image(systemName: "plus.app")
//            TextField("Add Task", text: $newTask)
//                .bold()
//                .foregroundColor(Color("ForegroundColor"))
//                .disableAutocorrection(true)
//                .onSubmit() {
//                    addNewTask(task: Tasks(taskText: newTask, taskPoints: points))
//                    newTask = ""
//                }
//        }
//    }
//
//    func addNewTask(task: Tasks) {
//        task.taskText = task.taskText.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard task.taskText.count > 0 else { return }
//        // Handle adding new task to context or wherever necessary
//        tasks.append(task)
//        newTask = ""
//    }
//}
//
//struct ToDoRow: View {
//    @Environment(\.modelContext) private var context
//    @State  var tasks: [Tasks]
//
//    let task: Tasks
//    
//    
//
//    var body: some View {
//        HStack {
//            Button(action: {
//                task.isChecked.toggle()
//                try? context.save()
//            }) {
//                Label("", systemImage: task.isChecked ? "circle.fill" : "circle")
//            }
//            .buttonStyle(.plain)
//            .tint(.clear)
//
//            Text(task.taskText)
//
//            Spacer()
//
//            Button(action: {
//                withAnimation { task.isFav.toggle() }
//                try? context.save()
//            }) {
//                Label("", systemImage: task.isFav ? "bookmark.fill" : "bookmark")
//            }
//            .buttonStyle(.plain)
//            .tint(.clear)
//        }
//        .foregroundColor(Color("ForegroundColor"))
//        .swipeActions {
//            Button(action: {
//                context.delete(task)
//            }) {
//                Label("", systemImage: "trash")
//            }
//            .tint(.red)
//        }
//    }
//}
