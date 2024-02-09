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
            let hostingView = UIHostingController(rootView: SheetView(extentionContext: extensionContext,itemProvider: items).modelContainer(for: [Products.self,Tasks.self,UserChoices.self]))
            hostingView.view.frame = view.frame
            view.addSubview(hostingView.view)
        }
  
        
        
    }

}
//extension URL {
//    init(_ string: String) {
//        self.init(string: "\(string)")!
//    }
//}
extension Formatter {
    static let lucNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}
fileprivate struct  SheetView: View {
    
     
    @Environment(\.modelContext) private var context
//    @Environment(\.modelContext) private var context

    var extentionContext: NSExtensionContext?
    var itemProvider : [NSItemProvider]
    @State var price : Int = 0
//    @State var unwrappedURL = URL("https://www.google.com")
    @State var link: String = ""
  
    var body: some View{


        VStack{
            HStack{
//                TextField("Paste Link Here", text: $link).disableAutocorrection(true)
                Text(link)
               }
            TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat)
            
        }.onAppear(perform: {
            extract()


        }).padding(25)
//        let context = try! ModelContext(.init(for: Products.self))

        Button{
            if (price <= 0){
//                haptic.notificationOccurred(.error)
            }else{
                //                haptic.notificationOccurred(.success)
                //                extentionContext!.completeRequest(returningItems: [], completionHandler: nil)
                if let range = link.range(of: "https") {
                    var result = String(link[range.lowerBound...])
                    result = result.trimmingCharacters(in: .whitespacesAndNewlines)
                    link = result
                    
                }
                if link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com") {
                    
                    
                    getRealImage(url: URL(string:link)!) { result in
                        
                        switch result {
                        case .success(let response):
                            
                            //                            print("Image URL:  \(response)")
                            getProductImage(url: URL(string:response)!) { result in
                                
                                switch result {
                                case .success(let response):
                                    let product = Products(imageURL: response.0, productName: response.2.components(separatedBy: " ").prefix(5).joined(separator: " "), price: price, productLink: link)
                                    saveItem(product: product)
                                    extentionContext!.completeRequest(returningItems: [], completionHandler: nil)
                                    
                                    
                                case .failure(let error):
                                    print("Error: \(error)")
                                }
                            }
                            
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                    //                extentionContext!.completeRequest(returningItems: [], completionHandler: nil)
                    
                    
                    
                }
                else{
                    extentionContext!.completeRequest(returningItems: [], completionHandler: nil)

                }}
            
        } label: {Text("Done")}
       
    }
    
    func extract(){
        DispatchQueue.global(qos: .userInteractive).async{
            for provider in itemProvider {
                provider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (attachment, error) in
                    if let url = attachment as? URL{
                        //                        print(data)
                        //                        {
                        let urlText = url.absoluteString
                                                DispatchQueue.main.async {
                        link = urlText
                        print(link)
//                        extentionContext!.completeRequest(returningItems: [], completionHandler: nil)
                        
                    }
                }
                    
                })
            }
            
            
            //               extentionContext!.completeRequest(returningItems: [], completionHandler: nil)
            
            
        }}
    func saveItem(product : Products){
//        var link = links
        
        do{
            
//            let cont ainer = modelContainer(for: [Products.self, Tasks.self, UserChoices.self])
//            let container =  modelContainer(for: [Products.self,Tasks.self,UserChoices.self])
//            let context = try ModelContext(.init(for: Products.self))


            context.insert(product)
            try context.save()

        
        }catch{
            print(error.localizedDescription)
//            dismiss()
            
        }
        
        
    }
}
