//
//  NewSelectPlayerView.swift
//  Score1031
//
//  Created by Danting Li on 7/6/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Disk

struct ChangePlayersView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @EnvironmentObject private var nameAndScore: NameAndScore
  @EnvironmentObject private var userData: UserData
  @ObservedObject private var apiLoader = APILoader()
  
  
  var body: some View {
    VStack {
      List {
        ForEach(self.apiLoader.queryPlayerList()) { record in
          
          HStack{
            VStack{
              SelectViewModel(playerID: record.playerID, playerOneName: record.playerOneName , playerTwoName: record.playerTwoName, playerOneScore: String(record.playerOneScore), playerTwoScore: String(record.playerTwoScore), playerOneEmoji: record.playerOneEmoji, playerTwoEmoji: record.playerTwoEmoji)
              
            }
            VStack{
              Button(action: {
                self.userData.playerID = record.playerID
                self.nameAndScore.playerOneName = record.playerOneName
                self.nameAndScore.playerTwoName = record.playerTwoName
                self.nameAndScore.playerOneEmoji = record.playerOneEmoji
                self.nameAndScore.playerTwoEmoji = record.playerTwoEmoji
                self.nameAndScore.PlayerOneScore = record.playerOneScore
                self.nameAndScore.PlayerTwoScore = record.playerTwoScore
                self.presentationMode.wrappedValue.dismiss()
              })
              {
                Text("Go")
                  .foregroundColor(.green)
              }
            }
          }
        }
      }
    }
  }
}

struct ChangePlayersView_Previews: PreviewProvider {
  static var previews: some View {
    ChangePlayersView()
  }
}
