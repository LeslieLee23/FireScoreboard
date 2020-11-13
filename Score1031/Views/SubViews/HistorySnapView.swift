//
//  HistorySnapView.swift
//  Score1031
//
//  Created by Danting Li on 8/26/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
//import Foundation

struct HistorySnapView: View {
  
  @EnvironmentObject var userData: UserData
  @ObservedObject var apiLoader = APILoader()
  @EnvironmentObject var appState: AppState
  
  init(){
      UITableView.appearance().backgroundColor = UIColor.offWhite02
  }
  
  var body: some View {
    if #available(iOS 14.0, *) {
    ZStack{

      VStack(alignment: .center) {
        Spacer()
        HStack {
        Text("Score Change History")
          .font(.system(size:16))
          .padding(.leading, 25)
          .foregroundColor(Color.offblack03)
          Spacer()
        }
        Divider()
        List {
          ForEach (apiLoader.fetchPlayerData(self.userData.playerID).prefix(3)) { records3 in

            RecordSnapViewModel(records3: records3)

          }.listRowBackground(Color.offWhite02)
          }.listStyle(PlainListStyle())
      }
      .overlay(
        VStack() {
              RoundedRectangle(cornerRadius: 20)
                .stroke(Color.offWhite02, lineWidth: 5)
                .shadow(color: Color.offGray01, radius: 5, x: 5, y: 5)
                .clipShape(
                  RoundedRectangle(cornerRadius: 20)
              )
                .shadow(color: Color.white, radius: 5, x: -3, y: -3)
                .clipShape(
                  RoundedRectangle(cornerRadius: 20)
              )
                .frame(width: appState.HistorySnapViewWidth, height: appState.HistorySnapViewHeight, alignment: .top)
            .background(Color.clear)
            .cornerRadius(25)
        }
      )
      
      .frame(width: appState.HistorySnapViewListWidth, height: appState.HistorySnapViewListHeight, alignment: .leading)
    }.frame(width: appState.HistorySnapViewWidth, height: appState.HistorySnapViewHeight, alignment: .top)
  }
   else {
  ZStack {
    VStack() {
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.offWhite02, lineWidth: 5)
            .shadow(color: Color.offGray01, radius: 5, x: 5, y: 5)
            .clipShape(
              RoundedRectangle(cornerRadius: 20)
          )
            .shadow(color: Color.white, radius: 5, x: -3, y: -3)
            .clipShape(
              RoundedRectangle(cornerRadius: 20)
          )
            .frame(width: appState.HistorySnapViewWidth, height: appState.HistorySnapViewHeight, alignment: .top)
        .background(Color.offWhite02)
        .cornerRadius(25)
    }

    VStack(alignment: .center) {
      Spacer()
      HStack {
      Text("Score Change History")
        .font(.system(size:16))
        .padding(.leading, 25)
        .foregroundColor(Color.offblack03)
        Spacer()
//        Button(action: {
//          self.appState.selectedTab = .ScoreHistoryView
//        })
//        {
//          Image(systemName: "chevron.right")
//            .font(.system(size:17))
//            .padding(.trailing, 25)
//        }
      }
      Divider()
      List {
        ForEach (apiLoader.fetchPlayerData(self.userData.playerID).prefix(3)) { records3 in

          RecordSnapViewModel(records3: records3)

        }.listRowBackground(Color.offWhite02)
      }
    }
    
    .frame(width: appState.HistorySnapViewListWidth, height: appState.HistorySnapViewListHeight, alignment: .leading)
  }
  }
  }
}

struct HistorySnapView_Previews: PreviewProvider {
  static var previews: some View {
    HistorySnapView()
  }
}
