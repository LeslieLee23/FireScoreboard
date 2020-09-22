//
//  HistorySnapView.swift
//  Score1031
//
//  Created by Danting Li on 8/26/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Foundation

struct HistorySnapView: View {
  
  @EnvironmentObject var userData: UserData
  @ObservedObject var apiLoader = APILoader()
  @EnvironmentObject var appState: AppState
  
  init(){
      UITableView.appearance().backgroundColor = UIColor.offWhite
  }
  
  var body: some View {
    ZStack{
      VStack() {
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.offWhite, lineWidth: 5)
              .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
              .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
              .shadow(color: Color.white, radius: 5, x: -3, y: -3)
              .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
          .frame(width: 320, height: 135, alignment: .top)
          .background(Color.offWhite)
          .cornerRadius(25)
      }

      VStack(alignment: .center) {
        Spacer()
        HStack {
        Text("History")
          .padding(.leading, 25)
          Spacer()
        Button(action: {
          self.appState.selectedTab = .HistoryView
        })
        {
          Image(systemName: "chevron.right")
            .font(.system(size:17))
            .padding(.trailing, 25)
        }
        }
        Divider()
        List {
          ForEach (apiLoader.fetchPlayerData(self.userData.playerID ?? "0").prefix(3)) { records3 in

              RecordSnapViewModel(name: records3.recordName, score: records3.recordScore, reason: records3.recordReason, entryTime: records3.recordEntryTimeString, playerID: records3.playerID, nameStr: records3.recordNameStr ?? "Wowo", nameEmo: records3.recordNameEmo ?? "🐒")

          }.listRowBackground(Color.offWhite)
        }
      }//.border(Color.red)
      
      .frame(width: 290, height: 110, alignment: .leading)
    }

  }
}

struct HistorySnapView_Previews: PreviewProvider {
  static var previews: some View {
    HistorySnapView()
  }
}
