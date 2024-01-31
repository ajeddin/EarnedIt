//
//  OnboardingData.swift
//  EarnedIt
//
//  Created by Mohamed Midani on 1/30/24.
//

import Foundation



struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let objectImage: String
    let primaryText: String
    let secondaryText: String
    static let list: [OnboardingData] = [
        OnboardingData(id: 0, backgroundImage: "onboarding-bg-1", objectImage: "onboarding-object-1", primaryText: "About Us", secondaryText: "A fun way to complete tasks and reward yourself with guilt free shopping. 😎"),
        OnboardingData(id: 1, backgroundImage: "onboarding-bg-2", objectImage: "onboarding-object-2", primaryText: "Add Items", secondaryText: "Add items to your wishlist and work towards them by acummilating points that are awarded after completing tasks"),
        OnboardingData(id: 2, backgroundImage: "onboarding-bg-3", objectImage: "onboarding-object-3", primaryText: "Guilt Free", secondaryText: "Enjoy a guilt free item knowing you accomplished tasks and have EARNED IT :). A proven fun way to control impulsive shopping")
    ]
}
