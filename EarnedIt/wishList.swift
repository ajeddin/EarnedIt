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

    @State var presentedSheet : Bool = false;


    @Environment(\.accessibilityReduceMotion) var ReduceMotion;

//    @State var arrayProducts: Product?;
//    @AppStorage("arrayProducts")

    var body: some View {
        ZStack{
            WavePage(buttonShwn:true,height1: 175 , height2: 210, isOn: !ReduceMotion,duration1: 28,duration2: 30, showingText: true, headerText: "Wishlist",isPresented:$presentedSheet)

            
            VStack{
                List{
                    Section{
//                        ForEach(products.indices, id: \.self) { product in
                        ForEach(products) { product in
                            HStack {
                                
                                AsyncImage(url: URL(string: product.imageURL)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } else if phase.error != nil {
                                        Text("There was an error loading the image.")
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                Text(product.productName).padding(.leading,10).bold()
//                                Text("\(Int(product.price))")
                            }
//                            .swipeActions {
//                                Button(action:
//                                        {
//                                    
//                                    
//                                    
//                                    context.delete(products[product])
//                                }) {
//                                    Label("", systemImage: "pencil")
//                                }
//                                .tint(.orange)
//                            }
                            .swipeActions {
                                Button(action:
                                        {  context.delete(product)
                                    let defaultUser = UserChoices(points: 0, onboardingViewed: true)
                                    context.insert(defaultUser)
                                }) {
                                    Label("", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                Button(action: {
                                    //                                removeTask(at: task)
                                    defaults[0].points = defaults[0].points +  1;
                                    try? context.save()
                                }) {
                                    Label("", systemImage: "gift")
                                }
                                .tint(.yellow)
                            }

                            VStack{
                                Button{
                                    
                                }
                            label: {
                                Text("Redeem")
                            }
                                
                            }
                        }
//                                            .onDelete(perform: { indexSet in
//                                                for index in indexSet{
//                                                    context.delete(products[index])
//                                                } })
                        
                    }header: {
                        
                        Text("Products")
                    } }.scrollContentBackground(.hidden)

                
            }.padding(.top,180).cornerRadius(25)
            

            
            
        }.sheet(isPresented: $presentedSheet, content: {
                wishListSheet()  .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        })
        
      
        
        
        
        
    }
}
    











#Preview {
    wishList()
}
