//
//  HistorySnapView.swift
//  Score1031
//
//  Created by Danting Li on 8/26/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct HistorySnapView: View {
  @EnvironmentObject private var userData: UserData
  @ObservedObject private var apiLoader = APILoader()
  
    var body: some View {
//       NavigationView {
         VStack(alignment: .leading) {
           List {
             ForEach (apiLoader.records) { records3 in
               if records3.playerID == self.userData.playerID {
                 RecordViewModel(name: records3.recordName, score: records3.recordScore, reason: records3.recordReason, entryTime: records3.recordEntryTimeString, playerID: records3.playerID, nameStr: records3.recordNameStr ?? "Wowo", nameEmo: records3.recordNameEmo ?? "🐒")
               }
             }
           }
           
         }
         .onAppear() {
           self.apiLoader.fetchData()
         }
 //      }
    
     }
}

struct HistorySnapView_Previews: PreviewProvider {
    static var previews: some View {
        HistorySnapView()
    }
}
