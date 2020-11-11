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
  @ObservedObject var apiLoader = APILoader()
  @ObservedObject var userLoader = UserLoader()
  @State var records = [Recordline]()

  
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
                  
                 
                  
                  self.showAlert = true
                  

                  //*******************
                  print("Over Over Over")
                }
                }
            }
            .alert(isPresented: $showAlert) { () ->
              Alert in
              return Alert(title: Text("Login successful! 😉"), message: Text(""), dismissButton: Alert.Button.default(Text("Ok"))
              {
                let db = Firestore.firestore()
                db.collection("records")
                  .whereField("userId", isEqualTo: Auth.auth().currentUser?.uid ?? "0")
                  .addSnapshotListener {(querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                      print("No documents")
                      return
                    }
                    records = documents.map {(queryDocumentSnapshot) -> Recordline in
                      let data = queryDocumentSnapshot.data()
                      
                      let userId = data["userId"] as? String ?? ""
                      let id = data["id"] as? String ?? ""
                      let playerID = data["playerID"] as? String ?? ""
                      let playerOneEmoji = data["playerOneEmoji"] as? String ?? ""
                      let playerOneName = data["playerOneName"] as? String ?? ""
                      let playerOneScore = data["playerOneScore"] as? Int ?? 0
                      let playerTwoEmoji = data["playerTwoEmoji"] as? String ?? ""
                      let playerTwoName = data["playerTwoName"] as? String ?? ""
                      let playerTwoScore = data["playerTwoScore"] as? Int ?? 0
                      let recordName = data["recordName"] as? String ?? ""
                      let recordScore = data["recordScore"] as? String ?? ""
                      let recordReason = data["recordReason"] as? String ?? ""
                      let timestamp: Timestamp = data["recordEntryTime"] as! Timestamp
                      let recordEntryTime: Date = timestamp.dateValue()
                      // let recordEntryTime = data["recordEntryTime"] as? Date??
                      let recordEntryTimeString = data["recordEntryTimeString"] as? String ?? ""
                      let recordNameStr = data["recordNameStr"] as? String ?? ""
                      let recordNameEmo = data["recordNameEmo"] as? String ?? ""
                      let abc = Recordline(
                        id: id,
                        playerID: playerID,
                        playerOneEmoji: playerOneEmoji,
                        playerOneName: playerOneName,
                        playerOneScore: playerOneScore,
                        playerTwoEmoji: playerTwoEmoji,
                        playerTwoName: playerTwoName,
                        playerTwoScore: playerTwoScore,
                        
                        recordName: recordName,
                        recordScore: recordScore,
                        recordReason: recordReason,
                        recordEntryTime: recordEntryTime,
                        recordEntryTimeString: recordEntryTimeString,
                        userId: userId,
                        recordNameStr: recordNameStr,
                        recordNameEmo: recordNameEmo
                      )
                      print("abc ######\(abc)")
                      self.records.append(abc)
                      print("self.records.append \(self.records)")
                      return abc
                    }.sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})
                    
                    print("self.records After: \(self.records)")
                    
                    self.newUser = records.isEmpty ? true : false
                    
                    if self.newUser == true {
                      self.userData.onboardingStage = "3"
                    } else {
                      self.viewRouter.currentPage = "tabBarView"
                    }
                  } /// need to put code inside here
                
                
                
              }
              )
              
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
