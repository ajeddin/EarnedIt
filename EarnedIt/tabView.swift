//
//  tabView.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI

struct tabView: View {
    var body: some View {
        TabView {
            toDoList()
                .tabItem {
                    Label("To-Do List", systemImage: "cart")}
            wishList()
                .tabItem {
                    Label("Wishlist", systemImage: "checkmark")}
            earnedRewards()
                .tabItem {
                    Label("Other Services", systemImage: "star")
                    
                    
                }
             
          
        }    }
}

#Preview {
    tabView()
}
