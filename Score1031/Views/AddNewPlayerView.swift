//
//  AddNewPlayerView.swift
//  Score1031
//
//  Created by Danting Li on 8/29/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//
//
import Foundation
import SwiftUI
import Combine
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AddNewPlayerView: View {
  
  @State var id = ""
  @State var showAlert = false
  
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject private var userData: UserData
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @EnvironmentObject var appState: AppState
  @ObservedObject private var apiLoader = APILoader()
  @ObservedObject var keyboardResponder = KeyboardResponder()
  
  //New repository change
  @State private var records3 = APILoader().records3

  
  var body: some View {
    NavigationView {
      ZStack {
        Color.offWhite02.edgesIgnoringSafeArea(.all)
        VStack{
          Group{
            HStack{
              TextField("Player One Name", text: $userData.addPlayerOneName)
                .textFieldStyle(NeuTextStyle())
                .padding(.trailing, 35)
                .padding(.bottom, 8)
                .padding(.top, 10)
              //  .padding(.leading, 15)
              
            }

            HStack{
              TextField("Player One Emoji 🧜‍♀️", text: $userData.addPlayerOneEmoji)
                .textFieldStyle(NeuTextStyle())
                .padding(.trailing, 35)
                .padding(.bottom, 8)
              //  .padding(.leading, 15)
            }

            HStack{
              TextField("Player Two Name", text: $userData.addPlayerTwoName)
                .textFieldStyle(NeuTextStyle())
                .padding(.trailing, 35)
                .padding(.bottom, 8)
              //  .padding(.leading, 15)
            }

            HStack{
              TextField("Player Two Emoji 🧞‍♂️", text: $userData.addPlayerTwoEmoji)
                .textFieldStyle(NeuTextStyle())
                .padding(.trailing, 35)
                .padding(.bottom, 10)
              //  .padding(.leading, 15)
            }
          }
    //      Spacer()
          HStack{
            
        //    Spacer()
            Button(action: {
              
              self.userData.maxPlayerID = self.apiLoader.findMaxPlayerID() + 1
              self.showAlert = true
              self.records3.id = UUID().uuidString
              self.records3.playerOneName = self.userData.addPlayerOneName
              self.records3.playerTwoName = self.userData.addPlayerTwoName
              self.records3.playerOneEmoji = self.userData.addPlayerOneEmoji
              self.records3.playerTwoEmoji = self.userData.addPlayerTwoEmoji
              self.records3.playerOneScore = 0
              self.records3.playerTwoScore = 0
              self.records3.playerID = String(self.userData.maxPlayerID)
              self.records3.recordName = "\(self.userData.addPlayerOneName)+\(self.userData.addPlayerTwoName)"
              self.records3.recordScore = self.userData.addPlayerOneEmoji
              self.records3.recordReason = "New Players Added"
              self.records3.recordEntryTime = Date()
              self.records3.recordEntryTimeString = getDateString(Date: self.records3.recordEntryTime!)
              self.records3.userId = Auth.auth().currentUser?.uid
              self.records3.recordNameStr = "Player Pairs Created!"
              self.records3.recordNameEmo = self.userData.addPlayerTwoEmoji
              
              self.apiLoader.saveData(record3: self.records3)
              
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
              return Alert(title: Text("Player Changed!"), message: Text("You changed player one to \(self.userData.addPlayerOneName), with emoji \(self.userData.addPlayerOneEmoji). You changed player two to \(self.userData.addPlayerTwoName), with emoji \(self.userData.addPlayerTwoEmoji)."), dismissButton: Alert.Button.default(Text("Ok"))
              {
                self.nameAndScore.playerOneName = self.userData.addPlayerOneName
                print("playerOneName \(self.nameAndScore.playerOneName ?? "999")")
                self.nameAndScore.playerTwoName = self.userData.addPlayerTwoName
                print("playerTwoName \(self.nameAndScore.playerTwoName ?? "666")")
                self.nameAndScore.playerOneEmoji = self.userData.addPlayerOneEmoji
                self.nameAndScore.playerTwoEmoji = self.userData.addPlayerTwoEmoji
                self.nameAndScore.PlayerOneScore = 0
                self.nameAndScore.PlayerTwoScore = 0
                self.userData.playerID = String(self.userData.maxPlayerID)
                
                self.userData.addPlayerOneName = ""
                self.userData.addPlayerTwoName = ""
                self.userData.addPlayerOneEmoji = ""
                self.userData.addPlayerTwoEmoji = ""
           //     self.presentationMode.wrappedValue.dismiss()
                self.appState.selectedTab = .home
                }
              )
              
            }
          }
          Spacer()
          Spacer()
          Spacer()
 
        }
      }
      .navigationBarTitle("Add New Players")
        .foregroundColor(.offblack04)
      .onTapGesture {
          endEditing()
      }
    }
    .onAppear() {
        self.userData.addPlayerOneName = ""
        self.userData.addPlayerTwoName = ""
        self.userData.addPlayerOneEmoji = ""
        self.userData.addPlayerTwoEmoji = ""
    
    }

    
  }
}

struct AddNewPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    AddNewPlayerView()
  }
}
