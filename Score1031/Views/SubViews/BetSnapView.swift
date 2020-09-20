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
  @ObservedObject var apiLoader = APILoader()
  @ObservedObject var betLoader = BetLoader()
  @EnvironmentObject var appState: AppState
  
  init(){
      UITableView.appearance().backgroundColor = UIColor.offWhite
  }
  
  var body: some View {
    ZStack{
      VStack() {
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.offWhite, lineWidth: 5)
              .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
              .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
              .shadow(color: Color.white, radius: 5, x: -3, y: -3)
              .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
          .frame(width: 320, height: 140, alignment: .top)
          .background(Color.offWhite)
          .cornerRadius(25)
      }

      VStack(alignment: .center) {
        Spacer()
        HStack {
        Text("Bet")
          .padding(.leading, 25)
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
        List {
          ForEach (betLoader.fetchOngoingBet(self.userData.playerID!).prefix(3)) { bets3 in

              HStack(){
                VStack{
                  BetViewModel(bets3: bets3)
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
              .frame(minWidth: 350, maxWidth: 350, minHeight: 85, maxHeight: 95, alignment: .leading)

          }.listRowBackground(Color.offWhite)
        }
      }//.border(Color.red)
      
      .frame(width: 290, height: 110, alignment: .leading)
    }

  }
}

struct BetSnapView_Previews: PreviewProvider {
    static var previews: some View {
        BetSnapView()
    }
}
