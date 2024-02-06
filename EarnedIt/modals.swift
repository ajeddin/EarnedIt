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
    var id : String?
    var imageURL:String = " ";
    var productName:String = " ";
    var price:Int = 0;
    var isRedeemed : Bool = false
    var productLink : String = ""
//    var id:String?;
//    var imageURL:String?;
//    var productName:String?;
//    var price:Float?;
//    var rating:String?;
    init(imageURL: String, productName: String, price: Int, productLink: String) {
        self.id = UUID().uuidString
        self.imageURL = imageURL
        self.productName = productName
        self.price = price
        self.isRedeemed = false
        self.productLink = productLink
    }

}



@Model
class Tasks : Identifiable{
    var id : String = ""

    var taskText: String = ""
    var taskPoints: Int = 0
    var isFav : Bool = false
    var isChecked: Bool = false
    
    init(taskText: String, taskPoints: Int) {
        self.id = UUID().uuidString

        self.taskText = taskText
        self.taskPoints = taskPoints
        self.isFav = false
        self.isChecked = false
    }
    
    

    
}

@Model
class UserChoices: Identifiable{
    var id : String = ""

    var points:Int = 0
    var onboardingViewed: Bool = false
    init(points: Int, onboardingViewed: Bool) {
        self.id = UUID().uuidString
        self.points = points
        self.onboardingViewed = onboardingViewed
    }
    
}
