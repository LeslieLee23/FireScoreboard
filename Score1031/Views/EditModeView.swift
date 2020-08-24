//
//  EditModeView.swift
//  Score1031
//
//  Created by Danting Li on 8/14/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import Disk
import Firebase

struct EditModeView: View {
  @State var reason = ""
  @State var editedScore = 0
  @State var selectedNameString = ""
  @State var pointGrammar = "points"
  @State var showAlert = false
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject var userData: UserData
  @ObservedObject private var apiLoader = APILoader()
  @State private var records3 = APILoader().records3
  
  
  var body: some View {
    VStack {
      Spacer()
      ///Add and minus button row
      HStack {
        Spacer()
        Button(action: {
          self.editedScore -= 1
        }) {
          Text("-")
            .fontWeight(.medium)
            .foregroundColor(Color.darkGray)
            .font(.system(size: 25))
        }
        .frame(width: 35, height: 35)
        .foregroundColor(.offWhite)
        .buttonStyle(DarkButtonStyle())
        
        Text("\(self.editedScore)")
          .font(.system(size: 25))
          .padding()
          .foregroundColor(Color.darkGray)
        
        Button(action: {
          self.editedScore += 1
        }) {
          Text("+")
            .fontWeight(.medium)
            .foregroundColor(Color.white)
            .font(.system(size: 25))
        }
        .frame(width: 35, height: 35)
        .foregroundColor(.purple)
        .buttonStyle(CircleStyle(color: .purple))
        Spacer()
      }///Add and minus button row
        
      
      ///Reason text input row
      Spacer()
      TextField("What for?", text: $reason)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
      ///Reason text input row
      
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
          print("Name is \(self.userData.selectedName)")
        }) {
          Text("Cancel")
          
        }
        Spacer()
        
        Button(action: {
          self.showAlert = true
          if self.editedScore == 1 {
            self.pointGrammar = "point"
          }
          self.userData.editMode = false
          self.records3 = self.addScoreFunc.createRecord(
            playerID: self.userData.playerID!,
            oldscore: self.userData.oldscore,
            emojiPlusName: self.userData.emojiPlusName,
            names: self.userData.names,
            emojis: self.userData.emojis,
            editedScore: self.editedScore,
            reason: self.reason,
            selectedName: self.userData.selectedName)
          
          self.nameAndScore.playerOneEmoji = self.records3.playerOneEmoji
          self.nameAndScore.playerTwoEmoji = self.records3.playerTwoEmoji
          self.nameAndScore.playerOneName = self.records3.playerOneName
          self.nameAndScore.playerTwoName = self.records3.playerTwoName
          self.nameAndScore.PlayerOneScore = self.records3.playerOneScore
          self.nameAndScore.PlayerTwoScore = self.records3.playerTwoScore
          
          self.apiLoader.saveData(record3: self.records3)
          
          
        }) {
          Text("Confirm")
        }
        .disabled(editedScore == 0 && reason.isEmpty)
        .disabled(self.userData.selectedName == 5)
          
        .alert(isPresented: $showAlert) { () ->
          Alert in
       
          return Alert(title: Text("Score edited!"), message: Text("You edited \(self.records3.recordName)'s score to \(self.editedScore)"), dismissButton: Alert.Button.default(Text("Ok"))
          )
        }
        Button(action: {
          self.nameAndScore.PlayerTwoScore = 0
          self.nameAndScore.PlayerOneScore = 0
          self.nameAndScore.playerTwoName = "Player Two"
          self.nameAndScore.playerOneName = "Player One"
          self.nameAndScore.playerOneEmoji = "👩🏻"
          self.nameAndScore.playerTwoEmoji = "👨🏻"
          self.userData.playerID = "0"
          
          self.userData.emojiPlusName = ["👩🏻 Player One", "👨🏻 Player Two"]
          self.userData.oldscore = ["0", "0"]
          self.userData.names = ["Player One", "Player Two"]
          self.userData.emojis = ["👩🏻", "👨🏻"]
          self.apiLoader.remove()
          
          
        })
        {
          Text("Start Over")
        }
        Spacer()
      }
      Spacer()
    }
  }
}

struct EditModeView_Previews: PreviewProvider {
  static var previews: some View {
    EditModeView()
    .environmentObject(NameAndScore())
    .environmentObject(UserData())
    .environmentObject(AddScoreFunc())
    .environmentObject(AppState())
  }
}
