//
//  wishList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
struct wishList: View {
    @State var presentedSheet : Bool = false;
    
    var body: some View {
        ZStack{
            VStack{
                WavePage(height1: 160 , height2: 190, isOn: true,duration1: 20,duration2: 25, showingText: true, headerText: "Wishlist",points: 30,isPresented:$presentedSheet)
            }}.sheet(isPresented: $presentedSheet, content: {
            wishListSheet()
        })
        
      
        
        
        
        
    }
}
    
struct wishListSheet: View{
    var body: some View{
        
        Text("Hello")
    }
}
        


#Preview {
    wishList()
}
