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
    @Environment(\.accessibilityReduceMotion) var ReduceMotion;

//    @State var arrayProducts: Product?;
//    @AppStorage("arrayProducts")

    var body: some View {
        ZStack{
            WavePage(height1: 160 , height2: 190, isOn: !ReduceMotion,duration1: 25,duration2: 30, showingText: true, headerText: "Wishlist",points: 30,isPresented:$presentedSheet)
            
            VStack{
                List{
                    Section{
                        ForEach(products.indices, id: \.self) { product in
                            HStack {
                                
                                AsyncImage(url: URL(string: products[product].imageURL)) { phase in
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
                                Text(products[product].productName).padding(.leading,10)
                                Text("\(Int(products[product].price))")
                            }
                            .swipeActions {
                                Button(action:
                                        {
                                    
                                    
                                    
                                    context.delete(products[product])
                                }) {
                                    Label("", systemImage: "pencil")
                                }
                                .tint(.orange)
                            }
                            .swipeActions {
                                Button(action:
                                        {  context.delete(products[product])
                                }) {
                                    Label("", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                Button(action: {
                                    //                                removeTask(at: task)
                                }) {
                                    Label("", systemImage: "gift")
                                }
                                .tint(.yellow)
                            }
                            VStack{
                                Text("redeem points")
                            }
                        }
                        //                    .onDelete(perform: { indexSet in
                        //                        for index in indexSet{
                        //                            context.delete(products[index])
                        //                        } })
                        
                    }header: {
                        
                        Text("Products")
                    } }.scrollContentBackground(.hidden)
              

                
            }.padding(.top,180)

            
            
        }.sheet(isPresented: $presentedSheet, content: {
                wishListSheet()  .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        })
        
      
        
        
        
        
    }
}
    











#Preview {
    wishList()
}
