//
//  RecordSnapViewModel.swift
//  Score1031
//
//  Created by Danting Li on 8/27/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct RecordSnapViewModel: View {
  @EnvironmentObject var appState: AppState
  var records3 = Recordline(playerID: "0", playerOneEmoji: "🍑",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "+1", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "Sep 16th, 8:00 pm", recordNameStr: "recordNameStr", recordNameEmo: "👩🏻")
  
  var body: some View {
    
    VStack(){
      HStack(){
        
      VStack(alignment: .leading){
        Text(records3.recordNameEmo ?? "👩🏻")
          //  .font(.headline)
          .font(.system(size: 28))
      }.frame(width:38, height: 50, alignment: .leading)
        
        VStack(alignment: .leading) {
          VStack(alignment: .leading) {
          Text(records3.recordReason)
          .font(.system(size: 13))
          .multilineTextAlignment(.leading)
          }
            .frame(minWidth: 165, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .leading)

        //  Spacer()
          VStack(alignment: .leading) {
          Text(records3.recordEntryTimeString)
          .font(.system(size: 11))
            .foregroundColor(Color.offGray03)
          }//.frame(width:165, height: 40, alignment: .leading)
          .frame(minWidth: 150, maxWidth: .infinity, minHeight: 10, maxHeight: 10, alignment: .leading)
        }
        
        
        VStack(alignment: .leading) {
          Text(records3.recordScore)
          .font(.system(size: 20))
          .fontWeight(.medium)
          .foregroundColor(records3.recordScore.first == "-" ? .red : .green)
        }.frame(width:45, height: 50, alignment: .center)
      }
    }
    .frame(width: appState.HistorySnapViewListWidth280, height: appState.HistorySnapViewListHeight50_63, alignment: .center)
   // .border(Color.red)
  }
}

struct RecordSnapViewModel_Previews: PreviewProvider {
  static var previews: some View {
    RecordSnapViewModel()
  }
}
