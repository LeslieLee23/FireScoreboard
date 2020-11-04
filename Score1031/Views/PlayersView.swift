//
//  NewSelectPlayerView.swift
//  Score1031
//
//  Created by Danting Li on 7/6/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct PlayersView: View {
  
  
  @EnvironmentObject var userData: UserData
  @EnvironmentObject var appState: AppState
  @ObservedObject private var apiLoader = APILoader()
  @State var deleteMode: Bool = false
  @State var showAlert = false
  
  var body: some View {
    NavigationView {
      ZStack{
        ///ZStack Color Die
        Color.offWhite02.edgesIgnoringSafeArea(.all)
      VStack {
        ///button section
         VStack {
           ///button mix section
           ZStack {
             ///minus button
             HStack() {
               VStack {
                Button(action: {
                  self.deleteMode = true
                })
                {
                  Toggle(isOn: self.$deleteMode) {
                    Text("")
                  }
                  .toggleStyle(DeleteToggleStyle())
                }
                }.frame(width: 55, height: appState.TitleRowHeight, alignment: .leading)
          //     .border(Color.red)
               Spacer()
               }///minus button
             .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .leading)
             
             ///add button
             HStack() {
             Spacer()
             VStack(alignment: .leading) {
              Button(action: {
                self.appState.selectedTab = .AddNewPlayerView
              })
              {
                Image(systemName: "person.crop.circle.badge.plus")
                  .font(.system(size:20))
                  .foregroundColor(Color.darkPurple)
              }
              }
            //   .padding(.trailing, 10)
               .frame(width: 55, height: appState.TitleRowHeight, alignment: .leading)
          //   .border(Color.red)
             }///add button
           }
           ///button mix section
         }
         ///button section
         .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .center)
        
        ///Gap row
        VStack () {
          Spacer()
        }.frame(width: appState.screenWidth, height: appState.BetGapHeight, alignment: .leading)
        ///Gap row
        Divider()
        List {
          ForEach(self.apiLoader.queryPlayerList()) { record in
            if record.playerID != self.userData.playerID {
              HStack{
                VStack{
                  SelectViewModel(playerID: record.playerID, playerOneName: record.playerOneName , playerTwoName: record.playerTwoName, playerOneScore: String(record.playerOneScore), playerTwoScore: String(record.playerTwoScore), playerOneEmoji: record.playerOneEmoji, playerTwoEmoji: record.playerTwoEmoji)
                }
                if self.deleteMode == false {
                  VStack(alignment: .trailing) {
                    Button(action: {
                      self.userData.playerID = record.playerID
                        
                      self.userData.emojiPlusName  = ["\(record.playerOneEmoji) \( record.playerOneName)","\( record.playerTwoEmoji) \( record.playerTwoName)"]
                      self.userData.oldscore = ["\(record.playerOneScore)", "\(record.playerTwoScore)"]
                      self.userData.emojis = [record.playerOneEmoji, record.playerTwoEmoji]
                      self.userData.names = [record.playerOneName, record.playerTwoName]
                        
                      self.appState.selectedTab = .home
                      
                    })
                    {
                      Image(systemName: "chevron.right")
                        .foregroundColor(Color.darkPurple)
                        .font(.system(size:20))
                      
                    }
                  }.frame(width: 50, height: 30, alignment: .center)
                //  .border(Color.red)
                }
                else {
                  VStack(alignment: .leading) {
                    Button(action: {
                      self.showAlert = true
                    })
                    {
                      Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size:20))
                    }
                    .alert(isPresented: self.$showAlert) { () ->
                      Alert in
                      
                      return Alert(title: Text("Confirm your action:"), message: Text("Are you sure you want to delete \(record.playerOneName) and \(record.playerTwoName) from the app?"), primaryButton: .destructive(Text("Confirm"))
                      {
                        self.apiLoader.remove(record.playerID)
                        self.deleteMode = false
                        }, secondaryButton: .cancel(){
                            self.deleteMode = false
                        }
                      )
                    }
                    
                  }//.border(Color.red)
                }
              }
            }
          }.listRowBackground(Color.offWhite02)
        }
      }.foregroundColor(.offblack04)
      .navigationBarTitle("")
      .navigationBarHidden(true)
//      .navigationBarItems(leading:
//          VStack(alignment: .leading) {
//          Button(action: {
//            self.deleteMode = true
//          })
//          {
//            Toggle(isOn: self.$deleteMode) {
//              Text("")
//            }
//            .toggleStyle(DeleteToggleStyle())
//          }
//          }
//          .padding(.leading, 4)
//
//          , trailing:
//          VStack {
//          Button(action: {
//            self.appState.selectedTab = .AddNewPlayerView
//          })
//          {
//            Image(systemName: "person.crop.circle.badge.plus")
//              .font(.system(size:20))
//          }
//          }
//            .padding(.trailing, 10)
//
//      )
    } ///ZStack Color
  }
  }
}


struct PlayersView_Previews: PreviewProvider {
  static var previews: some View {
    PlayersView()
  }
}
