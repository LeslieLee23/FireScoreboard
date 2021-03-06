//
//  BetSnapPastView.swift
//  Score1031
//
//  Created by Danting Li on 9/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetSnapPastView: View {
  
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
          .frame(width: 320, height: 145, alignment: .top)
          .background(Color.offWhite)
          .cornerRadius(25)
      }
      Spacer()
      VStack(alignment: .center) {
        Spacer()
        Spacer()
        HStack {
        Text("Bets")
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
        
        VStack {
        List {
          ForEach (betLoader.fetchOngoingBet(self.userData.playerID!).prefix(3)) { bets3 in
                VStack{
                  BetSnapPastViewModel(bets3: bets3)
                }
          }.listRowBackground(Color.offWhite)
        }
      }.frame(width: 290, height: 80, alignment: .leading)
        //.border(Color.red)
      }
      
      .frame(width: 290, height: 90, alignment: .leading)
    }

  }
}

struct BetSnapPastView_Previews: PreviewProvider {
    static var previews: some View {
        BetSnapPastView()
    }
}
