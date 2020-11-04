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
import Firebase

struct EditModeView: View {
  @State var reason = ""
  @State var editedScore = 0
  @State var selectedNameString = ""
  @State var pointGrammar = "points"
  @State var action = "added"
  @State var showAlert = false
  
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject var userData: UserData
  @ObservedObject private var apiLoader = APILoader()
  @State private var records3 = APILoader().records3
  @ObservedObject private var keyboard = KeyboardResponder()
  @EnvironmentObject var obj : observed
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    VStack {
      //Spacer()
      ///Reason text input row
      Spacer()
      TextField("  Score change reason", text: $reason)
        .textFieldStyle(NeuTextStyle(w: appState.NeuTextReasonWidth, h: appState.NeuTextHeight))
//        .frame(width: appState.scoreboradWidth, height: appState.NeuTextHeight)
       // .padding(.bottom, keyboard.currentHeight)
      .edgesIgnoringSafeArea(.bottom)
      ///Reason text input row
     // Spacer()
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
          if self.editedScore == 1 || self.editedScore == -1 {
            self.pointGrammar = "point"
          }
          
          if String(editedScore).first == "-" {
            self.action = "reduced"
          }
          
          self.records3 = self.addScoreFunc.createRecord(
            playerID: self.userData.playerID,
            oldscore: self.userData.oldscore,
            emojiPlusName: self.userData.emojiPlusName,
            names: self.userData.names,
            emojis: self.userData.emojis,
            editedScore: self.editedScore,
            reason: self.reason,
            selectedName: self.userData.selectedName)
          
          self.apiLoader.saveData(record3: self.records3)
            
             self.userData.emojiPlusName  = ["\(self.records3.playerOneEmoji) \( self.records3.playerOneName)","\( self.records3.playerTwoEmoji) \( self.records3.playerTwoName)"]
             self.userData.oldscore = ["\(self.records3.playerOneScore)", "\(self.records3.playerTwoScore)"]
             self.userData.emojis = [self.records3.playerOneEmoji, self.records3.playerTwoEmoji]
             self.userData.names = [self.records3.playerOneName, self.records3.playerTwoName]
        }) {
          Text("Confirm")
        }
        .buttonStyle(NeuButtonStyle(editedScore: editedScore, reason: reason, selectedName: self.userData.selectedName))
        .disabled(editedScore == 0 && reason.isEmpty)
        .disabled(self.userData.selectedName == 5)
          
        .alert(isPresented: $showAlert) { () ->
          Alert in
       
          return Alert(title: Text("Score \(self.action)!"), message: Text("You \(self.action) \(abs(self.editedScore)) \(self.pointGrammar) to \(self.records3.recordName)'s score."), dismissButton: Alert.Button.default(Text("Ok"))
            {
              self.userData.editMode = false
              self.userData.selectedName = 5
            
          
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
    
    .environmentObject(UserData())
    .environmentObject(AddScoreFunc())
    .environmentObject(AppState())
  }
}
