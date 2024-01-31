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
                toDoList()
                    .tabItem {
                        Label("To-Do List", systemImage: "cart")}
                wishList()
                //                .environmentObject(data)
                    .tabItem {
                        Label("Wishlist", systemImage: "checkmark")}
                //            SplashScreen()
                //                .tabItem {
                //                    Label("Other Services", systemImage: "star")
                //
                //
                //                }
                
                
            }
        }}
}

#Preview {
    ContentView()
}
