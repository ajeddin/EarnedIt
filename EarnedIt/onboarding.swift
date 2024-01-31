//
//  onboarding.swift
//  EarnedIt
//
//  Created by Mohamed Midani on 1/30/24.
//

import SwiftUI

struct onboarding: View {
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(OnboardingData.list.indices) { index in
                OnboardingView(data: OnboardingData.list[index], currentPageIndex: $currentTab)
                    .tag(index)
            }})
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    onboarding()
}
