






//
//  wishList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
import SwiftData
struct wishList: View {
    @Environment(\.modelContext) private var context
    @Query private var products: [Products];
    @Query private var defaults: [UserChoices];
    @State var userPoints : Int = 0
    @State var productPrice : Int = 0
    let haptic2 = UIImpactFeedbackGenerator(style: .heavy)
    @State var showAlert: Bool = false

    @State var presentedSheet : Bool = false;
    
    
    @Environment(\.accessibilityReduceMotion) var ReduceMotion;
    
    //    @State var arrayProducts: Product?;
    //    @AppStorage("arrayProducts")
    
    var body: some View {
        NavigationView{
            ZStack{
                WavePage(buttonShwn:true,height1: 160 , height2: 192, isOn: !ReduceMotion,duration1: 28,duration2: 30, showingText: true, headerText: "Wishlist",isPresented:$presentedSheet)
                
                if products.filter({ $0.isRedeemed == false }).count == 0 {
                    VStack(alignment: .center){
                        Image("noProducts").resizable().scaledToFit().frame(width: 100)
                        Text("Create your wishlist")
                        Text("Tap the plus button to get started")
                    } }else{
                        VStack{
                            
                            List{
                                Section{
                                    //                        ForEach(products.indices, id: \.self) { product in
                                    ForEach(products) { product in
                                        //                      if product.filter({ $0 }).isRedeemed = false {}
                                        if product.isRedeemed {}
                                        else{
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
                                                
                                                Text(product.productName).padding(.leading,10).bold()
                                            }
                                            
                                            .swipeActions {
                                                Button(action:
                                                        {  context.delete(product)
                                                    try? context.save()
                                                    haptic2.impactOccurred(intensity: 1)
                                                }) {
                                                    Label("", systemImage: "trash")
                                                }
                                                .tint(.red)
                                                
                                            }
                                            //                            .swipeActions(edge: .leading) {
                                            //                                Button(action: {
                                            //                                    //                                removeTask(at: task)
                                            //                                    defaults[0].points = defaults[0].points +  1;
                                            //                                    try? context.save()
                                            //                                }) {
                                            //                                    Label("", systemImage: "gift")
                                            //                                }
                                            //                                .tint(.yellow)
                                            //                            }
                                            
                                            HStack(alignment:.center){
                                                
                                                Spacer()
                                                if(defaults[0].points >= product.price){
//                                                    .isDetailLink(false)
//                                                    NavigationLink(
//                                                        destination: redeemedView(redeemedProduct: product)){
//                                                            Button(action: {
//
//                                                            }) {
//                                                                Text("Redeem").bold().foregroundColor(Color("ForegroundColor"))
//                                                            }
////                                                            .button .Style(MyButtonStyle))
//                                                    }
                                                    NavigationLink("Redeem", destination: redeemedView(redeemedProduct: product))

                                                    
                                                }
                                                else{
                                                    Text("\(defaults[0].points)/\(product.price)").bold()
                                                    
                                                }
                                                Spacer()
                                                
                                            }
                                        }}
                                    //                                            .onDelete(perform: { indexSet in
                                    //                                                for index in indexSet{
                                    //                                                    context.delete(products[index])
                                    //                                                } })
                                    
                                }header: {
                                    
                                    Text("Products")
                                } }.scrollContentBackground(.hidden)
                            
                            
                        }.padding(.top,180).cornerRadius(25)
                    }
                
                
                
            }.sheet(isPresented: $presentedSheet, content: {
                wishListSheet().presentationDetents([.height(330)])
                    .presentationDragIndicator(.hidden)
                
            }
            )
            .animation(.bouncy)
            
            
            
            
        }.navigationViewStyle(StackNavigationViewStyle())

        
    }
}












#Preview {
    wishList()
}
