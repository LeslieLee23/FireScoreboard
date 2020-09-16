//
//  BetAssignResultView.swift
//  Score1031
//
//  Created by Danting Li on 9/13/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetAssignResultView: View {
  @ObservedObject private var apiLoader = APILoader()
  @ObservedObject var betLoader = BetLoader()
  @State private var records3 = APILoader().records3
  @EnvironmentObject private var nameAndScore: NameAndScore
  @EnvironmentObject var userData: UserData
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject var appState: AppState
  @State var showAlert = false
  @State var bets3: BetRecord
  
  var body: some View {
    ZStack{
      Color.offWhite.edgesIgnoringSafeArea(.all)
      VStack {
        VStack {
          HStack{
            Text("Enter bet:")
              .padding(.leading, 50)
            Spacer()
          }
        }
        
        VStack() {
          
          RoundedRectangle(cornerRadius: 15)
            .fill(Color.offWhite)
            .frame(width: 290, height: 120)
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 8, y: 8)
            .shadow(color: Color.white.opacity(0.6), radius: 6, x: -4, y: -4)
            
            .overlay(
              Text(self.bets3.betDescription)
                .frame(minWidth: 270, maxWidth: 270, minHeight: 0, maxHeight: 120),
              // .border(Color.red),
              alignment: .top
          )
          
        }.padding()
        
        VStack() {
          HStack() {
            Text("Stake: \(self.bets3.betScore)")
              .padding(.leading, 50)
            Spacer()
          }
        }
        Spacer()
        VStack() {
          Text("Pick the Winner:")
        }
        VStack {
          NameEmojiRowView()
        }.frame(width: 340, height: 125, alignment: .center)
        
        Spacer()
        HStack {
          Spacer()
          Button(action: {
            self.userData.selectedName = 5
            print("self.userData.emojiPlusName is \(self.userData.emojiPlusName)")
            print("self.userData.oldscore is \(self.userData.oldscore)")
          }) {
            Text("Cancel")
            
          }
          .buttonStyle(NeuButtonStyle())
          Spacer()
          
          Button(action: {
            self.showAlert = true
            self.userData.editMode = false
            self.userData.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
            print("\(self.userData.emojiPlusName)")
            self.userData.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
            print("\(self.userData.emojis)")
            self.userData.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
            self.userData.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
            
            if self.userData.selectedName == 0 {
              self.bets3.winnerName = self.userData.emojiPlusName[0]
              self.bets3.winnerNameStr = self.userData.names[0]
              self.bets3.winnerNameEmo = self.userData.emojis[0]
            } else if self.userData.selectedName == 1 {
              self.bets3.winnerName = self.userData.emojiPlusName[1]
              self.bets3.winnerNameStr = self.userData.names[1]
              self.bets3.winnerNameEmo = self.userData.emojis[1]
            }
          }) {
            Text("Assign")
          }
          .buttonStyle(NeuButtonStyle(selectedName: self.userData.selectedName))
          .disabled(self.userData.selectedName == 5)
            
          .alert(isPresented: $showAlert) { () ->
            Alert in
            
            return Alert(title: Text("Confirm your action:"), message: Text("Are you sure \(self.bets3.winnerName!) is the winner of this bet?"), primaryButton: .destructive(Text("Confirm"))
            {
              
              self.betLoader.updateData(bets: self.bets3)
              
              self.records3 = self.addScoreFunc.createRecord(
                playerID: self.userData.playerID!,
                oldscore: self.userData.oldscore,
                emojiPlusName: self.userData.emojiPlusName,
                names: self.userData.names,
                emojis: self.userData.emojis,
                editedScore: Int(self.bets3.betScore)!,
                reason: "Won the bet: \(self.bets3.betDescription)",
                selectedName: self.userData.selectedName)
              
              self.nameAndScore.PlayerOneScore = self.records3.playerOneScore
              self.nameAndScore.PlayerTwoScore = self.records3.playerTwoScore
              
              self.apiLoader.saveData(record3: self.records3)
              
              self.appState.selectedTab = .home
              }, secondaryButton: .cancel())
          }
          Spacer()
        }
        Spacer()
        
      }
    }
    .onAppear() {
      self.userData.selectedName = 5
    }
  }
  
}

struct BetAssignResultView_Previews: PreviewProvider {
  static var previews: some View {
    BetAssignResultView(bets3: BetRecord(playerID: "0", betDescription: "Default Bet Description", betScore: "0", betEntryTime: Date(), betEntryTimeString: ""))
  }
}
