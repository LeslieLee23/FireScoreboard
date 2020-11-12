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
  @State var userDataExist = false
  @ObservedObject var apiLoader = APILoader()
  @ObservedObject var userLoader = UserLoader()
  @State var records = [Recordline]()
  @State var users = [UserRecord]()
  @State var mostRecentRecord = Recordline(playerID: "0", playerOneEmoji: "👩🏻", playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "👩🏻", recordReason: "Default players created!", recordEntryTime: Date(), recordEntryTimeString: getDateString(Date: Date()), recordNameStr: "Welcome!", recordNameEmo: "👨🏻")
  @State var fetchedUser = UserRecord(id: "0", userId: "0", userEmoji: "userEmoji", userName: "userName", userCreateTime: Date())
  
  @State var message = ""
  @State var alertTitle = "Login successful! 😉"
  
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
                  print("Apple button userUid \(String(describing: self.userData.userUid))")
                  
                  //*******************
                  
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
                        return abc
                      }.sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})
                      
                      print("records After: \(records)")
                      
                      self.newUser = records.isEmpty ? true : false
                      
                      if records.isEmpty {
                        self.message = "Your account has been succesfully created!"
                        self.alertTitle = "Welcome! 🎉"
                      } else {
                        self.message = "Welcome back 😉"
                        self.alertTitle = "Login successful!"
                        self.mostRecentRecord = records[0]
                        print("mostRecentRecord \(self.mostRecentRecord)")
                      }
                      
                      
                    } /// need to put code inside here
                  
                  //*******************
                  
                  db.collection("user")
                    .whereField("id", isEqualTo: Auth.auth().currentUser?.uid ?? "0")
                    .addSnapshotListener {(querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                      print("didn't find userid \(String(describing: Auth.auth().currentUser?.uid))) in firebase")
                      return
                    }
                      users = documents.map {(queryDocumentSnapshot) -> UserRecord in
                      let data = queryDocumentSnapshot.data()
                      
                      let id = data["id"] as? String ?? "no id"
                      let userId = data["userId"] as? String ?? "no userID"
                      let userEmoji = data["userEmoji"] as? String ?? "no userEmoji"
                      let userName = data["userName"] as? String ?? "no userName"
                      let timestamp: Timestamp = data["userCreateTime"] as! Timestamp
                      let userCreateTime: Date = timestamp.dateValue()
                      
                      let abc = UserRecord(
                                id: id,
                                userId: userId,
                                userEmoji: userEmoji,
                                userName: userName,
                                userCreateTime: userCreateTime
                      )
                      
                      return abc
                    }.sorted(by: { $0.userCreateTime! >= $1.userCreateTime!})
                      
                      self.userDataExist = users.isEmpty ? false : true
                      
                      if self.userDataExist == true {
                        self.fetchedUser = users[0]
                        print("fetchedUser \(self.fetchedUser)")
                      } else {
                        self.fetchedUser.id = Auth.auth().currentUser?.uid ?? "0"
                        self.fetchedUser.userId = Auth.auth().currentUser?.uid ?? "0"
                        self.fetchedUser.userEmoji = self.mostRecentRecord.playerOneEmoji
                        self.fetchedUser.userName = self.mostRecentRecord.playerOneName
                      }
                  
                  }

                  
                  self.showAlert = true
                  

                  //*******************
                 
                }
                }
            }
            .alert(isPresented: $showAlert) { () ->
              Alert in
              return Alert(title: Text(self.alertTitle), message: Text(self.message), dismissButton: Alert.Button.default(Text("Ok"))
              {
                print("self.newUser \(self.newUser)")
                if self.newUser == true {
                  self.userData.onboardingStage = "3"
                } else {
                  //UserData initalization
                  self.userData.emojiPlusName = ["\(self.mostRecentRecord.playerOneEmoji) \( self.mostRecentRecord.playerOneName)","\(self.mostRecentRecord.playerTwoEmoji) \( self.mostRecentRecord.playerTwoName)"]
                  self.userData.oldscore = ["\(self.mostRecentRecord.playerOneScore)", "\(self.mostRecentRecord.playerTwoScore)"]
                  self.userData.names = [self.mostRecentRecord.playerOneName, self.mostRecentRecord.playerTwoName]
                  self.userData.emojis = [self.mostRecentRecord.playerOneEmoji, self.mostRecentRecord.playerTwoEmoji]
                  self.userData.showEmoji = true
                  self.userData.playerID = self.mostRecentRecord.playerID
                  self.userData.userEmoji = self.fetchedUser.userEmoji
                  self.userData.userName = self.fetchedUser.userName
                  
                  
                  
                  self.viewRouter.currentPage = "tabBarView"
                }
                
                
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
