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
    @State var presentedSheet : Bool = false;
    @State var pointss : Int = 2;

    @Environment(\.accessibilityReduceMotion) var ReduceMotion;

//    @State var arrayProducts: Product?;
//    @AppStorage("arrayProducts")

    var body: some View {
        ZStack{
            WavePage(height1: 175 , height2: 210, isOn: !ReduceMotion,duration1: 28,duration2: 30, showingText: true, headerText: "Wishlist",points: pointss,isPresented:$presentedSheet)
            
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
                                Text(product.productName).padding(.leading,10)
                                Text("\(Int(product.price))")
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
                                }) {
                                    Label("", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                Button(action: {
                                    //                                removeTask(at: task)
                                    pointss = pointss + 1;
                                }) {
                                    Label("", systemImage: "gift")
                                }
                                .tint(.yellow)
                            }
                            VStack{
                                Text("redeem points")
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
