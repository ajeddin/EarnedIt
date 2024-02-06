//
//  ContentView.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
//    @AppStorage("welcomeScreenShown")
//    var welcomeScreenShown: Bool = false;
    @Environment(\.modelContext) private var context
    @Query private var defaults: [UserChoices];
    var body: some View {
        if (defaults.isEmpty ){
            
            onboarding()
//            let defaultUser = UserDefault(points: 0, onboardingViewed: true)
//            context.insert(defaultUser)
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
//            .ignoresSafeArea(.all)
        }}
}

#Preview {
    ContentView()
}
