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
                   ForEach(OnboardingData.list, id: \.id) { viewData in
                       OnboardingView(data: viewData, currentPageIndex: $currentTab)
                           .tag(viewData.id)
                   }})
               .tabViewStyle(PageTabViewStyle())
               .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
           }
       }

#Preview {
    onboarding()
}
