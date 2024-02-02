//
//  modals.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/31/24.
//

import Foundation
import SwiftData

@Model
class Products : Identifiable{
    var id:String = " ";
    var imageURL:String = " ";
    var productName:String = " ";
    var price:Float = 0.0;
    var rating:String = " ";
    var isRedeemed : Bool = false
//    var id:String?;
//    var imageURL:String?;
//    var productName:String?;
//    var price:Float?;
//    var rating:String?;
    init(imageURL: String, productName: String, price: Float, rating: String) {
        self.id = UUID().uuidString
        self.imageURL = imageURL
        self.productName = productName
        self.price = price
        self.rating = rating
        self.isRedeemed = false
    }

}



@Model
class Tasks : Identifiable{
    var taskText: String = ""
    var taskPoints: Int = 0
    var isFav : Bool = false
    var isChecked: Bool = false
    
    init(taskText: String, taskPoints: Int) {
        self.taskText = taskText
        self.taskPoints = taskPoints
        self.isFav = false
        self.isChecked = false
    }
    
    

    
}
