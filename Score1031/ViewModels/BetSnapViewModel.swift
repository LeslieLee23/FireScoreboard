//
//  BetSnapViewModel.swift
//  Score1031
//
//  Created by Danting Li on 9/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetSnapViewModel: View {
  @ObservedObject var betLoader = BetLoader()
   @State var bets3: BetRecord = BetRecord(id: "110", playerID: "0", betDescription: "Default Bet Description", betScore: "0", betEntryTime: Date(), betEntryTimeString: "9/9/2020")
  
    var body: some View {
        VStack(){
          HStack(){
            
            VStack(alignment: .leading) {
              VStack(alignment: .leading) {
              Text(self.bets3.betDescription)
              .font(.system(size: 13))
              .multilineTextAlignment(.leading)
              }
                .frame(minWidth: 165, maxWidth: .infinity, minHeight: 15, maxHeight: .infinity, alignment: .leading)

            //  Spacer()
              VStack(alignment: .leading) {
              Text(self.bets3.betEntryTimeString)
              .font(.system(size: 11))
                .foregroundColor(Color.darkGray)
              }//.frame(width:165, height: 40, alignment: .leading)
              .frame(minWidth: 150, maxWidth: .infinity, minHeight: 10, maxHeight: 10, alignment: .leading)
            }
            
            
            VStack() {
              VStack() {
                Text("Stake:")
                  .font(.system(size: 14))
              }
              .frame(width:50, height: 20, alignment: .top)
              VStack() {
                Text(bets3.betScore)
                  .font(.system(size: 20))
              }
              .frame(width:50, height: 30, alignment: .center)
            }
            .frame(width:50, height: 80, alignment: .leading)
          }
        }
        .frame(width:270, height: 50, alignment: .center)
    }
}

struct BetSnapViewModel_Previews: PreviewProvider {
    static var previews: some View {
        BetSnapViewModel()
    }
}
