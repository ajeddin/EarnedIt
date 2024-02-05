//
//  OnboardingView.swift
//  EarnedIt
//
//  Created by Mohamed Midani on 1/30/24.
//

import SwiftUI

//import SwiftUI
import SwiftData
struct OnboardingView: View {
    var data: OnboardingData
    @State private var isAnimating: Bool = false
//    @AppStorage("welcomeScreenShown")
//    var welcomeScreenShown: Bool = false;
    @Environment(\.modelContext) private var context
    @Query private var defaults: [UserDefault];
    @Binding var currentPageIndex: Int

    
    var body: some View {
        VStack(spacing: 20) {
       
            HStack{
                Spacer()
                if currentPageIndex != 2 {
                    Button("Skip",  action: {
                        let defaultUser = UserDefault(points: 0, onboardingViewed: true)
                        context.insert(defaultUser)
                        
                    }
                        
                    )
                    
                    .foregroundColor(.blue)
                    .edgesIgnoringSafeArea(.top)
                    .padding(.trailing, 40)
                    .padding(.top, 1)
                    
                }}

                       Image(data.objectImage)
                           .resizable()
                           .scaledToFit()
                           .offset(x: 0, y: 60)
                           .scaleEffect(isAnimating ? 1 : 0.9)


                   Spacer()
                   Spacer()

                   Text(data.primaryText)
//                       .font(.title2)
                .font(.system(size: 33))

                       .foregroundColor(Color("AccentColor"))
                       .bold()
//                       .foregroundColor(Color(red: 41 / 255, green: 52 / 255, blue: 73 / 255))
//                       .foregroundStyle(Color("primaryApp"))

                   Text(data.secondaryText)
                       .font(.headline)
                       .multilineTextAlignment(.center)
                       .frame(maxWidth: 250)
//                       .foregroundColor(Color.black)
                     

                   Spacer()
            if currentPageIndex == 2 {
                Button(action: {
                    let defaultUser = UserDefault(points: 0, onboardingViewed: true)
                    context.insert(defaultUser)
                }, label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(
                                    Color(
                                        red: 255 / 255,
                                        green: 202 / 255,
                                        blue: 47 / 255
                                    )
                                )
                        )
                })
                .shadow(radius: 7, x: 0, y: 2)

            }

                   Spacer()
               }
        .onAppear(perform: {
            isAnimating = false
            withAnimation(.easeOut(duration: 1.5)) {
                self.isAnimating = true
            }
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(data: OnboardingData.list.first!, currentPageIndex: .constant(0))
//            .environmentObject(OnboardingPageManager())
    }
}





//
//#Preview {
//    OnboardingView(data: )
//}
