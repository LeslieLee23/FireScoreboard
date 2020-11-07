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
    
    var body: some View {
      ZStack {
//        LinearGradient(gradient: Gradient(colors: [.mixedBlue, .mixedPurple]), startPoint: .topLeading, endPoint: .bottomTrailing)
        VStack{
        Text("Welcome to EmojiScoreBoard!")
          
            SignInWithAppleButton()
              .frame(width: 260, height: 45)
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
            Text("Sign in anonymously")
          }
        Text("* You can sign in with Apple later")
        }
      }
    }
}

struct OnboardingStage2_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingStage2()
    }
}
