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
import Resolver
import Disk
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
  
  @EnvironmentObject var appState: AppState
  
  @State var oneEmoji = [String]()
  @State var twoEmoji = [String]()
  @State var records = [Recordline]()
  
  @State var reason = ""
  @State var editedScore = 0
  @State var selectedNameString = ""
  @State var pointGrammar = "points"
  @State var showAlert = false
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject var userData: UserData
  @ObservedObject private var apiLoader = APILoader()
  @State private var records3 = APILoader().records3
  @ObservedObject var betLoader = BetLoader()
  @State var showSignInForm = false
  @EnvironmentObject var obj : observed
  
  var colors: [Color] = [.offWhite02, .niceBlue]
  @State var index: Int = 0
  @State var progress: CGFloat = 0
  
  
  var body: some View {
    
    NavigationView{
      ZStack{
        Color.offWhite02.edgesIgnoringSafeArea(.all)
         VStack {
          ///Scoreboard Section
          ZStack{
            ///Color Change View
            VStack {
              SplashView(animationType: .angle(Angle(degrees: 40)), color: .offWhite01)
              .frame(width: 340, height: 250, alignment: .top)
              .cornerRadius(25)
              .shadow(color: Color.offGray01.opacity(0.8), radius: 5, x: 5, y: 5)
            }///Color Change View
            
            ///Scoreboard Content View
            VStack {

               VStack {
                Spacer()
              }
              .frame(width: 340, height: 35, alignment: .center)
              ///Score row (60)
              HStack {
                VStack() {
                  Text("\(self.nameAndScore.PlayerOneScore)")
                    .font(.system(size: 50))
                    .foregroundColor(self.userData.editMode ? .offGray00 : .offblack03)
                }
                .frame(width: 165, height: 55, alignment: .center)
                
                VStack() {
                  Text("\(self.nameAndScore.PlayerTwoScore)")
                    .font(.system(size: 50))
                    .foregroundColor(self.userData.editMode ? .offGray00 : .offblack03)
                }
                .frame(width: 165, height: 55, alignment: .center)
                
              }///Score row
                .frame(width: 340, height: 60, alignment: .top)
              
              Spacer()
              
              ///NameEmojiRow (140) (Edit Mode)
              if self.userData.editMode == true {
                
                VStack {
                  NameEmojiRowView()
                }.frame(width: 340, height: 125, alignment: .center)
                Spacer()
              } ///NameEmojiRow (140) (Edit Mode)
                
                ///NameEmojiRow (140) (Normal Mode)
              else {
                if self.userData.showEmoji == true {
                  HStack {
                    VStack{
                      Text(self.nameAndScore.playerOneEmoji ?? "🦧")
                        .font(.system(size: 55))
                        .transition(.scale(scale: 5))
                    }
                    .frame(width: 165, height: 125, alignment: .center)
                    VStack{
                      Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
                        .font(.system(size: 55))
                    }
                    .frame(width: 165, height: 125, alignment: .center)
                  }
                  .frame(width: 340, height: 125, alignment: .center)
                  Spacer()
                } else {
                  HStack {
                    VStack{
                      Text(self.nameAndScore.playerOneName ?? "Miu")
                        .font(.system(size: 28))
                        .foregroundColor(.offblack03)
                    }
                    .frame(width: 160, height: 125, alignment: .center)
                    VStack{
                      Text(self.nameAndScore.playerTwoName ?? "Whof")
                        .font(.system(size: 28))
                        .foregroundColor(.offblack03)
                    }
                    .frame(width: 160, height: 125, alignment: .center)
                  }
                  .frame(width: 340, height: 125, alignment: .center)
                  Spacer()
                }
              }///NameEmojiRow (140) (Normal Mode)
              Spacer()
              Spacer()
            }///Scoreboard Content View
              .frame(width: 340, height: 250, alignment: .top)
          }///Scoreboard Section
            .padding(.top, betLoader.fetchOngoingBet(self.userData.playerID!).count < 1 ? 50 : 0)
          if self.userData.editMode == false {
            if  betLoader.fetchOngoingBet(self.userData.playerID!).count < 1 {
              Spacer()
              Spacer()
              HistorySnapView()
                .environmentObject(UserData())
                
              Spacer()
              Spacer()
              Spacer()
            } else {
              Spacer()
              HistorySnapView()
                .environmentObject(UserData())
             //   .environmentObject(AppState())
                
              Spacer()
              BetSnapView()
                .environmentObject(UserData())
                //.environmentObject(AppState())
                
              Spacer()
            }
          } else {
            VStack() {
              EditModeView()
            }
          }
        }
      }
      .onTapGesture {
        endEditing()
      }
      .sheet(isPresented: $showSignInForm) {
        SignInView()
      }
        
      .navigationBarItems(trailing:
        VStack {
          Spacer()
          Spacer()
          Spacer()
          Spacer()
        HStack(spacing: 62){
            Toggle(isOn: $userData.editMode
//              .animation(
//                Animation.spring(dampingFraction: 0.7)
//              )
              )
            {
              Text("x")
            }
            .toggleStyle(EditToggleStyle())
            .padding(.leading, 30)
            .labelsHidden()
            .simultaneousGesture(TapGesture().onEnded {
              if self.userData.editMode == false {
                self.userData.selectedName = 5
                self.userData.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
                print("\(self.userData.emojiPlusName)")
                self.userData.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
                
                self.userData.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
                print("\(self.userData.emojis)")
                self.userData.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
              } else {
                
              }
            })
          Spacer()
              Toggle(isOn: $userData.showEmoji
//                .animation(
//                  Animation.spring(dampingFraction: 0.7)
//                )
                
              ) {
                Text("Emoji Mode")
              }
              .toggleStyle(EmojiToggleStyle())
              .labelsHidden()
              .simultaneousGesture(TapGesture().onEnded {
                self.index = (self.index + 1) % self.colors.count
              })
          Spacer()
          Button(action: {self.showSignInForm.toggle() }) {
            Image(systemName: "person.circle")
            .font(Font.system(size: 20, weight: .regular))
          }
          .padding(.trailing, 30)
        }
        ///Title row (60)
          Spacer()
          Spacer()
          Spacer()
        VStack {
          if self.userData.editMode == true {
            Text("Select one:")
              .font(.system(size: 22))
              //  .fontWeight(.bold)
              .foregroundColor(Color.offblack01)
          } else {
            Text("Scoreboard")
              .font(.system(size: 23))
              .fontWeight(.bold)
              .foregroundColor(Color.offblack03)
          }
        } ///Title row
          .frame(width: 340, height: 25, alignment: .center)
        }
      )
    }
    .onAppear() {
      if self.nameAndScore.playerTwoName == nil {
        self.nameAndScore.PlayerTwoScore = 0
        self.nameAndScore.PlayerOneScore = 0
        self.nameAndScore.playerTwoName = "Player Two"
        self.nameAndScore.playerOneName = "Player One"
        self.nameAndScore.playerOneEmoji = "🌋"
        self.nameAndScore.playerTwoEmoji = "👨🏻"
        self.userData.playerID = "0"
        self.userData.selectedName = 5
      }
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
    .environmentObject(NameAndScore())
    .environmentObject(UserData())
    .environmentObject(AddScoreFunc())
    .environmentObject(AppState())

    
  }
}
