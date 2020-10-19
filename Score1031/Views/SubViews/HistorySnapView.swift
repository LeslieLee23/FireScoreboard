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
    ZStack{
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
          .frame(width: 320, height: 135, alignment: .top)
          .background(Color.offWhite02)
          .cornerRadius(25)
      }

      VStack(alignment: .center) {
        Spacer()
        HStack {
        Text("Score Change History")
          .foregroundColor(Color.offblack03)
          .padding(.leading, 25)
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
      }//.border(Color.red)
      
      .frame(width: 290, height: 110, alignment: .leading)
    }
//    .onAppear {
//      self.apiLoader.fetchData()
//      
//    }

  }
}

struct HistorySnapView_Previews: PreviewProvider {
  static var previews: some View {
    HistorySnapView()
  }
}
