//
//  EarnedItApp.swift
//  EarnedIt
//
//  Created by Abdulaziz Jamaleddin on 1/30/24.
//

import SwiftUI
import SwiftData
@main
struct EarnedItApp: App {
    
//    var container: ModelContainer
//
//        init() {
//            do {
//                let config1 = ModelConfiguration(for: Products.self)
////                let config2 = ModelConfiguration(for: Test.self)
//                
//
////                container = try ModelContainer(for: Products.self, Test.self, configurations: config1, config2)
//                container = try ModelContainer(for: Products.self, configurations: config1)
//
////                print(URL.applicationSupportDirectory.path(percentEncoded: false))
//            } catch {
//                fatalError("Failed to configure SwiftData container.")
//            }
//        }
    

    var body: some Scene {
        WindowGroup {
            viewController()
        }.modelContainer(for: [Products.self,Test.self])
//        .modelContainer(container)
    }
}
