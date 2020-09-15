//
//  NameEmojiRowView.swift
//  Score1031
//
//  Created by Danting Li on 8/16/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct NameEmojiRowView: View {
  
  @EnvironmentObject private var nameAndScore: NameAndScore
  @EnvironmentObject var userData: UserData
//  @State var playerOneColors: Color = .grayCircle
//  @State var playerTwoColors: Color = .grayCircle
  
  var body: some View {
    VStack() {
      ///NameEmojiRow (140) (Edit Mode) (Emoji Mode)
      if self.userData.showEmoji == true {
        HStack {
          Button(action: {
            self.userData.selectedName = 0
//            self.playerOneColors = .purple
//            self.playerTwoColors = .grayCircle
            print("Set selectedName to \(self.userData.selectedName)")
          }) {
            Text(self.nameAndScore.playerOneEmoji ?? "👩🏻")
              .font(.system(size: 55))
          }
          .frame(width: 165, height: 125, alignment: .center)
          .buttonStyle(CircleStyleEmoji(player: 0, selectedPlayer: self.userData.selectedName))

          Button(action: {
            self.userData.selectedName = 1
//            self.playerOneColors = .grayCircle
//            self.playerTwoColors = .purple
            print("Set selectedName to \(self.userData.selectedName)")
          }) {
            Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
              .font(.system(size: 55))
          }
          .frame(width: 165, height: 125, alignment: .center)
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
            Text(self.nameAndScore.playerOneName ?? "Miu")
              .font(.system(size: 28))
          }
          .frame(width: 165, height: 125, alignment: .center)
          .buttonStyle(SquareStyle(player: 0, selectedPlayer: 0))
          Button(action: {
            self.userData.selectedName = 1
            print("Set selectedName to \(self.userData.selectedName)")
          }) {
            Text(self.nameAndScore.playerTwoName ?? "Whof")
              .font(.system(size: 28))
          }
          .frame(width: 165, height: 125, alignment: .center)
          .buttonStyle(SquareStyle(player: 1, selectedPlayer: 1))
        }
        .frame(width: 350, height: 125, alignment: .center)
      }///NameEmojiRow (140) (Edit Mode) (Normal Mode)
    }
  }
}

struct NameEmojiRowView_Previews: PreviewProvider {
  static var previews: some View {
    NameEmojiRowView()
  }
}
