//
//  ShareViewController.swift
//  EarnedItShare
//
//  Created by Abdulaziz Jamaleddin on 2/7/24.
//

import UIKit
import Social
import SwiftData
import SwiftUI
class ShareViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        isModalInPresentation = true
        if let items = (extensionContext!.inputItems.first as? NSExtensionItem)?.attachments{
            let hostingView = UIHostingController(rootView: SheetView(extentionContext: extensionContext,itemProvider: items).background(Color.clear).modelContainer(for: [Products.self,Tasks.self,UserChoices.self]))
            hostingView.view.frame = view.frame
            view.addSubview(hostingView.view)
            hostingView.view.backgroundColor = .clear
        }
  
        
        
    }

}
extension Formatter {
    static let lucNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}
fileprivate struct  SheetView: View {
    
    let haptic = UINotificationFeedbackGenerator()

    @Environment(\.modelContext) private var context
    var extentionContext: NSExtensionContext?
    var itemProvider : [NSItemProvider]
    @State var price : Int = 0
    @State var link: String = ""
    @State var isAmazLink = false
    @State var title: String = ""

    var body: some View{
        VStack{
            if (link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com")){
                VStack{
                    HStack{
                        Text(link)
                    }
                    TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat).keyboardType(.numberPad)
                    
                }.padding(25)
//                    .background(Color.white.opa city(0.7))
                
                
                
            }
            else /*(!link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com"))*/{
                VStack{
                    TextField("Enter Title", text: $title).autocorrectionDisabled()
                        Text(link)
                
                    TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat).keyboardType(.numberPad)
                    
                }.padding(25)
//                    .background(Color.white.opacity(0.7))
                
                
            }
            
            Button{
                if (price <= 0){
                                    haptic.notificationOccurred(.error)
                }else{
                                    haptic.notificationOccurred(.success)

                    print(link)
                    
                    if (link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com")){
                        getRealImage(url: URL(string:link)!) { result in
                            
                            switch result {
                            case .success(let response):
                                getProductImage(url: URL(string:response)!) { result in
                                    
                                    switch result {
                                    case .success(let response):
                                        let product = Products(imageURL: response.0, productName: response.2.components(separatedBy: " ").prefix(5).joined(separator: " "), price: price, productLink: link)
                                        saveItem(product: product)
                                        extentionContext!.completeRequest(returningItems: [])
                                        
                                        
                                    case .failure(let error):
                                        print("Error: \(error)")
                                    }
                                }
                                
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                        
                    }
                    else{
                        let product = Products(imageURL: "https://img.freepik.com/free-photo/cardboard-box_144627-20326.jpg?w=1480&t=st=1707146075~exp=1707146675~hmac=dd95c4723f0a52fee3a5b590d4e8c16b8c10fb4ced4cd19af3932bc0aa5510e5", productName: title, price: price, productLink: link)
                        saveItem(product: product)
                        extentionContext!.completeRequest(returningItems: [])
                    }
                }
            
            } label: {Text("Done")}.buttonStyle(.borderedProminent)

            
            
            
            
        }
            .onAppear(perform: {
            extract()
            
            
        })
            .background(Color("ForegroundColor"))
    }

    
    func extract(){
        DispatchQueue.global(qos: .userInteractive).async{
            for provider in itemProvider {
                provider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (attachment, error) in
                    if let url = attachment as? URL{
                        var urlText = url.absoluteString
                        if let range = urlText.range(of: "https") {
                            var result = String(urlText[range.lowerBound...])
                            result = result.trimmingCharacters(in: .whitespacesAndNewlines)
                            urlText = result
                           

                        }
                                                DispatchQueue.main.async {
                        
                        link = urlText
                                                
                        print(link)
                    }
                }
                    
                })
            }
            
        }}
    func saveItem(product : Products){
        do{
            context.insert(product)
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
}

