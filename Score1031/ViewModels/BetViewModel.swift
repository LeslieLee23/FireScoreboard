//
//  BetViewModel.swift
//  Score1031
//
//  Created by Danting Li on 9/12/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetViewModel: View {
  @ObservedObject var betLoader = BetLoader()
  @State var bets3: BetRecord = BetRecord(id: "110", playerID: "0", betDescription: "Default Bet Description", betScore: "0", betEntryTime: Date(), betEntryTimeString: "")
  
  var body: some View {
    VStack(){
      VStack(){
        Text(self.bets3.betDescription)
          .font(.system(size: 15))
          .multilineTextAlignment(.leading)
          .foregroundColor(.offblack04)
      }
      .padding(1)
      .frame(minWidth: 260, maxWidth: 260, minHeight: 40, maxHeight: .infinity, alignment: .leading)
      //.border(Color.green)
      VStack() {
        Text(self.bets3.betEntryTimeString)
          .font(.system(size: 11))
          .foregroundColor(Color.offGray03)
          .padding()
      }
      .frame(width:260, height: 15, alignment: .leading)
      //     .border(Color.purple)
    }
    .frame(minWidth: 260, maxWidth: 260, minHeight: 55, maxHeight: .infinity, alignment: .leading)
  }
}

struct BetViewModel_Previews: PreviewProvider {
  static var previews: some View {
    BetViewModel()
  }
}
