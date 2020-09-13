//
//  BetsHomeView.swift
//  Score1031
//
//  Created by Danting Li on 9/8/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Foundation

struct BetsHomeView: View {
  
  @EnvironmentObject var userData: UserData
  @ObservedObject var betLoader = BetLoader()
  @ObservedObject private var apiLoader = APILoader()
 
    var body: some View {
       NavigationView {
        VStack {
          HStack {
        VStack(alignment: .leading) {
          Text("Ongoing Bets:")
        }
        .frame(width:200, height: 30, alignment: .leading)
        .padding()
       // .border(Color.red)
        Spacer()
          }
        
          
        VStack(alignment: .leading) {
          List {
            ForEach (betLoader.bets) { bets3 in
              if bets3.playerID == self.userData.playerID {
                BetViewModel(betDescription: bets3.betDescription, betScore: bets3.betScore, betEntryTimeString: bets3.betEntryTimeString)
                .onTapGesture {
                    print(bets3.betDescription)
                }
              }
            }
          }
          }
           .frame(width:370, height: 400, alignment: .leading)
          HStack{
            Spacer()
            NavigationLink(destination: AddBetView()) {
                 Text("Add Bet")
          }
            .buttonStyle(NeuButtonStyle())
          .padding(30)

          }
          Spacer()
        }
        .frame(minWidth: 370, maxWidth: 370, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .border(Color.red)
//        .navigationBarItems(trailing:
//          NavigationLink(destination: AddBetView()) {
//                 Text("Add Bet")
//          }
//            .buttonStyle(NeuButtonStyle())
//          .padding(30)
//        )
        
        
      }
      .onAppear() {
        self.betLoader.fetchBetData()
      }
    }
}


struct BetsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BetsHomeView()
    }
}
