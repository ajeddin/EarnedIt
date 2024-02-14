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
import LinkPresentation
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



//struct LinkViewWrapper: UIViewRepresentable {
//    let linkView: LPLinkView
//
//    func makeUIView(context: Context) -> UIView {
//        return linkView
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // Implement any updates if needed
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
    
    let haptic = UINotificationFeedbackGenerator()

    @Environment(\.modelContext) private var context
    var extentionContext: NSExtensionContext?
    var itemProvider : [NSItemProvider]
    @State var price : Int = 0
    @State var link: String = ""
    @State var isAmazLink = false
    @State var title: String = ""
    @FocusState private var fieldIsFocused: Bool

  
    var body: some View{
        VStack{
            HStack(alignment: .bottom) {
              Spacer()
                Button{
                    extentionContext!.completeRequest(returningItems: [])

                }label:{
                    Image(systemName: "xmark.circle").foregroundColor(Color("ForegroundColor") ).font(.title)
                }
            }
                VStack{
                  
                    HStack{
                        Text(link.prefix(1 + link.split(separator: "/").prefix(4).map { $0.count }.reduce(0, +))).foregroundColor(Color("ForegroundColor") )
                        
//                        let linkView  = fetchPreview(url: link)
//                        LinkViewWrapper(linkView: fetchPreview(url: link)).frame(width: 150,height: 50)   
                    }
                    TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat).keyboardType(.numberPad).foregroundColor(Color("ForegroundColor") )
                        .focused($fieldIsFocused)
                    
                }
                .padding(25)
                
//                    .background(Color.white.opa city(0.7))
                
            
            Button{
                if (price <= 0){
                                    haptic.notificationOccurred(.error)
                }else{
                                    haptic.notificationOccurred(.success)

                    print(link)
                    
                    if ( (link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com") ) && link.count > 30){
                        getRealImage(url: URL(string:link)!) { result in
                            
                            switch result {
                            case .success(let response):
                                getProductImage(url: URL(string:response)!) { result in
                                    
                                    switch result {
                                    case .success(let response):
                                        let product = Products(imageURL: response.0, productName: response.2.components(separatedBy: " ").prefix(5).joined(separator: " "), price: price, productLink: response.1)
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
                        Task {
                            print(link)
                            do {
                                                let response = try await getProductTitleName(url: URL(string: link)!)
                                                print(response.0)
                                let product = Products(imageURL: "", productName: response.0.components(separatedBy: " ").prefix(5).joined(separator: " "), price: price, productLink: link)
                                                context.insert(product)
                                                try? context.save()
                                
                                // Handle the response as needed
                                            } catch {
                                                print("Error fetching data: \(error)")
                                            }
                                        }
                        extentionContext!.completeRequest(returningItems: [])

                    }
                }
            
            } label: {Text("Done").foregroundColor(Color("ForegroundColor"))
            }.buttonStyle(.borderedProminent)

            
            
            
            
        }
            .onAppear(perform: {
            extract()
            
            
            }).padding(20)
            .background(Color("BackgroundColor")).cornerRadius(25)
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




////
////  ShareViewController.swift
////  EarnedItShare
////
////  Created by Abdulaziz Jamaleddin on 2/7/24.
////
//
//import UIKit
//import Social
//import SwiftData
//import SwiftUI
//class ShareViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        isModalInPresentation = true
//        if let items = (extensionContext!.inputItems.first as? NSExtensionItem)?.attachments{
//            let hostingView = UIHostingController(rootView: SheetView(extentionContext: extensionContext,itemProvider: items).background(Color.clear).modelContainer(for: [Products.self,Tasks.self,UserChoices.self]))
//            hostingView.view.frame = view.frame
//            view.addSubview(hostingView.view)
//            hostingView.view.backgroundColor = .clear
//        }
//  
//        
//        
//    }
//
//}
//extension Formatter {
//    static let lucNumberFormat: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .none
//        formatter.zeroSymbol  = ""     // Show empty string instead of zero
//        return formatter
//    }()
//}
//fileprivate struct  SheetView: View {
//    
//    let haptic = UINotificationFeedbackGenerator()
//
//    @Environment(\.modelContext) private var context
//    var extentionContext: NSExtensionContext?
//    var itemProvider : [NSItemProvider]
//    @State var price : Int = 0
//    @State var link: String = ""
//    @State var isAmazLink = false
//    @State var title: String = ""
//
//    var body: some View{
//        VStack{
//            if (link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com")){
//                VStack{
//                    HStack{
//                        Text(link)
//                    }
//                    TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat).keyboardType(.numberPad)
//                    
//                }.padding(25)
////                    .background(Color.white.opa city(0.7))
//                
//                
//                
//            }
//            else /*(!link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com"))*/{
//                VStack{
//                    TextField("Enter Title", text: $title).autocorrectionDisabled()
//                        Text(link)
//                
//                    TextField("Enter Price", value: $price, formatter: Formatter.lucNumberFormat).keyboardType(.numberPad)
//                    
//                }.padding(25)
////                    .background(Color.white.opacity(0.7))
//                
//                
//            }
//            
//            Button{
//                if (price <= 0){
//                                    haptic.notificationOccurred(.error)
//                }else{
//                                    haptic.notificationOccurred(.success)
//
//                    print(link)
//                    
//                    if (link.hasPrefix("https://a.co") || link.hasPrefix("https://www.amazon.com")){
//                        getRealImage(url: URL(string:link)!) { result in
//                            
//                            switch result {
//                            case .success(let response):
//                                getProductImage(url: URL(string:response)!) { result in
//                                    
//                                    switch result {
//                                    case .success(let response):
//                                        let product = Products(imageURL: response.0, productName: response.2.components(separatedBy: " ").prefix(5).joined(separator: " "), price: price, productLink: link)
//                                        saveItem(product: product)
//                                        extentionContext!.completeRequest(returningItems: [])
//                                        
//                                        
//                                    case .failure(let error):
//                                        print("Error: \(error)")
//                                    }
//                                }
//                                
//                            case .failure(let error):
//                                print("Error: \(error)")
//                            }
//                        }
//                        
//                    }
//                    else{
//                        let product = Products(imageURL: "", productName: title, price: price, productLink: link)
//                        saveItem(product: product)
//                        extentionContext!.completeRequest(returningItems: [])
//                    }
//                }
//            
//            } label: {Text("Done")}.buttonStyle(.borderedProminent)
//
//            
//            
//            
//            
//        }
//            .onAppear(perform: {
//            extract()
//            
//            
//        })
//            .background(Color("ForegroundColor"))
//    }
//
//    
//    func extract(){
//        DispatchQueue.global(qos: .userInteractive).async{
//            for provider in itemProvider {
//                provider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (attachment, error) in
//                    if let url = attachment as? URL{
//                        var urlText = url.absoluteString
//                        if let range = urlText.range(of: "https") {
//                            var result = String(urlText[range.lowerBound...])
//                            result = result.trimmingCharacters(in: .whitespacesAndNewlines)
//                            urlText = result
//                           
//
//                        }
//                                                DispatchQueue.main.async {
//                        
//                        link = urlText
//                                                
//                        print(link)
//                    }
//                }
//                    
//                })
//            }
//            
//        }}
//    func saveItem(product : Products){
//        do{
//            context.insert(product)
//            try context.save()
//        }catch{
//            print(error.localizedDescription)
//        }
//        
//        
//    }
//}
//
