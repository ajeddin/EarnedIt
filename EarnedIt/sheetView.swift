//
//  sheetView.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 2/1/24.
//

import SwiftUI
import SwiftData
extension Formatter {
    static let lucNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}

struct wishListSheet: View{
    @Environment(\.modelContext) private var context
    @State var link: String = "";
    @State var photo: String = "";
    @State var itemName: String = "";
    @State var amazonBool : Int = 0;
    @State var response : String = "";
    @State var price : Int = 0
//    @State var isValidLink : Bool = false
    let haptic = UINotificationFeedbackGenerator()
    let haptic2 = UIImpactFeedbackGenerator(style: .heavy)

    
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
                VStack{
                    HStack{
                        TextField("Paste Link Here", text: $link).disableAutocorrection(true)
                        PasteButton(payloadType: String.self) { strings in
                            link = strings[0]
                        }}
                    TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat)
                    
                }.padding(25)
                
                Button(action: {
                    if (price <= 0){
                        haptic.notificationOccurred(.error)
                    }else{
                        haptic.notificationOccurred(.success)

                        if let range = link.range(of: "https") {
                            var result = String(link[range.lowerBound...])
                            result = result.trimmingCharacters(in: .whitespacesAndNewlines)
                            link = result
                            dismiss()

                            //                        print(result)
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
                                            let product = Products(imageURL: response.0, productName: response.2.components(separatedBy: " ").prefix(5).joined(separator: " "), price: price, productLink: response.1)
                                            context.insert(product)
                                            try? context.save()

                                        case .failure(let error):
                                            print("Error: \(error)")
                                        }
                                    }
                                    
                                case .failure(let error):
                                    print("Error: \(error)")
                                }
                            }
                        }}
                    
                }) {

                    Text("Done").foregroundColor(Color("AccentColor"))
            }
  
                
            }
            else if(amazonBool==2){
                VStack{
                    TextField("Enter Product Name", text: $itemName).disableAutocorrection(true)

                    HStack{

                        TextField("Paste Product Link Here", text: $link).disableAutocorrection(true)
                        PasteButton(payloadType: String.self) { strings in
                            link = strings[0]
                        }}
                    TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat)    .keyboardType(.numberPad)

                    
                }.padding(25)
                Button{
                    if (itemName.isEmpty || price <= 0){
                        haptic.notificationOccurred(.error)

                    }
                    else{
                        haptic.notificationOccurred(.success)
                        let product = Products(imageURL: "https://img.freepik.com/free-photo/cardboard-box_144627-20326.jpg?w=1480&t=st=1707146075~exp=1707146675~hmac=dd95c4723f0a52fee3a5b590d4e8c16b8c10fb4ced4cd19af3932bc0aa5510e5", productName: itemName, price: price, productLink: link)
                        context.insert(product)
                        try? context.save()
                        dismiss()

                    }
                } label: {Text("Done")}
            }
           
            else{
                
                VStack(alignment: .center){
                    Spacer()

                    Image("noProducts").resizable().scaledToFit().frame(width: 100)
//                    Text("Create your wishlist")
                    Text("Choose Product Type To Continue ").padding(.top,5).foregroundColor(Color("ForegroundColor")).bold()
                    Spacer()

                }
            }
            Spacer()
        }.padding(.top,20)
      


    }
}
        

#Preview {
    wishListSheet()
}

