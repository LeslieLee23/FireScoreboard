//
//  TabBarView.swift
//  Score1031
//
//  Created by Danting Li on 8/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
      TabView {
        ContentView()
          .tabItem {
            Image(systemName: "house")
            Text("Home")
            .fontWeight(.light)
            .font(.system(size:11))

        }
        
        HistoryView()
          .tabItem {
            Image(systemName: "clock").font(.system(size:20))
            Text("History")
              .fontWeight(.light)
              .font(.system(size:11))
        }
        
        ChangePlayersView()
          .tabItem {
            Image(systemName: "person.2.square.stack").font(.system(size:20))
            Text("Change Players")
              .fontWeight(.light)
              .font(.system(size:11))
        }
        
        AddNewPlayerView()
           .tabItem {
             Image(systemName: "person.crop.circle.badge.plus").font(.system(size:20))
             Text("Add Players")
               .fontWeight(.light)
               .font(.system(size:11))
        }
      }
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
