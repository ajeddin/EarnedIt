//
//  redeemedView.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 2/6/24.
//

import SwiftUI
import ConfettiSwiftUI
import SwiftData
import UIKit
struct redeemedView: View {
    @Environment(\.dismiss) var dismiss

    @Environment(\.accessibilityReduceMotion) var ReduceMotion;
    @State var presentedSheet : Bool = false;
    @State private var isShaking = false
    @Environment(\.modelContext) private var context
    @Query private var products: [Products];
    @Query private var defaults: [UserChoices];

    
    @State private var counter: Int = 2
    @State var num: Int = 500
    @State var fadesOut: Bool = true
    @State var rainHeight: CGFloat = 600.0
    @State var openingAngle: Angle = .degrees(60)
    @State var closingAngle: Angle = .degrees(120)
    @State var radius: CGFloat = 300
    @State var repetitions: Int = 0
    @State var repetitionInterval: Double = 1.0
    @State var redeemedProduct: Products


    var body: some View {
        
        ZStack{
            
                
                
                WavePage(buttonShwn:false,height1: 160 , height2: 192, isOn: !ReduceMotion,duration1: 20,duration2: 25, showingText: true, headerText: "You Earned It!!!",isPresented:$presentedSheet,showButton:false)
            
            VStack{
                
                Spacer()
                Spacer()
                Spacer()

                Text(redeemedProduct.productName).padding(.leading,10).font(.title3).multilineTextAlignment(.center)


                HStack {
                    if(redeemedProduct.imageURL == ""){
                        Image(systemName: "shippingbox").foregroundColor(Color("AccentColor"))
                            .scaledToFill()
                            .font(.largeTitle)
                        
                            .frame(width: 80, height: 80)
                    }else{
                        
                        AsyncImage(url: URL(string: redeemedProduct.imageURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 170, height: 170)
                            } else if phase.error != nil {
                                Text("There was an error loading the image.")
                            } else {
                                ProgressView()
                            }
                        }
                    }
                }
                
                
                Spacer()
                
                
                Button{
                    UIApplication.shared.open(URL(string: redeemedProduct.productLink)!)

                }label: {
                
                    if(!ReduceMotion){
                        Image("redeemGift")
                            .resizable()
                            .scaledToFit()
                        .modifier(ShakeEffect(shakes: isShaking ? 1 : 0))
                        .onAppear {withAnimation(Animation.linear(duration: 0.1).repeatForever(autoreverses: true)) {self.isShaking.toggle()
                        }
                        }
                    }else{
                        Image("redeemGift")
                            .resizable()
                            .scaledToFit()
                    }
                }
                Spacer()
                HStack{
                    Button{
                        dismiss()
                    }label:{
                        Text("Back").foregroundColor(Color("ForegroundColor"))
                    }
                    .padding(.leading)

                    Spacer()
                }
                
                
//                    .confettiCannon(counter: $counter,num: 200, rainHeight: 800.0, openingAngle: .degrees(80), closingAngle: .degrees(160), radius: 500)
                Spacer()
                
            }.confettiCannon(counter: $counter,num: 200, rainHeight: 800.0, openingAngle: .degrees(60), closingAngle: .degrees(120), radius: 500)
        }.onAppear {
            if(!ReduceMotion){
                startConfettiAnimation()
            }
//            defaults[0].points =   defaults[0].points - redeemedProduct.price
//            redeemedProduct.isRedeemed = true
//            try? context.save()
        }

       
    }
    private func startConfettiAnimation() {
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
               // Trigger confetti animation
               withAnimation(Animation.linear(duration: 0.5)) {
                   counter += 1
               }
               // Reset animation after it completes
               DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                   counter = 2
                   startConfettiAnimation() // Restart animation
               }
           }
       }
}
struct ShakeEffect: GeometryEffect {
    var shakes: CGFloat
    
    var animatableData: CGFloat {
        get { return shakes }
        set { shakes = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xOffset = CGFloat.random(in: -20...20) * shakes
        let yOffset = CGFloat.random(in: -5...5) * shakes
        return ProjectionTransform(CGAffineTransform(translationX: xOffset, y: yOffset))
    }
    
}

//#Preview {
//    redeemedView()
//}

