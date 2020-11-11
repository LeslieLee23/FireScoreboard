//
//  OnboardingStage2.swift
//  Score1031
//
//  Created by Danting Li on 10/29/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OnboardingStage2: View {

  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var userData: UserData
  @State var coordinator: SignInWithAppleCoordinator?
  @EnvironmentObject var appState: AppState
  @State var showAlert = false
  @State var localizdDescription = ""
  @State var newUser = false
  
    var body: some View {
      ZStack {
        VStack{
          Spacer()
          VStack(alignment: .center) {
          RadialGradient(gradient: Gradient(colors: [.mixedBlue, .mixedPurple]), center: .center, startRadius: 10, endRadius: 200)
            .frame(width: 300, height: appState.TitleRowHeight, alignment: .trailing)
            .mask(
        Text("Welcome to EmojiScoreBoard!")
          .font(.system(size: 22))
          .fontWeight(.medium)
          )
          .padding()
          }
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
                  print("Auth.auth().currentUser?.uid \(String(describing: Auth.auth().currentUser?.uid))")
                    self.userData.signedInWithApple = true
                    self.userData.userUid = Auth.auth().currentUser?.uid ?? ""
                  print("self.userData.userUid \(String(describing: self.userData.userUid))")
                  
                  //*******************
                  let db = Firestore.firestore()
                  db.collection("records")
                    .whereField("userId", isEqualTo: self.userData.userUid ?? "0")
                      .addSnapshotListener {(querySnapshot, error) in
                        guard (querySnapshot?.documents) != nil else {
                        print("No documents")
                        self.newUser = true
                        return
                      }
                      }
                  //*******************
                  
                  if self.newUser == true {
                    self.userData.onboardingStage = "3"
                  } else {
                    self.viewRouter.currentPage = "tabBarView"
                  }
                }
                }
            }
          
          Button(action: {
            Auth.auth().signInAnonymously { (user, err) in
                if let err = err {
                  self.localizdDescription = err.localizedDescription
                    self.showAlert = true
                    print("failed to sign in anonymously with error", err)
                }
                self.userData.signedInWithApple = false
                self.userData.userUid = (user?.user.uid)!
              print("Successfully sigined in anonymously with uid", user?.user.uid ?? "No uid")
              print("Successfully sigined in anonymously with userData.userUid", self.userData.userUid ?? "No uid")
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
          .alert(isPresented: $showAlert) { () ->
            Alert in
            return Alert(title: Text("Sign In Error"), message: Text(self.localizdDescription), dismissButton: Alert.Button.default(Text("Ok"))
            {
              }
            )
            
          }
          
        Text("* You can sign in with Apple later")
          .font(.system(size: 13))
          
          Spacer()
        }
      }.onAppear {
        print("Auth.auth().currentUser?.uid trouble shoot \(String(describing: Auth.auth().currentUser?.uid))")
        if Auth.auth().currentUser == nil {
          Auth.auth().signInAnonymously()
        }
        print("Auth.auth().currentUser?.uid trouble shoot \(String(describing: Auth.auth().currentUser?.uid))")
      }
    }
}

struct OnboardingStage2_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingStage2()
        .environmentObject(AppState())
    }
}
