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
        
        ChangePlayersView()
          .tabItem {
            Image(systemName: "person.2.square.stack").font(.system(size:20))
            Text("Change Players")
              .fontWeight(.light)
              .font(.system(size:11))
        }
        .tag(Tab.ChangePlayersView)
        
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
      .environmentObject(AddEidtChoice())
      .environmentObject(AddScoreFunc())
    }
}

extension TabBarView {
    enum Tab: Hashable {
        case home
        case HistoryView
        case ChangePlayersView
        case AddNewPlayerView
    }
}
