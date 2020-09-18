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
          .multilineTextAlignment(.leading)
      }
      .padding(1)
      .frame(minWidth: 270, maxWidth: 270, minHeight: 40, maxHeight: .infinity, alignment: .leading)
      //.border(Color.green)
      VStack() {
        Text(self.bets3.betEntryTimeString)
          .font(.system(size: 11))
          .padding()
      }
      .frame(width:270, height: 15, alignment: .leading)
      //     .border(Color.purple)
    }
    .frame(minWidth: 270, maxWidth: 270, minHeight: 55, maxHeight: .infinity, alignment: .leading)
  }
}

struct BetViewModel_Previews: PreviewProvider {
  static var previews: some View {
    BetViewModel()
  }
}
