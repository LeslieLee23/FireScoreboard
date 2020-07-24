//
//  AddScoreView.swift
//  Score1031
//
//  Created by Danting Li on 11/5/19.
//  Copyright © 2019 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import Disk

struct AddScoreView: View {
  @State var scoreEdited = ""
  @State var reason = ""
  @State var selectedName = 0
  @State var selectedNameString = ""
  @State var pointGrammar = "points"
  @State var showAlert = false
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject var addEidtChoice: AddEidtChoice
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject private var userData: UserData
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  //Disk var
  @State private var records3 = ZAPILoader.load().first!
  

  
  var emojiPlusName = [String]()
  var oldscore = [String]()
  var names = [String]()
  var emojis = [String]()
  
  var btnBack : some View { Button(action: {
    self.presentationMode.wrappedValue.dismiss()
  }) {
    HStack {
      Text("Go back")
    }
    }
  }
  
  var body: some View {
    
    VStack {
      
      VStack {
        Picker(selection: $selectedName, label:
          Text("Pick a name")
          , content: {
            ForEach(0 ..< emojiPlusName.count) {
              Text(self.emojiPlusName[$0])
            }
            
        }).pickerStyle(SegmentedPickerStyle())
          .padding(.trailing, 35)
          .padding(.leading, 35)
        if addEidtChoice.addViewSelected == true {
          TextField("Score to add", text: $scoreEdited)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            .padding(.trailing, 35)
            .padding(.leading, 35)
        } else {
          TextField("New Score", text: $scoreEdited)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            .padding(.trailing, 35)
            .padding(.leading, 35)
        }
        
        TextField("What for?", text: $reason)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.trailing, 35)
          .padding(.leading, 35)
        
        Spacer()
        
        HStack {
          Spacer()
          Button(action: {
            print("Name is \(self.selectedName)")
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Cancel")
            
          }
          Spacer()
          
          Button(action: {
            self.showAlert = true
            if Int(self.scoreEdited) == 1 {
              self.pointGrammar = "point"
            }
            if Int(self.scoreEdited) == nil {
            }
            
            self.records3 = self.addScoreFunc.createRecord(
              playerID: self.userData.playerID!,
              oldscore: self.oldscore,
              emojiPlusName: self.emojiPlusName,
              names: self.names,
              emojis: self.emojis,
              scoreEdited: self.scoreEdited,
              addViewSelected: self.addEidtChoice.addViewSelected,
              reason: self.reason,
              selectedName: self.selectedName)
            
              self.nameAndScore.playerOneEmoji = self.records3.playerOneEmoji
              self.nameAndScore.playerTwoEmoji = self.records3.playerTwoEmoji
              self.nameAndScore.playerOneName = self.records3.playerOneName
              self.nameAndScore.playerTwoName = self.records3.playerTwoName
              self.nameAndScore.PlayerOneScore = self.records3.playerOneScore
              self.nameAndScore.PlayerTwoScore = self.records3.playerTwoScore

            do {
              try Disk.append(self.records3, to: "scores.json", in: .documents)
              print("Yes yes yes this works!")
            } catch{
              print("NONONO This didn't work!")
            }
          }) {
            if addEidtChoice.addViewSelected == true {
              Text("Add")
            }
            else {
              Text("Confirm")
            }
          }
          .disabled(scoreEdited.isEmpty)
          .disabled(Double(scoreEdited)  == nil)
            
          .alert(isPresented: $showAlert) { () ->
            Alert in
            if self.addEidtChoice.addViewSelected == true {
              return Alert(title: Text("Score added!"), message: Text("You added \(self.scoreEdited) \(self.pointGrammar) to \(self.records3.recordName)"), dismissButton: Alert.Button.default(Text("Ok"))

              {self.presentationMode.wrappedValue.dismiss() }
              )
            } else {
              return Alert(title: Text("Score edited!"), message: Text("You edited \(self.selectedNameString)'s score to \(self.scoreEdited)"), dismissButton: Alert.Button.default(Text("Ok"))
              {self.presentationMode.wrappedValue.dismiss() }
              )
            }
          }
          Spacer()
        }
        Spacer()
          .navigationBarBackButtonHidden(true)
          .navigationBarItems(leading: btnBack)
        Spacer()
      }
    }
    
  }
}
struct AddScoreView_Previews: PreviewProvider {
  static var previews: some View {
    AddScoreView()
  }
}
