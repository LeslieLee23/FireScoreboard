//
//  NameEmojiRowView.swift
//  Score1031
//
//  Created by Danting Li on 8/16/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct NameEmojiRowView: View {
  
  
  @EnvironmentObject var userData: UserData
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    VStack() {
      ///NameEmojiRow (140) (Edit Mode) (Emoji Mode)
      if self.userData.showEmoji == true {
        HStack {
          Button(action: {
            self.userData.selectedName = 0
            print("Set selectedName to \(self.userData.selectedName)")
          }) {
            Text(self.userData.emojis[0])
              .font(.system(size: 55))
          }
          .frame(width: appState.ScoreRowWidth, height: appState.NameEmojiRowHeight, alignment: .center)
          .buttonStyle(CircleStyleEmoji(player: 0, selectedPlayer: self.userData.selectedName))

          Button(action: {
            self.userData.selectedName = 1
            print("Set selectedName to \(self.userData.selectedName)")
          }) {
            Text(self.userData.emojis[1])
              .font(.system(size: 55))
          }
          .frame(width: appState.ScoreRowWidth, height: appState.NameEmojiRowHeight, alignment: .center)
          .buttonStyle(CircleStyleEmoji(player: 1, selectedPlayer: self.userData.selectedName))

        }
        
        
      }///NameEmojiRow (140) (Edit Mode) (Emoji Mode)
        
      ///NameEmojiRow (140) (Edit Mode) (Normal Mode)
      else {
        HStack {
          Button(action: {
            self.userData.selectedName = 0
            print("Set selectedName to \(self.userData.selectedName)")
          }) {
            Text(self.userData.names[0])
              .font(.system(size: 28))
          }
          .frame(width: appState.ScoreRowWidth, height: appState.NameEmojiRowHeight, alignment: .center)
          .buttonStyle(SquareStyle(player: 0, selectedPlayer: self.userData.selectedName))
          Button(action: {
            self.userData.selectedName = 1
            print("Set selectedName to \(self.userData.selectedName)")
          }) {
            Text(self.userData.names[1])
              .font(.system(size: 28))
          }
          .frame(width: appState.ScoreRowWidth, height: appState.NameEmojiRowHeight, alignment: .center)
          .buttonStyle(SquareStyle(player: 1, selectedPlayer: self.userData.selectedName))
        }
        .frame(width: appState.scoreboradWidth, height: appState.NameEmojiRowHeight, alignment: .center)
      }///NameEmojiRow (140) (Edit Mode) (Normal Mode)
    }
  }
}

struct NameEmojiRowView_Previews: PreviewProvider {
  static var previews: some View {
    NameEmojiRowView()
  }
}
