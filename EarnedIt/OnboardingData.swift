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
        OnboardingData(id: 0, backgroundImage: "onboarding-bg-1", objectImage: "onboarding-object-1", primaryText: "Earned It", secondaryText: "A fun and easy way to manage your wishlist, complete tasks, and reward yourself with guilt free shopping!"),
        OnboardingData(id: 1, backgroundImage: "onboarding-bg-2", objectImage: "onboarding-object-2", primaryText: "Add Items", secondaryText: "Add items to your wishlist, once enough tasks have been completed, you’ll be able to redeem your task points for a guilt free purchase"),
        OnboardingData(id: 2, backgroundImage: "onboarding-bg-3", objectImage: "onboarding-object-3", primaryText: "Guilt Free", secondaryText: "You can enjoy your purchases even more now, knowing that you have accomplished tasks and have Earned It! A fun way to control impulsive shopping. ")
    ]
}
