//
//  OnboardingView.swift
//  EarnedIt
//
//  Created by Mohamed Midani on 1/30/24.
//

import SwiftUI

struct OnboardingView: View {
    var data: OnboardingData
    @State private var isAnimating: Bool = false

    
    var body: some View {
        VStack(spacing: 20) {
                   ZStack {
//                       Image(data.backgroundImage)
//                           .resizable()
//                           .scaledToFit()

                       Image(data.objectImage)
                           .resizable()
                           .scaledToFit()
                           .offset(x: 0, y: 60)
                           .scaleEffect(isAnimating ? 1 : 0.9)

                   }

                   Spacer()
                   Spacer()

                   Text(data.primaryText)
                       .font(.title2)
                       .bold()
                       .foregroundColor(Color(red: 41 / 255, green: 52 / 255, blue: 73 / 255))

                   Text(data.secondaryText)
                       .font(.headline)
                       .multilineTextAlignment(.center)
                       .frame(maxWidth: 250)
                       .foregroundColor(Color.black)
                       //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 2)

                   Spacer()

                   Button(action: {
                       // Add action for button
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
        OnboardingView(data: OnboardingData.list.first!)
    }
}
//
//#Preview {
//    OnboardingView(data: )
//}
