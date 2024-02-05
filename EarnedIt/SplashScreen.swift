//
//  SplashScreen.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale = 0.7
    @Binding var isActive: Bool
    @Environment(\.accessibilityReduceMotion) var ReduceMotion;
    var body: some View {
        ZStack{
            if self.isActive{
                toDoList()
            }else{
                Rectangle()
                    .foregroundColor(Color("PrimaryApp")).ignoresSafeArea()
//                    .overlay(Image("EarnedIt") .resizable().scaledToFit())
                WavePage(buttonShwn:false, height1: 160, height2: 200,isOn: !ReduceMotion, duration1: 1.6,duration2: 1.8,showingText: false , headerText: "",isPresented: $isActive)
                    .padding(.top,450)
                Image("EarnedIt") .resizable().scaledToFit().frame(width: 300,height: 180).padding(.bottom,150)

                
                Spacer()
            }
            //        }
            //        .scaleEffect(scale)
            //            .onAppear{
            //                withAnimation(.easeIn(duration: 0.7)) {
            //                    self.scale = 0.9
            //                }
            //            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

//
//#Preview {
//    SplashScreen(isActive: bindin)
//}
