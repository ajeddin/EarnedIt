//
//  homePage.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
import SwiftData
struct Wave: Shape {
    var yOffset: CGFloat = 0.4

    var animatableData: CGFloat {
        get {
            return yOffset
        }
        
        set {
            yOffset = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
    var path = Path()
        path.move (to: .zero)
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY) )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY) )
    // Curve at the bottom
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY) ,
                      control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY - (rect.maxY * yOffset)),
                      control2: CGPoint(x: rect.maxX * 0.25, y: rect.maxY + (rect.maxY * yOffset) ))
    path.closeSubpath ()
        
        return path
    }
}



struct WavePage: View {
    @Environment(\.modelContext) private var context
    @Query private var defaults: [UserDefault];
    var buttonShwn: Bool
    var height1: CGFloat;
    var height2: CGFloat;
    var isOn : Bool
    var duration1 : Double;
    var duration2 : Double;
    var showingText: Bool;
    var headerText: String;
//    var points: Int;
    @Binding var isPresented :Bool;
    var cond = false;
    @State private var change = false;
    
    
    
    
    
    
    var body: some View{
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack(alignment: .top) {
                    // 180
                    
                    if (showingText){
                        Wave(yOffset: change ? 0.6 : -0.7)
                        
                            . fill(Color("PrimaryApp"))
                        //                        . shadow (radius: 4)
                        
                            . frame (height: height1)
//                            .overlay(alignment: .bottomLeading){Text("\(headerText)").padding([.leading,.bottom],28)        .font(Font.system(size: 32)).bold().foregroundColor(Color("ForegroundColor"))}
//                            .overlay(alignment: .bottomLeading){Text("Points: \(points)").padding([.leading,.top],30)        .font(Font.system(size: 18)).bold().foregroundColor(Color("ForegroundColor"))}
                            .animation (Animation.easeInOut(duration: duration1).repeatForever(autoreverses: true))
                        
                        
                        
                        
                        Wave(yOffset: change ? -0.4 : -0.7)
                            . fill (Color("PrimaryApp"))
                            . opacity (0.38)
                            . frame (height: height2) //150
                        //                        .shadow (radius: 4)
                        
                            . animation (Animation.easeInOut(duration: duration2).repeatForever (autoreverses:true) )
                        
                            .overlay(alignment: .topLeading){
                                HStack{
                                    VStack{
                                        
                                        Text("\(headerText)")
                                        //                                        .padding([.leading,.top],28)
                                            .font(Font.system(size: 35)).bold().foregroundColor(Color("ForegroundColor"))
                                        
                                        Text("Points: \(defaults[0].points)")
//                                                                                .padding(.leading,30)
                                        //                                        .padding(.top,50)
                                            .font(Font.system(size: 18)).bold().foregroundColor(Color("ForegroundColor"))
                                    }.padding(.leading,30)
                                    Spacer()
                                    if (buttonShwn){
                                        Button(action: {isPresented=true}) {
                                            Image(systemName: "plus")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 19, height: 19)
                                                .foregroundColor(Color("AccentColor"))
                                                .padding(15)
                                                .background(Color.white)
                                                .clipShape(Circle())
                                        }
                                        .padding([.top,.trailing],20)
                                        //                                .padding(.trailing,5)
                                        
                                    }}.padding(.top,50)
                                
                            }
//
//                        
//                            .overlay(alignment: .topLeading){Text("Points: \(points)")
//                                .padding(.leading,30)
//                                .padding(.top,50)
//                                .font(Font.system(size: 18)).bold().foregroundColor(Color("ForegroundColor"))}
//                        
                        
//                        
//                            .overlay(alignment:.topTrailing){
////                                Button(action: {isPresented=true}) {
//                                    Button(action: {}) {
//
//                                    Image(systemName: "plus")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 19, height: 19)
//                                        .foregroundColor(Color("AccentColor"))
//                                        .padding(15)
//                                        .background(Color.white)
//                                        .clipShape(Circle())
//                                }
//                                .padding([.top,.trailing],23)
//                                .padding(.trailing,5)
//                                
//                            }
//                        
                    }
                    
                    
                    
                    
                    
                    else{
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
                        
                    }
                    
                    
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
