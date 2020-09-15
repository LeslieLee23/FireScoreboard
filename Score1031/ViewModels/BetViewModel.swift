//
//  BetViewModel.swift
//  Score1031
//
//  Created by Danting Li on 9/12/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetViewModel: View {
  
  var betDescription: String = "Becuase I was betting at this poker game and this game is going to win me over on the game and I am going to win this score!!"
  var betScore: String = "1"
  var betEntryTimeString: String = "Sep 26, 2020, 9:30 PM"
  
  var body: some View {
    HStack(){
      VStack(){
        VStack(){
          Text(betDescription)
          .multilineTextAlignment(.leading)
        }
        .padding(1)
        .frame(minWidth: 270, maxWidth: 270, minHeight: 40, maxHeight: .infinity, alignment: .leading)
        //.border(Color.green)
        VStack() {
          Text(betEntryTimeString)
          .font(.system(size: 11))
          .padding()
        }
        .frame(width:270, height: 15, alignment: .leading)
   //     .border(Color.purple)
      }
      .frame(minWidth: 270, maxWidth: 270, minHeight: 55, maxHeight: .infinity, alignment: .leading)
  //    .border(Color.red)
      VStack() {
        VStack() {
        Text("Stake:")
        .font(.system(size: 14))
        }
        .frame(width:50, height: 20, alignment: .top)
        VStack() {
        Text(betScore)
        .font(.system(size: 20))
        }
        .frame(width:50, height: 30, alignment: .center)
      }
      .frame(width:50, height: 80, alignment: .leading)
   //   .border(Color.purple)
    }
    .frame(minWidth: 350, maxWidth: 350, minHeight: 85, maxHeight: 95, alignment: .leading)
    //.border(Color.blue)
  }
}

struct BetViewModel_Previews: PreviewProvider {
  static var previews: some View {
    BetViewModel()
  }
}
