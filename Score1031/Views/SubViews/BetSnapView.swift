//
//  BetSnapView.swift
//  Score1031
//
//  Created by Danting Li on 9/19/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetSnapView: View {
  
  @EnvironmentObject var userData: UserData
  @ObservedObject var betLoader = BetLoader()
  @EnvironmentObject var appState: AppState

  init(){
      UITableView.appearance().backgroundColor = UIColor.offWhite02
  }
  
  var body: some View {
    ZStack{
      VStack() {
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.offWhite02, lineWidth: 5)
              .shadow(color: Color.offGray01, radius: 5, x: 5, y: 5)
              .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
              .shadow(color: Color.white, radius: 5, x: -3, y: -3)
              .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
              .frame(width: appState.BetSnapViewWidth, height: appState.BetSnapViewHeight, alignment: .top)
          .background(Color.offWhite02)
          .cornerRadius(25)
      }
    //  Spacer()
      VStack(alignment: .center) {
        HStack {
        Text("Ongoing Bets")
          .font(.system(size: 16))
          .padding(.leading, 25)
          .foregroundColor(Color.offblack03)
          Spacer()
        Button(action: {
          self.appState.selectedTab = .BetsHomeView
        })
        {
          Image(systemName: "chevron.right")
            .font(.system(size:17))
            .padding(.trailing, 25)
        }
        }
        Divider()
        List {
          ForEach (betLoader.fetchOngoingBet(self.userData.playerID).prefix(3)) { bets3 in
            BetSnapViewModel(bets3: bets3)
            
          }.listRowBackground(Color.offWhite02)
        }
      }
      
      .frame(width: appState.HistorySnapViewListWidth, height: appState.HistorySnapViewListHeight, alignment: .leading)
    //  .border(Color.blue)
    }

  }
}

struct BetSnapView_Previews: PreviewProvider {
    static var previews: some View {
        BetSnapView()
    }
}
