//
//  ContentView.swift
//  Score1031
//
//  Created by Danting Li on 10/31/19.
//  Copyright © 2019 HULUCave. All rights reserved.
//
import Foundation
import SwiftUI
import Combine
import CoreData
import Disk
import Firebase

struct ContentView: View {
  
  @EnvironmentObject private var nameAndScore: NameAndScore
  @EnvironmentObject private var userData: UserData
  @EnvironmentObject private var addEidtChoice: AddEidtChoice
  @ObservedObject private var apiLoader = APILoader()

  @State var emojiPlusName = [String]()
  @State var oldscore = [String]()
  @State var names = [String]()
  @State var emojis = [String]()
  @State var oneEmoji = [String]()
  @State var twoEmoji = [String]()
  @State var records = [Recordline]()
  
  @State var showSignInForm = false

  var body: some View {
    ZStack{
      Color.offWhite
    
    NavigationView{
      VStack {
        VStack {
          VStack {
            HStack{
              NavigationLink (destination: ChangePlayersView())
              {
                VStack() {
                Image(systemName: "person.2.square.stack").font(.system(size:20))
                Text("Change Players")
                  .fontWeight(.light)
                  .font(.system(size:12))
                //  .padding()
                }
                .padding()
              }
              .disabled(self.apiLoader.queryPlayerList().count < 2)
 
              
              Spacer()
              Text("Emoji Mode")
                .font(.system(size:15))
            }
            .padding(.trailing, 35)
            
            HStack {
              Spacer()
              Toggle(isOn: $userData.showEmoji
                .animation(
                  Animation.spring(dampingFraction: 0.7)
              )
                
              ) {
                Text("Emoji Mode")
              }.padding(.trailing, 35)
                .labelsHidden()
            }
            
            ///Title row
            Spacer()
            Text("Scoreboard")
              .font(.headline)
              .fontWeight(.bold)
              .padding(0.0)
            Spacer()
            
            ///Score row
            HStack {
              Spacer()
              Text("\(self.nameAndScore.PlayerOneScore)")
                .font(.system(size: 25))
              Spacer()
              Text("\(self.nameAndScore.PlayerTwoScore)")
                .font(.system(size: 25))
              Spacer()
            }
            //Name row
          }
          VStack {
            Spacer()
            if self.userData.showEmoji == true {
            HStack {
                Spacer()
              
                Text(self.nameAndScore.playerOneEmoji ?? "👩🏻")
                .font(.system(size: 45))
                .transition(.scale(scale: 5))

                Spacer()
                Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
                .font(.system(size: 45))
                Spacer()
            }
            } else {
              HStack {
                  Spacer()
                
                  Text(self.nameAndScore.playerOneName ?? "Miu")
                  .font(.system(size: 25))
                  Spacer()
                  Text(self.nameAndScore.playerTwoName ?? "Whof")
                  .font(.system(size: 25))
                  Spacer()
              }
            }
            Spacer()
            Spacer()
          }
          ///Add Score Button row
          VStack {
            NavigationLink (destination: AddScoreView(emojiPlusName: emojiPlusName, oldscore: oldscore, names: names, emojis: emojis)) {
              Text("Add Score!")
                .fontWeight(.semibold)
            }
            .frame(width: 89, height: 8, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("isaacblue"), Color("destinygreen")]), startPoint: .leading, endPoint: .trailing))
           
            .cornerRadius(13)
            .simultaneousGesture(TapGesture().onEnded {
              self.addEidtChoice.addViewSelected = true
              self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
              self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
              self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
              self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
              })
            
          }
          Spacer()
          Spacer()
          
          ///Edit Score Button row
          VStack {
            NavigationLink (destination: AddScoreView(emojiPlusName: emojiPlusName, oldscore: oldscore, names: names, emojis: emojis)) {
              Text("Edit Score!")
                .fontWeight(.semibold)
            }
            .frame(width: 89, height: 8, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("destinygreen"), Color("isaacblue")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(13)
              
            .simultaneousGesture(TapGesture().onEnded {
              self.addEidtChoice.addViewSelected = false
              self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
              self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
              self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
              self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
            })
            
          }
          VStack {
            
            Spacer()
            Spacer()
            
            /// View History row
            HStack {
              VStack {
                NavigationLink (destination: HistoryView()
                  .navigationBarTitle(Text("x"))
                  .navigationBarHidden(true)
                )
                {
                  VStack() {
                  Image(systemName: "eye").font(.system(size:20))
                  Text("View History")
                    .fontWeight(.light)
                    .font(.system(size:12))
                  }
                }
                .padding()
                Spacer()
              }
              Spacer()
              VStack {
                NavigationLink (destination: AddNewPlayerView())
                {
                  VStack() {
                  Image(systemName: "person.crop.circle.badge.plus").font(.system(size:20))
                  Text("Add Players")
                    .fontWeight(.light)
                    .font(.system(size:12))
                  }
                }
                .padding()
                Spacer()
              }
            }
            Spacer()
            HStack {
              
              Button(action: {
                self.nameAndScore.PlayerTwoScore = 0
                self.nameAndScore.PlayerOneScore = 0
                self.nameAndScore.playerTwoName = "Player Two"
                self.nameAndScore.playerOneName = "Player One"
                self.nameAndScore.playerOneEmoji = "👩🏻"
                self.nameAndScore.playerTwoEmoji = "👨🏻"
                self.userData.playerID = "0"
                
                self.apiLoader.remove()

                
              })
              {
                Text("Start Over")
              }
              Button(action: {

                self.apiLoader.fetchData()
                print ("This is what I am looking for \(self.apiLoader.records)")

              })
              {
                Text("file path")
              }
            }
            
          }
        }
      }
    }

    }
    .onAppear() {
      if self.nameAndScore.playerTwoName == nil {
        self.nameAndScore.PlayerTwoScore = 0
        self.nameAndScore.PlayerOneScore = 0
        self.nameAndScore.playerTwoName = "%%%Player Two"
        self.nameAndScore.playerOneName = "%%%Player One"
        self.nameAndScore.playerOneEmoji = "👩🏻"
        self.nameAndScore.playerTwoEmoji = "👨🏻"
        self.userData.playerID = "0"
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
      
    }
  }
  
}
