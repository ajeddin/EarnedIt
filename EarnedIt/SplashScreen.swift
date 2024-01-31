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
    var body: some View {
        ZStack{
            if self.isActive{
                toDoList()
            }else{
                Rectangle()
                    .foregroundColor(Color("Primary")).ignoresSafeArea()
                
                WavePage(height1: 140, height2: 200,isOn: true, duration1: 1,duration2: 1)
                    .padding(.top,350)
                
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}


//#Preview {
//    SplashScreen(isActive: bindin)
//}
