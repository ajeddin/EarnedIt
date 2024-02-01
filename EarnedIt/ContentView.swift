//
//  ContentView.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("welcomeScreenShown")
    var welcomeScreenShown: Bool = false;
    var body: some View {
        if (!welcomeScreenShown){
            onboarding()
        }else{
            TabView {
            
                wishList()
                //                .environmentObject(data)
                    .tabItem {
                        Label("Wishlist", systemImage: "heart")}
                toDoList()
                    .tabItem {
                        Label("To-Do List", systemImage: "checklist")}
                    .foregroundColor(.blue)

                earnedRewards()
                    .tabItem {
                        Label("Earned Items", systemImage: "checkmark.circle.fill")}
                    .foregroundColor(.blue)


            }
        }}
}

#Preview {
    ContentView()
}
