//
//  ScoreHistoryView.swift
//  Score1031
//
//  Created by Danting Li on 10/18/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Foundation

struct ScoreHistoryView: View {
  
  @EnvironmentObject var userData: UserData
  @ObservedObject var apiLoader = APILoader()
  
    var body: some View {
      if #available(iOS 14.0, *) {
      NavigationView {
        VStack {
          List {
            ForEach(apiLoader.fetchPlayerData(self.userData.playerID)) { records3 in
              RecordViewModel(records3: records3)
            }.listRowBackground(Color.offWhite02)
          }.listStyle(PlainListStyle())
        }
        .navigationBarTitle("Score edit hisroty")
        .foregroundColor(.offblack04)
        
      }
      .background(Color.offWhite02)
      } else {
        NavigationView {
          VStack {
            List {
              ForEach(apiLoader.fetchPlayerData(self.userData.playerID)) { records3 in
                RecordViewModel(records3: records3)
              }.listRowBackground(Color.offWhite02)
            }
          }
          .navigationBarTitle("Score edit hisroty")
          .foregroundColor(.offblack04)
          
        }
        .background(Color.offWhite02)
      }
    }
  }

struct ScoreHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreHistoryView()
        .environmentObject(UserData())
    }
}
