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
  @ObservedObject private var keyboard = KeyboardResponder()
  @EnvironmentObject var obj : observed
  
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
            .foregroundColor(Color.offblack01)
            .font(.system(size: 25))
        }
        .frame(width: 35, height: 35)
        .foregroundColor(.offWhite02)
        .buttonStyle(CircleStyle())
        
        Text("\(self.editedScore)")
          .font(.system(size: 25))
          .padding()
          .foregroundColor(Color.offblack02)
        
        Button(action: {
          self.editedScore += 1
        }) {
          Text("+")
            .fontWeight(.medium)
            .foregroundColor(Color.offblack01)
            .font(.system(size: 25))
        }
        .frame(width: 35, height: 35)
        .foregroundColor(.offWhite02)
        .buttonStyle(CircleStyle())
        Spacer()
      }///Add and minus button row
        
      
      ///Reason text input row
      Spacer()

      MultiTextField1("  What for?", text: $reason)
        
      .padding(.bottom, keyboard.currentHeight)
      .edgesIgnoringSafeArea(.bottom)
      .animation(.easeOut(duration: 0.16))
      ///Reason text input row
      
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
          print("Name is \(self.userData.selectedName)")
          self.userData.selectedName = 5
          self.reason = ""
          self.editedScore = 0
        }) {
          Text("Cancel")
          
        }
        .buttonStyle(NeuButtonStyle())
        Spacer()
        
        Button(action: {
          self.showAlert = true
          if self.editedScore == 1 {
            self.pointGrammar = "point"
          }
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
        .buttonStyle(NeuButtonStyle(editedScore: editedScore, reason: reason, selectedName: self.userData.selectedName))
        .disabled(editedScore == 0 && reason.isEmpty)
        .disabled(self.userData.selectedName == 5)
          
        .alert(isPresented: $showAlert) { () ->
          Alert in
       
          return Alert(title: Text("Score edited!"), message: Text("You edited \(self.records3.recordName)'s score to \(self.editedScore)"), dismissButton: Alert.Button.default(Text("Ok"))
            {
              self.userData.editMode = false
            }
          )
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
