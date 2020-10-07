//
//  TabBarView.swift
//  Score1031
//
//  Created by Danting Li on 8/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit

struct TabBarView: View {
  @EnvironmentObject var appState: AppState
  @ObservedObject var betLoader = BetLoader()
  @EnvironmentObject var obj : observed
  var userData = UserData()
  init() {
    UITabBar.appearance().barTintColor = UIColor.offWhite01
    UITableView.appearance().backgroundColor = UIColor.offWhite02
    UITableViewCell.appearance().backgroundColor = UIColor.offWhite02
  }
  var body: some View {
    TabView(selection: $appState.selectedTab) {
      //ptea.sima@gmail.com
      ContentView()
      // I think this wasnt needed and it was causing trouble, so problbaly delete it
        /* .onTapGesture {
          self.appState.selectedTab = .home
          
      }*/
//      .animation(
//        Animation.spring(dampingFraction: 1.5)
//      )
        .tabItem {
          if self.appState.selectedTab == .home {
            VStack{
              Image(systemName: "house.fill")
                .font(.system(size:25))
              Text("Home")
                .fontWeight(.light)
                .font(.system(size:11))
            }
          } else {
            VStack {
              Image(systemName: "house")
              .font(.system(size:20))
              Text("Home")
                .fontWeight(.light)
                .font(.system(size:11))
            }
            
          }
      }
      .tag(Tab.home)
      
      HistoryView()
//        .animation(
//          Animation.spring(dampingFraction: 1.5)
//        )
        .tabItem {
          if self.appState.selectedTab == .HistoryView {
            Image(systemName: "clock.fill")
              .font(.system(size:27))
            Text("History")
              .fontWeight(.light)
              .font(.system(size:11))
          } else {
            Image(systemName: "clock")
            .font(.system(size:20))
            Text("History")
              .fontWeight(.light)
              .font(.system(size:11))
          }
      }
      .tag(Tab.HistoryView)
      
      BetsHomeView()

        .tabItem {
          if self.appState.selectedTab == .BetsHomeView {
             Image(systemName: "suit.spade.fill")
               .font(.system(size:28))
             Text("Bets")
               .fontWeight(.light)
               .font(.system(size:11))
           } else {
             Image(systemName: "suit.spade.fill")
            .font(.system(size:22))
             Text("Bets")
               .fontWeight(.light)
               .font(.system(size:11))
           }
      }
      .tag(Tab.BetsHomeView)
      
      PlayersView()
        .tabItem {
          if self.appState.selectedTab == .PlayersView {
            Image(systemName: "person.2.square.stack.fill")
              .font(.system(size:27))
            Text("Players")
              .fontWeight(.light)
              .font(.system(size:11))
          } else {
            Image(systemName: "person.2.square.stack")
           .font(.system(size:20))
            Text("Players")
              .fontWeight(.light)
              .font(.system(size:11))
          }
      }
      .tag(Tab.PlayersView)
      
      AddNewPlayerView()
        .tabItem {
          
          if self.appState.selectedTab == .AddNewPlayerView {
            Image(systemName: "person.crop.circle.badge.plus.fill")
              .font(.system(size:27))
            Text("Add")
              .fontWeight(.light)
              .font(.system(size:11))
          } else {
            Image(systemName: "person.crop.circle.badge.plus")
           .font(.system(size:20))
            Text("Add")
              .fontWeight(.light)
              .font(.system(size:11))
          }
      }
      .tag(Tab.AddNewPlayerView)
    }
    .onAppear() {
      
      if self.betLoader.fetchPastBet(self.userData.playerID!).count < 1 && self.betLoader.fetchOngoingBet(self.userData.playerID!).count < 1 {
        self.userData.betState = 0
      }
      else if self.betLoader.fetchOngoingBet(self.userData.playerID!).count > 0 {
        self.userData.betState = 1
      } else if self.betLoader.fetchPastBet(self.userData.playerID!).count > 0 {
        self.userData.betState = 2
      }
      print("count fetchOngoingBet \(self.betLoader.fetchOngoingBet(self.userData.playerID!).count)")
      print("playerID \(self.userData.playerID)")
      print("betState \(self.userData.betState)")
    }
    .accentColor(Color.darkPurple)
    .environmentObject(userData)
//    .environmentObject(NameAndScore())
//    .environmentObject(AddScoreFunc())
//    .environmentObject(AddBetFunc())
    .environmentObject(appState)
    .environmentObject(obj)
  }
}

struct TabBarView_Previews: PreviewProvider {
  
  static var previews: some View {
    TabBarView()
      .environmentObject(NameAndScore())
      .environmentObject(UserData())
      .environmentObject(AddScoreFunc())
      .environmentObject(AddBetFunc())
      .environmentObject(AppState())
   //   .environmentObject(obj)
  }
}

extension TabBarView {
  enum Tab: Hashable {
    case home
    case HistoryView
    case PlayersView
    case AddNewPlayerView
    case BetsHomeView
  }
}
