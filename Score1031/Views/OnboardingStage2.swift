//
//  OnboardingStage2.swift
//  Score1031
//
//  Created by Danting Li on 10/29/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OnboardingStage2: View {
  @State var showSignInForm = false
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var userData: UserData
  @State var coordinator: SignInWithAppleCoordinator?
  @EnvironmentObject var appState: AppState
    
    var body: some View {
      ZStack {
//        LinearGradient(gradient: Gradient(colors: [.mixedBlue, .mixedPurple]), startPoint: .topLeading, endPoint: .bottomTrailing)
        VStack{
          Spacer()
          RadialGradient(gradient: Gradient(colors: [.mixedBlue, .mixedPurple]), center: .center, startRadius: 10, endRadius: 200)
            .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .trailing)
            .mask(
        Text("Welcome to EmojiScoreBoard!")
          .font(.system(size: 22))
          .fontWeight(.medium)
          )
          .padding()
          Spacer()
          Spacer()
            SignInWithAppleButton()
              .frame(width: 260, height: 45)
              .padding(.bottom, 10)
              .onTapGesture {
                self.coordinator = SignInWithAppleCoordinator()
                if let coordinator = self.coordinator {
                coordinator.startSignInWithAppleFlow {
                  print("You successfully signed in")
                    self.userData.signedInWithApple = true
                    self.userData.onboardingStage = "3"
                }
                }
            }
          
          Button(action: {
            Auth.auth().signInAnonymously { (user, err) in
                if let err = err {
                    print("failed to sign in anonymously with error", err)
                }
                self.userData.signedInWithApple = false
                self.userData.userUid = (user?.user.uid)!
                print("Successfully sigined in anonymously with uid", user?.user.uid)
                print("Successfully sigined in anonymously with userData.userUid", self.userData.userUid)
            }
            self.userData.onboardingStage = "3"
          }) {
            RoundedRectangle(cornerRadius: 6)
              .fill(Color.signInGray)
              .frame(width: 260, height: 43)
              .overlay(
                Text("Sign in Anonymously")
                  .foregroundColor(Color.black)
            )
            
          }
        Text("* You can sign in with Apple later")
          .font(.system(size: 13))
          
          Spacer()
        }
      }
    }
}

struct OnboardingStage2_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingStage2()
        .environmentObject(AppState())
    }
}
