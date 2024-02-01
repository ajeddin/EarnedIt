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
//    @State var arrayProducts: Product?;
//    @AppStorage("arrayProducts")

    var body: some View {
        ZStack{
            VStack{
                WavePage(height1: 160 , height2: 190, isOn: true,duration1: 25,duration2: 30, showingText: true, headerText: "Wishlist",points: 30,isPresented:$presentedSheet)
                
//                Text("\(arrayProducts[0].rating)")
                List{
                    ForEach(products) { product in
                                            Text(product.productName!)
                                        }
                }
                
                
                
            }}.sheet(isPresented: $presentedSheet, content: {
                wishListSheet()
        })
        
      
        
        
        
        
    }
}
    
struct wishListSheet: View{
    @Environment(\.modelContext) private var context
    @State var link: String = "";
    @State var photo: String = "";
    @State var itemName: String = "";
    @State var price: String = "";
    @State var amazonBool : Int = 0;
    @State var response : String = "";
    @State var isValidLink : Bool = false

    var body: some View{
        
        VStack {
            Picker("What is your favorite color?", selection: $amazonBool) {
                Text("Amazon Product").tag(1)
                Text("Non-Amazon Product").tag(2)
            }
            .pickerStyle(.segmented)
            
            if (amazonBool==1){
                Text("Please paste amazon link here:")
                TextField("Link", text: $link)
                Button(action: {
                    if let range = link.range(of: "https") {
                        var result = String(link[range.lowerBound...])
                        result = result.trimmingCharacters(in: .whitespacesAndNewlines)
                        link = result
                        print(result)
                    } else {
                        print("Substring 'https' not found")
                    }
                    if var urlLink = URL(string: link), UIApplication.shared.canOpenURL(urlLink) {
                    
                    getRealImage(url: URL(string:link)!) { result in
                        switch result {
                        case .success(let response):
//                            print("Image URL:  \(response)")
                            getProductImage(url: URL(string:response)!) { result in
                                switch result {
                                case .success(let response):
                                    let product = Products(imageURL: response.0, productName: response.2, price: 90.0, rating: response.1)
                                    context.insert(product)
//                                   arrayProducts.append(Products(imageURL: photo, productName: itemName, price: 90.0, rating: price))
//                                    photo = response.0
//                                    price = response.1
//                                    itemName = response.2
                                    isValidLink = true

                                case .failure(let error):
                                    print("Error: \(error)")
                                }
                            }
                            
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }      
                } else {
                    Text("Invalid URL")
                        .foregroundColor(.red)
                }
                    
                }) {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 19, height: 19)
                    .foregroundColor(Color("AccentColor"))
                    .padding(15)
                    .background(Color.white)
                    .clipShape(Circle())
            }
                if (isValidLink){
                    Text("\(price) \n \(itemName)\n")
                    AsyncImage(url: URL(string: photo)) { phase in
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
                                .frame(width: 200, height: 200)
                            }
                
            }
            else if(amazonBool==2){
                TextField("Link", text: $link)
                TextField("Add Photo", text: $photo)
                TextField("Item Name", text: $itemName)
                TextField("Price", text: $price)
            }
            else{
                Text("Choose Product Type to continue")
                    .presentationDetents([.large])

            }
            Spacer()
        }.padding(.top,80)
      


    }
}
        


#Preview {
    wishList()
}
