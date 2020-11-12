//
//  OnboardingView.swift
//  Score1031
//
//  Created by Danting Li on 10/28/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var userData: UserData
    var body: some View {
      ZStack {
//      if self.userData.onboardingStage == "1" {
//      ZStack {
//        LinearGradient(gradient: Gradient(colors: [.mixedBlue, .mixedPurple]), startPoint: .topLeading, endPoint: .bottomTrailing)
//        VStack{
//        Text("Welcome to EmojiScoreBoard!")
//        Text("Please enable your Emoji keyboard in order to use this app. Here is how.")
//          Button(action: {
//            print("self.userData.onboardingStage \(self.userData.onboardingStage)")
//            self.userData.onboardingStage = "2"
//          }) {
//            Image(systemName: "arrow.right.circle")
//            .font(Font.system(size: 30, weight: .regular))
//            .foregroundColor(Color.darkPurple)
//          }
//
//        }
//      }.edgesIgnoringSafeArea(.all)
//      } else
        if self.userData.onboardingStage == "2" {
        OnboardingStage2()
      } else if self.userData.onboardingStage == "3" {
        OnboardingStage3()
      }
      }.onAppear() {
        self.userData.onboardingStage = "2"
      }
      }
    }


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingView()
    }
}
