import SwiftUI

struct product: Identifiable, Hashable {
let id = UUID()
let name: String
}

struct AnotherView: View {
    let item: product
    var body: some View {
        Text(item.name)
    }
}

struct practice: View {
    @State var allItems: [product] = [.init(name: "Polos"), .init(name: "Stanley")]
    @State var Products: product?
    @State var redeemedItem: product?
    @State var confirmedPurchase = false
    @State var presentedItems: [product] = []

    var alertIsShowing: Binding<Bool> {
        Binding {
            Products != nil
        } set: { newValue in
            if let Products, confirmedPurchase {
                presentedItems.append(Products)
            }
            Products = nil
        }
    }
    
    var body: some View {
        NavigationStack(path: $presentedItems) {
            List(allItems) { item in
                Button(item.name) { Products = item }
            }
            .navigationDestination(for: product.self) { item in
                AnotherView(item: item)
            }
        }
        .alert("r u sure u want \(Products?.name ?? "") redeemed?", isPresented: alertIsShowing) {
            Button("NO!") { confirmedPurchase = false}
            Button("OK") { confirmedPurchase = true }        }
        
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        practice()
    }
}
