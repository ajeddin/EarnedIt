//
//  sheetView.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 2/1/24.
//

import SwiftUI


struct wishListSheet: View{
    @Environment(\.modelContext) private var context
    @State var link: String = "";
    @State var photo: String = "";
    @State var itemName: String = "";
    @State var price: String = "";
    @State var amazonBool : Int = 0;
    @State var response : String = "";
//    @State var isValidLink : Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View{
        
        VStack {
            Picker("What is your favorite color?", selection: $amazonBool) {
                Text("Amazon Product").tag(1)
                Text("Non-Amazon Product").tag(2)
            }
            .pickerStyle(.segmented)
            
            if (amazonBool==1){
//                Text("Please paste amazon link here:")
                HStack{
                    TextField("Paste Link Here", text: $link).disableAutocorrection(true)
                    PasteButton(payloadType: String.self) { strings in
                        link = strings[0]
                    }}.padding(20)
                
                Button(action: {
                    if let range = link.range(of: "https") {
                        var result = String(link[range.lowerBound...])
                        result = result.trimmingCharacters(in: .whitespacesAndNewlines)
                        link = result
//                        print(result)
                        dismiss()
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
                                    let product = Products(imageURL: response.0, productName: response.2.components(separatedBy: " ").prefix(6).joined(separator: " "), price: 90.0, rating: response.1)
                                    context.insert(product)
       
                                case .failure(let error):
                                    print("Error: \(error)")
                                }
                            }
                            
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                }
                    
                }) {
//                Image(systemName: "plus")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 19, height: 19)
//                    .foregroundColor(Color("AccentColor"))
//                    .padding(15)
//                    .background(Color.white)
//                    .clipShape(Circle())
                    Text("Done").foregroundColor(Color("AccentColor"))
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
    wishListSheet()
}

