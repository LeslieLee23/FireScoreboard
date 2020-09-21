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
  var userData = UserData()
  init() {
    UITabBar.appearance().barTintColor = UIColor.lightOffWhite
    UITableView.appearance().backgroundColor = UIColor.offWhite
    UITableViewCell.appearance().backgroundColor = UIColor.offWhite
  }
  var body: some View {
    TabView(selection: $appState.selectedTab) {
      
      ContentView()
        .onTapGesture {
          self.appState.selectedTab = .home
          
      }
      .animation(
        Animation.spring(dampingFraction: 1.5)
      )
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
        .animation(
          Animation.spring(dampingFraction: 1.5)
        )
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
        .animation(
          Animation.spring(dampingFraction: 1.5)
        )
        .tabItem {
          if self.appState.selectedTab == .BetsHomeView {
             Image(systemName: "suit.spade.fill")
               .font(.system(size:28))
             Text("Bets")
               .fontWeight(.light)
               .font(.system(size:11))
           } else {
             Image(systemName: "suit.spade")
            .font(.system(size:22))
             Text("Bets")
               .fontWeight(.light)
               .font(.system(size:11))
           }
      }
      .tag(Tab.BetsHomeView)
      
      PlayersView()
        .animation(
          Animation.spring(dampingFraction: 1.5)
        )
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
        .animation(
          Animation.spring(dampingFraction: 1.5)
        )
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
    .accentColor(Color.darkPurple)
    .environmentObject(userData)
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
