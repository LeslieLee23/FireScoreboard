//
//  HistoryView.swift
//  Score1031
//
//  Created by Danting Li on 4/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Foundation


struct HistoryView: View {
  
  @EnvironmentObject private var userData: UserData
  @ObservedObject private var apiLoader = APILoader()
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        List {
          ForEach (apiLoader.records) { records3 in
            if records3.playerID == self.userData.playerID {
              RecordViewModel(name: records3.recordName, score: records3.recordScore, reason: records3.recordReason, entryTime: records3.recordEntryTimeString, playerID: records3.playerID, nameStr: records3.recordNameStr ?? "Wowo", nameEmo: records3.recordNameEmo ?? "🐒")
            }
          }.listRowBackground(Color.offWhite)
        }
        
      }
      .navigationBarTitle("History")
      .navigationBarItems(trailing:
        HStack{
        Spacer()
        }
      )
      .onAppear() {
        self.apiLoader.fetchData()
      }
    }
 
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryView()
  }
}

