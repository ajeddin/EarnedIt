//
//  earnedRewards.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
import SwiftData
import UIKit
struct earnedRewards: View {
    @Environment(\.modelContext) private var context
    @Query private var products: [Products];
    let haptic2 = UIImpactFeedbackGenerator(style: .heavy)

    @State var presentedSheet : Bool = false;
    
    
    @Environment(\.accessibilityReduceMotion) var ReduceMotion;
    
    var body: some View {
        ZStack{
            WavePage(buttonShwn:false,height1: 160 , height2: 192, isOn: !ReduceMotion,duration1: 28,duration2: 30, showingText: true, headerText: "Earned Items",isPresented:$presentedSheet,showButton:true)
            if products.filter({ $0.isRedeemed == true }).count == 0 {
                VStack(alignment: .center){
                    Image("noProducts").resizable().scaledToFit().frame(width: 100)
//                    Text("Create your wishlist")
                    Text("Go And Earn It ").padding(.top,5).foregroundColor(Color("ForegroundColor"))
                    
                } }else{
                    VStack{
                        
                        List{
                            Section{
                                //                        ForEach(products.indices, id: \.self) { product in
                                ForEach(products) { product in
                                    //                      if product.filter({ $0 }).isRedeemed = false {}
                                    if product.isRedeemed {
                                        HStack {
                                            
                                            if(product.imageURL == ""){
                                                Image(systemName: "shippingbox").foregroundColor(Color("AccentColor"))
                                                    .scaledToFill()
                                                    .font(.largeTitle)
                                                
                                                    .frame(width: 80, height: 80)
                                            }else{
                                                
                                                AsyncImage(url: URL(string: product.imageURL)) { phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 80, height: 80)
                                                    } else if phase.error != nil {
                                                        Text("There was an error loading the image.")
                                                    } else {
                                                        ProgressView()
                                                    }
                                                }
                                            }
                                           
                                            VStack(alignment: .leading){
                                                Text(product.productName)

                                                
                                                
                                                Text("$\(product.price)")
                                            }.foregroundColor(Color("ForegroundColor")).bold().padding(.leading,10)
                                        }
                                        .swipeActions {
                                            Button(action:
                                                    { haptic2.impactOccurred(intensity: 1)
                                                context.delete(product)
                                                try? context.save()
                                            }) {
                                                Label("", systemImage: "trash")
                                            }
                                            .tint(.red)}
                                        .swipeActions(edge: .leading) {
                                            Button(action: {
                                                UIApplication.shared.open(URL(string: product.productLink)!)
                                            }) {
                                                Label("", systemImage: "link")
                                            }
                                            .tint(.blue)
                                        }
                                    }
                                }
                                
                            }header: {
                                
                                Text("Earned Products").foregroundColor(Color("ForegroundColor"))
                            } }.scrollContentBackground(.hidden)
                    }.padding(.top,180).cornerRadius(25)
                }}
    }
}

#Preview {
    earnedRewards()
}
