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
  @EnvironmentObject private var userData: UserData
  
  
  var body: some View {
    VStack() {
      ///NameEmojiRow (140) (Edit Mode) (Emoji Mode)
      if self.userData.showEmoji == true {
        HStack {
          Button(action: {
            self.userData.selectedName = 0
            print("Set selectedName to player 1")
          }) {
            Text(self.nameAndScore.playerOneEmoji ?? "👩🏻")
              .font(.system(size: 45))
          }
          .frame(width: 160, height: 125, alignment: .center)
          .foregroundColor(.gray)
          
          Button(action: {
            self.userData.selectedName = 1
            print("Set selectedName to player 2")
          }) {
            Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
              .font(.system(size: 45))
          }
          .frame(width: 160, height: 125, alignment: .center)
          .foregroundColor(.gray)
        }
        .buttonStyle(CircleStyleEmoji())
        
      }///NameEmojiRow (140) (Edit Mode) (Emoji Mode)
        
      ///NameEmojiRow (140) (Edit Mode) (Normal Mode)
      else {
        HStack {
          Button(action: {
            self.userData.selectedName = 0
            print("Set selectedName to player 1")
          }) {
            Text(self.nameAndScore.playerOneName ?? "Miu")
              .font(.system(size: 28))
          }
          .frame(width: 160, height: 125, alignment: .center)
          Button(action: {
            self.userData.selectedName = 1
            print("Set selectedName to player 2")
          }) {
            Text(self.nameAndScore.playerTwoName ?? "Whof")
              .font(.system(size: 28))
          }
          .frame(width: 160, height: 125, alignment: .center)
        }
        .frame(width: 340, height: 125, alignment: .center)
      }///NameEmojiRow (140) (Edit Mode) (Normal Mode)
    }
  }
}

struct NameEmojiRowView_Previews: PreviewProvider {
  static var previews: some View {
    NameEmojiRowView()
  }
}
