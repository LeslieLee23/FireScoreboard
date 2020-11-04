//
//  ChangePlayerView.swift
//  Score1031
//
//  Created by Danting Li on 3/2/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import Firebase
//import FirebaseUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
  
  @State var oneEmoji = [String]()
  @State var twoEmoji = [String]()
  @State var records = [Recordline]()
  
  @State var reason = ""
  @State var editedScore = 0
  @State var selectedNameString = ""
  @State var pointGrammar = "points"
  @State var showAlert = false
  @State var userIcon = "SignIn"
  
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject var userData: UserData
  @ObservedObject private var apiLoader = APILoader()
  @ObservedObject private var userLoader = UserLoader()
  @EnvironmentObject var appState: AppState
  @ObservedObject var betLoader = BetLoader()
  @State var showSignInForm = false
  @EnvironmentObject var obj : observed
  
  
  var body: some View {
    
    NavigationView{
      ZStack{
        Color.offWhite02.edgesIgnoringSafeArea(.all)
         VStack {
          ///Header row
          VStack {
          ///buttons row
          ZStack(){
            ///first button
            VStack(alignment: .leading) {
              Spacer()
              Toggle(isOn: $userData.editMode)
              {
                Text("x")
              }
              .toggleStyle(EditToggleStyle())
              .padding(.leading, 25)
              .labelsHidden()
              .simultaneousGesture(TapGesture().onEnded {
                if self.userData.editMode == false {
                  self.userData.selectedName = 5
                  
                } else {
                }
              }
              )
              Spacer()
              Spacer()
              Spacer()
              Spacer()
          }///first button
            .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .leading)
            
            ///secound button
            VStack(alignment: .center) {
              Spacer()
                Toggle(isOn: $userData.showEmoji
                ) {
                  Text("Emoji Mode")
                }
                .toggleStyle(EmojiToggleStyle())
                .foregroundColor(self.userData.editMode ? Color.offGray02 : Color.darkPurple)
                .labelsHidden()
              Spacer()
              Spacer()
              Spacer()
              Spacer()
            }///secound button
            .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .center)
            
            ///third button
            VStack(alignment: .trailing) {
            Spacer()
            Button(action: {
              self.showSignInForm.toggle()

            }) {
             // Text(self.userIcon)
              Text(self.userData.userEmoji ?? "Waa")
           //   Image(systemName: "person.circle")
              .font(Font.system(size: 20, weight: .regular))
           //   .foregroundColor(self.userData.editMode ? Color.offGray02 : Color.darkPurple)
            }
            .padding(.trailing, 30)
              Spacer()
              Spacer()
              Spacer()
              Spacer()
              
            }///third button
            .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .trailing)
            
            ///Title row
           
            VStack(alignment: .center) {
              Spacer()
              Spacer()
              Spacer()
              Spacer()
              Spacer()
              Spacer()
              if self.userData.editMode == true {
                Text("Pick the player to edit")
                .font(.system(size: 22))
                .fontWeight(.medium)
                  .foregroundColor(Color.darkPurple)

              } else {
                Text(" Scoreboard ")
                  .font(.system(size: 23))
                  .fontWeight(.bold)
                  .foregroundColor(Color.offblack03)
                //  .border(Color.red)
              }
              Spacer()
            }///Title row
              .frame(width: appState.scoreboradWidth, height: appState.TitleRowHeight, alignment: .center)
           // .border(Color.red)

          }///buttons row
          
          } ///header row
        //  .border(Color.red)
          
          ///Scoreboard Section
          ZStack{
            ///Color Change View
            VStack {
              RoundedRectangle(cornerRadius: 20)
                .frame(width: appState.scoreboradWidth, height: appState.scoreboradHeight, alignment: .top)
              .foregroundColor(Color.offWhite01)
              .shadow(color: Color.offGray01.opacity(0.8), radius: 5, x: 5, y: 5)
            }///Color Change View
            
            ///Scoreboard Content View
            VStack {

               VStack {
                Spacer()
              }
               .frame(width: appState.scoreboradWidth, height: appState.scoreboradGap, alignment: .center)
              
              ///Score row (60)
              HStack {
                VStack() {
                  Text("\(self.userData.oldscore[0])")
                    .font(.system(size: 50))
                    .foregroundColor(self.userData.editMode ? .offGray00 : .offblack03)
                }
                .frame(width: appState.ScoreRowWidth, height: appState.ScoreRowHeight, alignment: .center)
                
                VStack() {
                  Text("\(self.userData.oldscore[1])")
                    .font(.system(size: 50))
                    .foregroundColor(self.userData.editMode ? .offGray00 : .offblack03)
                }
                .frame(width: appState.ScoreRowWidth, height: appState.ScoreRowHeight, alignment: .center)
                
              }///Score row
                .frame(width: appState.scoreboradWidth, height: appState.ScoreRowHeight, alignment: .top)
              
              Spacer()
              Spacer()
              
              ///NameEmojiRow (140) (Edit Mode)
              if self.userData.editMode == true {
                
                VStack {
                  NameEmojiRowView()
                }.frame(width: appState.scoreboradWidth, height: appState.NameEmojiRowHeight, alignment: .center)
                Spacer()
              } ///NameEmojiRow (140) (Edit Mode)
                
                ///NameEmojiRow (140) (Normal Mode)
              else {
                if self.userData.showEmoji == true {
                  HStack {
                    VStack{
                      Text(self.userData.emojis[0])
                        .font(.system(size: 55))
                        .transition(.scale(scale: 5))
                    }
                    .frame(width: appState.ScoreRowWidth, height: appState.NameEmojiRowHeight, alignment: .center)
                    VStack{
                      Text(self.userData.emojis[1])
                        .font(.system(size: 55))
                    }
                    .frame(width: appState.ScoreRowWidth, height: appState.NameEmojiRowHeight, alignment: .center)
                  }
                  .frame(width: appState.scoreboradWidth, height: appState.NameEmojiRowHeight, alignment: .center)
                  Spacer()
                } else {
                  HStack {
                    VStack{
                      Text(self.userData.names[0])
                        .font(.system(size: 28))
                        .foregroundColor(.offblack03)
                    }
                    .frame(width: appState.ScoreRowWidth - 3, height: appState.NameEmojiRowHeight, alignment: .center)
                    VStack{
                      Text(self.userData.names[1])
                        .font(.system(size: 28))
                        .foregroundColor(.offblack03)
                    }
                    .frame(width: appState.ScoreRowWidth - 3, height: appState.NameEmojiRowHeight, alignment: .center)
                  }
                  .frame(width: appState.scoreboradWidth, height: appState.NameEmojiRowHeight, alignment: .center)
                  Spacer()
                }
              }///NameEmojiRow (140) (Normal Mode)
              Spacer()
              Spacer()
            }///Scoreboard Content View
            .frame(width: appState.scoreboradWidth, height: appState.scoreboradHeight, alignment: .top)
          }///Scoreboard Section
          
          if self.userData.editMode == false {
            if  betLoader.fetchOngoingBet(self.userData.playerID).count < 1 {
              Spacer()
              Spacer()
              HistorySnapView()
                .environmentObject(UserData())
                
              Spacer()
              Spacer()
              Spacer()
            } else {
              Spacer()
              Spacer()
              HistorySnapView()
                .environmentObject(UserData())
                
              Spacer()
              BetSnapView()
                .environmentObject(UserData())
                
              Spacer()
            }
          } else {
            VStack() {
              EditModeView()
              Spacer()
            }
          }
        }
      }
      .onTapGesture {
        endEditing()
      }
      .sheet(isPresented: $showSignInForm) {
    //    LoginView()
        SignInView()
   //     FirebaseUILoginView()
      }
      .navigationBarTitle("")
      .navigationBarHidden(true)

    }
    .onAppear() {
      self.userData.editMode = false
      self.userData.selectedName = 5
//      if self.nameAndScore.playerTwoName == nil {
//        self.nameAndScore.PlayerTwoScore = 0
//        self.nameAndScore.PlayerOneScore = 0
//        self.nameAndScore.playerTwoName = "Player Two"
//        self.nameAndScore.playerOneName = "Player One"
//        self.nameAndScore.playerOneEmoji = "🌋"
//        self.nameAndScore.playerTwoEmoji = "👨🏻"
//        self.userData.playerID = "0"
//        self.userData.selectedName = 5
//      }
      
      self.apiLoader.fetchData()
      self.betLoader.fetchBetData()
      self.userLoader.fetchUserData()
      self.userIcon = self.userLoader.getUserData()
      
      print("self.userData.emojiPlusName \(self.userData.emojiPlusName)")
      print("self.userData.oldscore \(self.userData.oldscore)")
      print("self.userData.names \(self.userData.names)")
      print("self.userData.emojis \(self.userData.emojis)")
      print("self.userData.editMode \(self.userData.editMode)")
      print("self.userData.showEmoji \(self.userData.showEmoji)")
      print("self.userData.playerID \(self.userData.playerID)")
      print("self.userData.maxPlayerID \(self.userData.maxPlayerID)")
      print("self.userData.selectedName \(self.userData.selectedName)")
      print("self.userData.addPlayerOneName \(self.userData.addPlayerOneName)")
      print("self.userData.addPlayerOneEmoji \(self.userData.addPlayerOneEmoji)")
      print("self.userData.addPlayerTwoName \(self.userData.addPlayerTwoName)")
      print("self.userData.addPlayerTwoEmoji \(self.userData.addPlayerTwoEmoji)")
      print("self.userData.betWinnerName \(self.userData.betWinnerName)")
      print("self.userData.deleteMode \(self.userData.deleteMode)")
      print("self.userData.onboardingStage \(self.userData.onboardingStage)")
      print("self.userData.userEmoji \(self.userData.userEmoji)")
      print("self.userData.userName \(self.userData.userName)")
      
    }
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(["iPhone XS Max"], id: \.self) { deviceName in
      ContentView()
        .previewDevice(PreviewDevice(rawValue: deviceName))
        .previewDisplayName(deviceName)
    }
    
    .environmentObject(UserData())
    .environmentObject(AddScoreFunc())
    .environmentObject(AppState())

    
  }
}
