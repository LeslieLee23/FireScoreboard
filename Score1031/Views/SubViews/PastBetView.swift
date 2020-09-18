//////
//////  PastBetView.swift
//////  Score1031
//////
//////  Created by Danting Li on 9/17/20.`
//////  Copyright © 2020 HULUCave. All rights reserved.
//////
////
//import SwiftUI
//import Foundation
//
//struct PastBetView: View {
//  @EnvironmentObject var userData: UserData
//  @ObservedObject var betLoader = BetLoader()
//  @State var showAlert = false
//  
//  var body: some View {
//    
//    ZStack{
//      Color.offWhite.edgesIgnoringSafeArea(.all)
//        VStack(alignment: .leading) {
//          List {
//            ForEach (betLoader.bets) { bets3 in
//              if bets3.playerID == self.userData.playerID && bets3.winnerNameEmo != nil {
//                if self.userData.deleteMode == false {
//                  NavigationLink(destination: BetAssignResultView(bets3: bets3)) {
//                    HStack(){
//                      VStack{
//                        BetViewModel(bets3: bets3)
//                      }
//                      VStack() {
//                        VStack() {
//                          Text("Winner:")
//                            .font(.system(size: 14))
//                        }
//                        .frame(width:50, height: 20, alignment: .top)
//                        VStack() {
//                          Text(bets3.winnerName)
//                            .font(.system(size: 20))
//                        }
//                        .frame(width:50, height: 30, alignment: .center)
//                      }
//                      .frame(width:50, height: 80, alignment: .leading)
//                    }
//                    .frame(minWidth: 350, maxWidth: 350, minHeight: 85, maxHeight: 95, alignment: .leading)
//                  }
//                } else {
//                  HStack(){
//                    VStack{
//                      BetViewModel(bets3: bets3)
//                    }
//                    VStack(alignment: .leading) {
//                      Button(action: {
//                        self.showAlert = true
//                      })
//                      {
//                        Image(systemName: "minus.circle.fill")
//                          .foregroundColor(.red)
//                          .font(.system(size:20))
//                      }
//                      .alert(isPresented: self.$showAlert) { () ->
//                        Alert in
//
//                        return Alert(title: Text("Confirm your action:"), message: Text("Are you sure you want to delete the bet \(bets3.betDescription) from the app?"), primaryButton: .destructive(Text("Confirm"))
//                        {
//                          self.betLoader.remove(id: bets3.id)
//                          self.userData.deleteMode = false
//                          }, secondaryButton: .cancel()
//
//                            {
//                              self.userData.deleteMode = false
//                          })
//                      }
//                    }.frame(width:50, height: 80, alignment: .center)
//                  }
//                  .frame(minWidth: 350, maxWidth: 350, minHeight: 85, maxHeight: 95, alignment: .leading)
//                }
//
//              }
//            }.listRowBackground(Color.offWhite)
//          }
//        }//Past Bet
//
//    }
//
//  }
//}
//
//struct PastBetView_Previews: PreviewProvider {
//  static var previews: some View {
//    PastBetView()
//  }
//}
