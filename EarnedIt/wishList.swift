






//
//  wishList.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
import SwiftData
struct wishList: View {
//    @AppStorage("isPresented")
    @State var isPresented: Bool = false;
    @Environment(\.modelContext) private var context
    @Query private var products: [Products];
    @Query private var defaults: [UserChoices];
    @State var userPoints : Int = 0
    @State var productPrice : Int = 0
    @State var item : Products = Products(imageURL: "", productName: "", price: 0, productLink: "")
    let haptic2 = UIImpactFeedbackGenerator(style: .heavy)
    @State var showAlert: Bool = false

    @State var presentedSheet : Bool = false;

    
    @Environment(\.accessibilityReduceMotion) var ReduceMotion;
    
    //    @State var arrayProducts: Product?;
    //    @AppStorage("arrayProducts")
    
    var body: some View {
//        NavigationView{
            ZStack{
                WavePage(buttonShwn:true,height1: 160 , height2: 192, isOn: !ReduceMotion,duration1: 28,duration2: 30, showingText: true, headerText: "Wishlist",isPresented:$presentedSheet,showButton:true)
                
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
                                            .swipeActions(edge: .leading) {
                                                Button(action: {
                                                    UIApplication.shared.open(URL(string: product.productLink)!)
                                                }) {
                                                    Label("", systemImage: "link")
                                                }
                                                .tint(.blue)
                                            }
                                            HStack(alignment:.center){
                                                
                                                Spacer()
                                                if(defaults[0].points >= product.price){
                                                    Button(action: {
                                                        
                                                        item = product;
                                                        defaults[0].points =   defaults[0].points - product.price
                                                        product.isRedeemed = true
                                                        try? context.save()
                                                        isPresented = true
                                                        
                                                     }) {
                                                         Text("Redeem").bold().foregroundColor(Color("ForegroundColor"))
                                                     }
                                                  
                                                    /*redeemedView(redeemedProduct: product)*/
//                                                    NavigationLink(destination: redeemedView(redeemedProduct: product), isActive: $shouldNavigate) {
//                                                        EmptyView()
//                                                    }
                                                    
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
                
                
                
            }.fullScreenCover(isPresented: $isPresented, content: {redeemedView(redeemedProduct: item)})

            .sheet(isPresented: $presentedSheet, content: {
                wishListSheet().presentationDetents([.height(330)])
                    .presentationDragIndicator(.hidden)
//                    .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)

                
            }
            )
            .animation(.bouncy)
            
            
            
            
            
//        }.navigationViewStyle(StackNavigationViewStyle())

        
    }
}












#Preview {
    wishList()
}



