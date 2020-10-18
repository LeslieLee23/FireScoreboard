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
//  @ObservedObject private var apiLoader = APILoader()
  @ObservedObject private var viewModel = HistoryViewModel()
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        List {
          ForEach(viewModel.historyData, id: \.id) { records3 in
              RecordViewModel(name: records3.recordName, score: records3.recordScore, reason: records3.recordReason, entryTime: records3.recordEntryTimeString, playerID: records3.playerID, nameStr: records3.recordNameStr ?? "Wowo", nameEmo: records3.recordNameEmo ?? "🐒")

          }.listRowBackground(Color.offWhite02)
        }
        
      }
      .navigationBarTitle("History")
        .foregroundColor(.offblack04)
      .onAppear {
        viewModel.fetchHistoryData(playerId: self.userData.playerID)
      }
//      .navigationBarItems(trailing:
//        HStack{
//        Spacer()
//        }
//      )
    }
    .background(Color.offWhite02)
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryView()
  }
}

