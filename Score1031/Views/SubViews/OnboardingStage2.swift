//
//  OnboardingStage2.swift
//  Score1031
//
//  Created by Danting Li on 10/29/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct OnboardingStage2: View {
  @State var showSignInForm = false
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var userData: UserData
    var body: some View {
      ZStack {
        LinearGradient(gradient: Gradient(colors: [.mixedBlue, .mixedPurple]), startPoint: .topLeading, endPoint: .bottomTrailing)
        VStack{
        Text("Hello, Wooooorld!")
          
          Button(action: {
            print("self.userData.onboardingStage \(self.userData.onboardingStage)")
            self.userData.onboardingStage = "4"
          }) {
            Text("Sign up / Sign in")
          }
          
          Button(action: {
            print("self.userData.onboardingStage \(self.userData.onboardingStage)")
            self.userData.onboardingStage = "3"
          }) {
            Text("Sign in anonymously")
          }
        }
      }
    }
}

struct OnboardingStage2_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingStage2()
    }
}
