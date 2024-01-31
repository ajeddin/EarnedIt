//
//  toDoList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI

struct toDoList: View {
        @State var presentedSheet : Bool = false;
        
        var body: some View {
            ZStack{
                VStack{
                    WavePage(height1: 160 , height2: 190, isOn: true,duration1: 20,duration2: 25, showingText: true, headerText: "To-Do List",points: 30,isPresented:$presentedSheet)
                }}.sheet(isPresented: $presentedSheet, content: {
                    toDoListSheet()
            })
            
          
            
            
            
            
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
