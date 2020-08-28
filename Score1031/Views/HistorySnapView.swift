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
  @EnvironmentObject var appState: AppState
  
  init(){
      UITableView.appearance().backgroundColor = UIColor.offWhite
  }
  
  var body: some View {
    
    ZStack{
      VStack() {
        
        Rectangle()
          .frame(width: 340, height: 155, alignment: .top)
          .cornerRadius(25)
          .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
          .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
          .foregroundColor(Color.offWhite)
      }
      VStack(alignment: .center) {
        HStack {
        Text("History")
          .padding(.leading, 35)
          Spacer()
        Button(action: {
          self.appState.selectedTab = .HistoryView
        })
        {
          Image(systemName: "chevron.right")
            .font(.system(size:17))
            .padding(.trailing, 35)
        }
        }
        List {
          ForEach (apiLoader.records.prefix(3)) { records3 in
            if records3.playerID == self.userData.playerID {
              RecordSnapViewModel(name: records3.recordName, score: records3.recordScore, reason: records3.recordReason, entryTime: records3.recordEntryTimeString, playerID: records3.playerID, nameStr: records3.recordNameStr ?? "Wowo", nameEmo: records3.recordNameEmo ?? "🐒")
            }
          }.listRowBackground(Color.offWhite)
        }
        
      }//.border(Color.red)
      
      .frame(width: 340, height: 100, alignment: .center)
      .onAppear() {
        self.apiLoader.fetchData()
      }
      //.border(Color.red)
      
    }
  }
}

struct HistorySnapView_Previews: PreviewProvider {
  static var previews: some View {
    HistorySnapView()
  }
}
