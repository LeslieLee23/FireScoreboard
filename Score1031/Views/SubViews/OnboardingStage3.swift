//
//  OnboardingStage3.swift
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
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OnboardingStage3: View {
  @State var id = ""
  @State var showAlert = false
  
  
  @EnvironmentObject var userData: UserData
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @EnvironmentObject var appState: AppState
  @ObservedObject private var apiLoader = APILoader()
  @ObservedObject private var userLoader = UserLoader()
  @ObservedObject var keyboardResponder = KeyboardResponder()
  @EnvironmentObject var viewRouter: ViewRouter
  //New repository change
  @State private var records3 = APILoader().records3
  @State private var user3 = UserLoader().user3
  
    var body: some View {
      ZStack {
        Color.offWhite02.edgesIgnoringSafeArea(.all)
        VStack{
          Text("Let's get started!")
          Group{
            HStack{
              TextField("Enter your name", text: $userData.addPlayerOneName)
                .textFieldStyle(NeuTextStyle(w: appState.NeuTextWidth, h: appState.NeuTextHeight))
                .padding(.trailing, 35)
                .padding(.bottom, 8)
                .padding(.top, 10)
              //  .padding(.leading, 15)
              
            }

            HStack{
              TextField("Enter your Emoji 😉", text: $userData.addPlayerOneEmoji)
                .textFieldStyle(NeuTextStyle(w: appState.NeuTextWidth, h: appState.NeuTextHeight))
                .padding(.trailing, 35)
                .padding(.bottom, 8)
              //  .padding(.leading, 15)
            }

            HStack{
              TextField("Enter opponenet's name", text: $userData.addPlayerTwoName)
                .textFieldStyle(NeuTextStyle(w: appState.NeuTextWidth, h: appState.NeuTextHeight))
                .padding(.trailing, 35)
                .padding(.bottom, 8)
              //  .padding(.leading, 15)
            }

            HStack{
              TextField("Enter opponenet's emoji 😈", text: $userData.addPlayerTwoEmoji)
                .textFieldStyle(NeuTextStyle(w: appState.NeuTextWidth, h: appState.NeuTextHeight))
                .padding(.trailing, 35)
                .padding(.bottom, 10)
              //  .padding(.leading, 15)
            }
          }
    //      Spacer()
          HStack{
            
        //    Spacer()
            Button(action: {
             //records save
              self.userData.playerID = "1"
              self.showAlert = true
              self.records3.id = UUID().uuidString
              self.records3.playerOneName = self.userData.addPlayerOneName
              self.records3.playerTwoName = self.userData.addPlayerTwoName
              self.records3.playerOneEmoji = self.userData.addPlayerOneEmoji
              self.records3.playerTwoEmoji = self.userData.addPlayerTwoEmoji
              self.records3.playerOneScore = 0
              self.records3.playerTwoScore = 0
              self.records3.playerID = self.userData.playerID
              self.records3.recordName = "\(self.userData.addPlayerOneName)+\(self.userData.addPlayerTwoName)"
              self.records3.recordScore = self.userData.addPlayerOneEmoji
              self.records3.recordReason = "New Players Added"
              self.records3.recordEntryTime = Date()
              self.records3.recordEntryTimeString = getDateString(Date: self.records3.recordEntryTime!)
              self.records3.userId = Auth.auth().currentUser?.uid
              print("userID: \(self.records3.userId ?? "WAWA no id")")
              self.records3.recordNameStr = "Player Pairs Created!"
              self.records3.recordNameEmo = self.userData.addPlayerTwoEmoji
              
              self.apiLoader.saveData(record3: self.records3)
              
              //user save
              self.user3.id = UUID().uuidString
              self.user3.userId = Auth.auth().currentUser?.uid ?? "0"
              self.user3.userEmoji = self.userData.addPlayerOneEmoji
              self.user3.userName = self.userData.addPlayerOneName
              self.user3.userCreateTime = Date()
                
              self.userLoader.saveData(user3: self.user3)
              
              
              //UserData initalization
              self.userData.emojiPlusName = ["\(self.userData.addPlayerOneEmoji) \( self.userData.addPlayerOneName)","\( self.userData.addPlayerTwoEmoji) \( self.userData.addPlayerTwoName)"]
              self.userData.oldscore = ["0", "0"]
              self.userData.names = [self.userData.addPlayerOneName, self.userData.addPlayerTwoName]
              self.userData.emojis = [self.userData.addPlayerOneEmoji, self.userData.addPlayerTwoEmoji]
              self.userData.showEmoji = true
              self.userData.userEmoji = self.user3.userEmoji
              self.userData.userName = self.user3.userName
              
              print("self.userData.emojiPlusName \(self.userData.emojiPlusName)")
              print("self.userData.oldscore \(self.userData.oldscore)")
              print("self.userData.names \(self.userData.names)")
              print("self.userData.emojis \(self.userData.emojis)")
              print("self.userData.editMode \(self.userData.editMode)")
              print("self.userData.showEmoji \(self.userData.showEmoji)")
              print("self.userData.playerID \(self.userData.playerID)")
              print("self.userData.maxPlayerID \(self.userData.maxPlayerID)")
              print("self.userData.selectedName \(self.userData.selectedName)")
              print("self.userData.addPlayerOneName \(self.userData.addPlayerOneName)")
              print("self.userData.addPlayerOneEmoji \(self.userData.addPlayerOneEmoji)")
              print("self.userData.addPlayerTwoName \(self.userData.addPlayerTwoName)")
              print("self.userData.addPlayerTwoEmoji \(self.userData.addPlayerTwoEmoji)")
              print("self.userData.betWinnerName \(self.userData.betWinnerName)")
              print("self.userData.deleteMode \(self.userData.deleteMode)")
              print("self.userData.onboardingStage \(self.userData.onboardingStage)")
              print("self.userData.userEmoji \(self.userData.userEmoji)")
              print("self.userData.userName \(self.userData.userName)")
              
            }) {
              Text("Confirm")
            }
            .padding(.trailing, 35)
            .buttonStyle(NeuButtonStyle2(
              addPlayerOneName: self.userData.addPlayerOneName,
              addPlayerOneEmoji: self.userData.addPlayerOneEmoji,
              addPlayerTwoName: self.userData.addPlayerTwoName,
              addPlayerTwoEmoji: self.userData.addPlayerTwoEmoji))
            .disabled(self.userData.addPlayerOneName.isEmpty)
            .disabled(self.userData.addPlayerOneEmoji.isEmpty)
            .disabled(self.userData.addPlayerTwoName.isEmpty)
            .disabled(self.userData.addPlayerTwoEmoji.isEmpty)
            .disabled(self.userData.addPlayerOneEmoji.containsEmoji == false)
            .disabled(self.userData.addPlayerTwoEmoji.containsEmoji == false)
              
            .alert(isPresented: $showAlert) { () ->
              Alert in
              return Alert(title: Text("Players info saved!"), message: Text("You set your name to be \(self.userData.addPlayerOneName), with emoji \(self.userData.addPlayerOneEmoji). You set opponent's name to be  \(self.userData.addPlayerTwoName), with emoji \(self.userData.addPlayerTwoEmoji)."), dismissButton: Alert.Button.default(Text("Ok"))
              {
                self.userData.addPlayerOneName = ""
                self.userData.addPlayerTwoName = ""
                self.userData.addPlayerOneEmoji = ""
                self.userData.addPlayerTwoEmoji = ""
                self.viewRouter.currentPage = "tabBarView"
                }
              )
             
            }
          }
          Button(action: {
            self.viewRouter.currentPage = "tabBarView"
          })
          {
            Text("Use default player names")
          }
          Spacer()
          Spacer()
          Spacer()
 
        }
      }.onTapGesture {
        endEditing()
      }
    }
}

struct OnboardingStage3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStage3()
    }
}
