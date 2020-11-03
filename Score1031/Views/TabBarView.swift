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
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var appState: AppState
  @ObservedObject var betLoader = BetLoader()
  @ObservedObject var apiLoader = APILoader()
  @EnvironmentObject var obj : observed
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject var userData: UserData
  
  init() {
    UITabBar.appearance().barTintColor = UIColor.offWhite01
    UITableView.appearance().backgroundColor = UIColor.offWhite02
    UITableViewCell.appearance().backgroundColor = UIColor.offWhite02
  }
  var body: some View {
    VStack {
      if self.viewRouter.currentPage == "onboardingView" {
            OnboardingView()
      } else if self.viewRouter.currentPage == "tabBarView" {
    TabView(selection: $appState.selectedTab) {
      ContentView()
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
      
      ScoreHistoryView()

        .tabItem {
          if self.appState.selectedTab == .ScoreHistoryView {
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
      .tag(Tab.ScoreHistoryView)
      
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
//      self.apiLoader.fetchData()

      self.appState.selectedTab = .home
      
      
      print("count fetchOngoingBet \(self.betLoader.fetchOngoingBet(self.userData.playerID).count)")
      print("playerID \(self.userData.playerID)")
    
    }
//    .accentColor(Color.darkPurple)
//    .environmentObject(userData)
//    .environmentObject(appState)
//    .environmentObject(obj)
    
  }
}
  }
}

struct TabBarView_Previews: PreviewProvider {
  
  static var previews: some View {
    TabBarView()
      .environmentObject(ViewRouter())
      .environmentObject(NameAndScore())
      .environmentObject(UserData())
      .environmentObject(AddScoreFunc())
      .environmentObject(AddBetFunc())
      .environmentObject(AppState())
   
  }
}

extension TabBarView {
  enum Tab: Int, Hashable {
    case home = 0
    case ScoreHistoryView = 1
    case PlayersView = 2
    case AddNewPlayerView = 3
    case BetsHomeView = 4
  }
}
