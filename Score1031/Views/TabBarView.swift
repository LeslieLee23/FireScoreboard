//
//  TabBarView.swift
//  Score1031
//
//  Created by Danting Li on 8/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
  @EnvironmentObject var appState: AppState
  
  var userData = UserData()
    var body: some View {
      TabView(selection: $appState.selectedTab) {
        ContentView()
          .onTapGesture {
            self.appState.selectedTab = .home
        }
          .tabItem {
            Image(systemName: "house")
            Text("Home")
            .fontWeight(.light)
            .font(.system(size:11))
        }
        .tag(Tab.home)
        
        HistoryView()
          .tabItem {
            Image(systemName: "clock").font(.system(size:20))
            Text("History")
              .fontWeight(.light)
              .font(.system(size:11))
        }
        .tag(Tab.HistoryView)
        
        BetsHomeView()
          .tabItem {
            Image(systemName: "suit.spade.fill").font(.system(size:20))
            Text("Bets")
              .fontWeight(.light)
              .font(.system(size:11))
        }
        .tag(Tab.BetsHomeView)
        
        PlayersView()
          .tabItem {
            Image(systemName: "person.2.square.stack").font(.system(size:20))
            Text("Players")
              .fontWeight(.light)
              .font(.system(size:11))
        }
        .tag(Tab.PlayersView)
        
        AddNewPlayerView()
           .tabItem {
             Image(systemName: "person.crop.circle.badge.plus").font(.system(size:20))
             Text("Add Players")
               .fontWeight(.light)
               .font(.system(size:11))
        }
        .tag(Tab.AddNewPlayerView)
      }
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
