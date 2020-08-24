//
//  ChangePlayerView.swift
//  Score1031
//
//  Created by Danting Li on 3/2/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import Resolver
import Disk
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AddNewPlayerView: View {
    
//    @State var playerOneName = "abc"
//    @State var playerOneEmoji = ""
//    @State var playerTwoName = "def"
//    @State var playerTwoEmoji = ""
    @State var id = ""
    @State var showAlert = false

    @EnvironmentObject var nameAndScore: NameAndScore
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //New repository change
  @State private var records3 = APILoader().records3
  
  @ObservedObject private var apiLoader = APILoader()
  
    var body: some View {
      NavigationView {
        VStack{
            Group{
        HStack{
        Text("Enter name for player one:")
            .padding(.leading)
        Spacer()
        }
        HStack{
          TextField("Player One Name", text: $userData.addPlayerOneName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
        HStack{
        Text("Enter Emoji for player one:")
            .padding(.leading)
        Spacer()
        }
        HStack{
        TextField("Player One Emoji", text: $userData.addPlayerOneEmoji)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
        HStack{
        Text("Enter name for player two:")
            .padding(.leading)
        Spacer()
        }
        HStack{
        TextField("Player Two Name", text: $userData.addPlayerTwoName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
        HStack{
        Text("Enter emoji for player two:")
            .padding(.leading)
        Spacer()
        }
        HStack{
        TextField("Player Two Emoji", text: $userData.addPlayerTwoEmoji)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
            }
        Spacer()
        HStack{
           
            Spacer()
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
                self.records3.recordReason = "New Palyers Added"
                self.records3.recordEntryTime = Date()
                self.records3.recordEntryTimeString = getDateString(Date: self.records3.recordEntryTime!)
                self.records3.userId = Auth.auth().currentUser?.uid
                self.records3.recordNameStr = "Player Pairs Created!"
                self.records3.recordNameEmo = self.userData.addPlayerTwoEmoji

              self.apiLoader.saveData(record3: self.records3)


              self.nameAndScore.playerOneName = self.userData.addPlayerOneName
              self.nameAndScore.playerTwoName = self.userData.addPlayerTwoName
              self.nameAndScore.playerOneEmoji = self.userData.addPlayerOneEmoji
              self.nameAndScore.playerTwoEmoji = self.userData.addPlayerTwoEmoji
              self.nameAndScore.PlayerOneScore = 0
              self.nameAndScore.PlayerTwoScore = 0
              self.userData.playerID = String(self.userData.maxPlayerID)
                
            }) {
                Text("Change Players")
                .padding(.trailing, 35)
            }
                .disabled(self.userData.addPlayerOneName.isEmpty)
                .disabled(self.userData.addPlayerOneEmoji.isEmpty)
                .disabled(self.userData.addPlayerTwoName.isEmpty)
                .disabled(self.userData.addPlayerTwoEmoji.isEmpty)
                .disabled(self.userData.addPlayerOneEmoji.containsEmoji == false)
                .disabled(self.userData.addPlayerTwoEmoji.containsEmoji == false)

            .alert(isPresented: $showAlert) { () ->
                Alert in
                return Alert(title: Text("Player Changed!"), message: Text("You changed player one to \(self.userData.addPlayerOneName), with emoji \(self.userData.addPlayerOneEmoji). You changed player two to \(self.userData.addPlayerTwoName), with emoji \(self.userData.addPlayerTwoEmoji)."), dismissButton: Alert.Button.default(Text("Ok"))
                    {self.appState.selectedTab = .home
                    self.userData.addPlayerOneName = ""
                    self.userData.addPlayerTwoName = ""
                    self.userData.addPlayerOneEmoji = ""
                    self.userData.addPlayerTwoEmoji = ""
                    
                  }
                    )
                
            }
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
      }
        .navigationBarItems(trailing:
          HStack{
          Spacer()
          }
        )
      
    }
}

struct AddNewPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlayerView()
    }
}
