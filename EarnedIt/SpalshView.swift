//
//  homePage.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
//struct Wave: Shape {
//    var yOffset: CGFloat = 0.4
//
//    var animatableData: CGFloat {
//        get {
//            return yOffset
//        }
//        
//        set {
//            yOffset = newValue
//        }
//    }
//    func path(in rect: CGRect) -> Path {
//    var path = Path()
//        path.move (to: .zero)
//    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY) )
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY) )
//    // Curve at the bottom
//        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY) ,
//                      control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY - (rect.maxY * yOffset)),
//                      control2: CGPoint(x: rect.maxX * 0.25, y: rect.maxY + (rect.maxY * yOffset) ))
//    path.closeSubpath ()
//        
//        return path
//    }
//}



struct SplashPage: View {
    var height1: CGFloat;
    var height2: CGFloat;
    var isOn : Bool
    var duration1 : Double;
    var duration2 : Double;
//    var points: Int;
    var cond = false;
    @State private var change = false;
    
    
    
    
    
    
    var body: some View{
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack(alignment: .top) {
                    // 18
                    
                    
                    
                    
                    
                        Wave(yOffset: change ? 0.6 : -0.7)
                        
                            . fill(Color("PrimaryApp"))
                        //                        . shadow (radius: 4)
                        
                            . frame (height: height1)
                            .animation (Animation.easeInOut(duration: duration1).repeatForever(autoreverses: true))
                        
                        
                        
                        
                        Wave(yOffset: change ? -0.4 : -0.7)
                            . fill (Color("PrimaryApp"))
                            . opacity (0.38)
                            . frame (height: height2) //150
                        //                        .shadow (radius: 4)
                        
                            . animation (Animation.easeInOut(duration: duration2).repeatForever (autoreverses:true) )
                        
                    
                    
                    
                }       .ignoresSafeArea(.all)


                Spacer ()
               
                
            }.onAppear(perform: {
                if(isOn){
                    self.change.toggle()
                }
            })
            
        }}}
        
        
//
//#Preview {
//    WavePage(height1: 180 , height2: 210, isOn: false,duration1: 8,duration2: 7,showingText: true,headerText: "To-Do List",points: 30)
//}
