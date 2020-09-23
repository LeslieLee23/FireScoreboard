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
   @EnvironmentObject var userData: UserData
  
    var body: some View {
        VStack(){
          HStack(){
            
            VStack(alignment: .leading) {
              VStack(alignment: .leading) {
              Text(self.bets3.betDescription)
              .font(.system(size: 13))
              .multilineTextAlignment(.leading)
              }
                .frame(minWidth: 200, maxWidth: 200, minHeight: 20, maxHeight: .infinity, alignment: .leading)

            //  Spacer()
              VStack(alignment: .leading) {
              Text(self.bets3.betEntryTimeString)
              .font(.system(size: 11))
                .foregroundColor(Color.offGray02)
              }//.frame(width:165, height: 40, alignment: .leading)
              .frame(width:200, height: 25, alignment: .leading)
            }
           
            VStack() {
              VStack() {
                Text("Stake:")
                  .font(.system(size: 14))
              }
              .frame(minWidth: 50, maxWidth: 50, minHeight: 20, maxHeight: .infinity, alignment: .center)
              VStack() {
                Text(bets3.betScore)
                  .font(.system(size: 20))
              }
              .frame(minWidth: 50, maxWidth: 50, minHeight: 40, maxHeight: .infinity, alignment: .center)
            }
            .frame(minWidth: 60, maxWidth: 60, minHeight: 50, maxHeight: .infinity, alignment: .top)
          }
        }
        .frame(minWidth: 270, maxWidth: 270, minHeight: 50, maxHeight: 75, alignment: .center)
    //  .border(Color.blue)

  //      .frame(width:270, height: 50, alignment: .center)
    }
}

struct BetSnapViewModel_Previews: PreviewProvider {
    static var previews: some View {
        BetSnapViewModel()
    }
}
