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
  
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject var userData: UserData
  @EnvironmentObject var addEidtChoice: AddEidtChoice
  @EnvironmentObject var appState: AppState
  @ObservedObject private var apiLoader = APILoader()
  
//  @State var emojiPlusName = [String]()
//  @State var oldscore = [String]()
//  @State var names = [String]()
//  @State var emojis = [String]()
  @State var oneEmoji = [String]()
  @State var twoEmoji = [String]()
  @State var records = [Recordline]()
 // @State var editMode = false
  
  @State var showSignInForm = false
  
  var colors: [Color] = [ .niceBlue, .white]
  @State var index: Int = 0
  @State var progress: CGFloat = 0
  
  
  var body: some View {
    
    NavigationView{
      ZStack{
        if self.userData.editMode == true {
          Color.babyPP.edgesIgnoringSafeArea(.all)
        } else {
          Color.white.edgesIgnoringSafeArea(.all)
        }
        
        
        VStack {
          ///Edit Mode Row (60)
          VStack {
            HStack{
              VStack {
                Text("Edit Mode")
                  .font(.system(size:12))
                Toggle(isOn: $userData.editMode
                  .animation(
                    Animation.spring(dampingFraction: 0.7)
                  )
                )
                {
                  Text("Edit Mode")
                }
                .labelsHidden()
                .simultaneousGesture(TapGesture().onEnded {
                  if self.userData.editMode == false {
                    print("wwiwiwiwiwi")
                  self.addEidtChoice.addViewSelected = true
                  self.userData.selectedName = 5
                    self.userData.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
                    print("\(self.userData.emojiPlusName)")
                  self.userData.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
                    print("\(self.userData.emojis)")
                  self.userData.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
                  self.userData.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
                  } else {
                    
                  }
                })
              }
              Spacer()
              VStack {
                Text("Emoji Mode")
                  .font(.system(size:12))
                Toggle(isOn: $userData.showEmoji
                  .animation(
                    Animation.spring(dampingFraction: 0.7)
                  )
                  
                ) {
                  Text("Emoji Mode")
                }
                .labelsHidden()
                .simultaneousGesture(TapGesture().onEnded {
                  self.index = (self.index + 1) % self.colors.count
                })
              }
            }
            .padding(.trailing, 25)
            .padding(.leading, 25)
          }///Edit Mode Row
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
          
          ///Scoreboard Section
          ZStack{
            ///Color Change View
            VStack {
              SplashView(animationType: .angle(Angle(degrees: 40)), color: self.colors[self.index])
                .frame(width: 340, height: 275, alignment: .top)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
            }///Color Change View
            
            ///Scoreboard Content View
            VStack {
              ///Title row (60)
              VStack {
                Text("Scoreboard")
                  .font(.system(size: 23))
                  .fontWeight(.bold)
              } ///Title row
                .frame(width: 340, height: 60, alignment: .center)
              
              ///Score row (60)
              HStack {
                VStack() {
                  Text("\(self.nameAndScore.PlayerOneScore)")
                    .font(.system(size: 45))
                    .foregroundColor(self.userData.editMode ? .grayCircle : .black)
                }
                .frame(width: 160, height: 55, alignment: .center)

                VStack() {
                  Text("\(self.nameAndScore.PlayerTwoScore)")
                    .font(.system(size: 45))
                    .foregroundColor(self.userData.editMode ? .grayCircle : .black)
                }
                .frame(width: 160, height: 55, alignment: .center)
                
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
                    .frame(width: 160, height: 125, alignment: .center)
                    VStack{
                      Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
                        .font(.system(size: 55))
                    }
                    .frame(width: 160, height: 125, alignment: .center)
                  }
                  .frame(width: 340, height: 125, alignment: .center)
                  Spacer()
                } else {
                  HStack {
                    VStack{
                      Text(self.nameAndScore.playerOneName ?? "Miu")
                        .font(.system(size: 28))
                    }
                    .frame(width: 160, height: 125, alignment: .center)
                    VStack{
                      Text(self.nameAndScore.playerTwoName ?? "Whof")
                        .font(.system(size: 28))
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
              .frame(width: 340, height: 275, alignment: .top)
          }///Scoreboard Section
          
          if self.userData.editMode == false {
            VStack {
              Spacer()
            }
//            ///Add Score Button row
//            VStack {
//              Spacer()
//              VStack {
//                VStack {
//                  NavigationLink (destination:
//                  AddScoreView(emojiPlusName:emojiPlusName, oldscore: oldscore, names: names, emojis: emojis)){
//                    Text("Add Score!")
//                      .fontWeight(.semibold)
//                  }
//                  .frame(width: 89, height: 8, alignment: .center)
//                  .padding()
//                  .foregroundColor(.white)
//                  .background(LinearGradient(gradient: Gradient(colors: [Color("isaacblue"), Color("destinygreen")]), startPoint: .leading, endPoint: .trailing))
//
//                  .cornerRadius(13)
//                  .simultaneousGesture(TapGesture().onEnded {
//                    self.addEidtChoice.addViewSelected = true
//                    self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
//                    self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
//                    self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
//                    self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
//                  })
//
//                }.border(Color.green)
//                  .padding()
//                //  Spacer()
//
//                ///Edit Score Button row
//                VStack {
//                  NavigationLink (destination: NameEmojiRowView()) {
//                    Text("Edit Score!")
//                      .fontWeight(.semibold)
//                  }
//                  .frame(width: 89, height: 8, alignment: .center)
//                  .padding()
//                  .foregroundColor(.white)
//                  .background(LinearGradient(gradient: Gradient(colors: [Color("destinygreen"), Color("isaacblue")]), startPoint: .leading, endPoint: .trailing))
//                  .cornerRadius(13)
//
//                  .simultaneousGesture(TapGesture().onEnded {
//                    self.addEidtChoice.addViewSelected = false
//                    self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
//                    self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
//                    self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
//                    self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
//                  })
//
//                }
//              }.border(Color.blue)
//              Spacer()
//              Spacer()
//            }.border(Color.green)
          } else {
            VStack() {
              EditModeView( //emojiPlusName:emojiPlusName, oldscore: oldscore, names: names, emojis: emojis
              )
            }
           
          }
            
           ///Tab Bar Row
//            VStack {
//              HStack {
//                ///History Button
//                VStack {
//                  NavigationLink (destination: HistoryView()
//                    .navigationBarTitle(Text("x"))
//                    .navigationBarHidden(true)
//                    )
//                  {
//                    VStack() {
//                      Image(systemName: "clock").font(.system(size:20))
//                      Text("History")
//                        .fontWeight(.light)
//                        .font(.system(size:11))
//                    }
//                  }
//                  .padding()
//                }///History Button
//
//                Spacer()
//
//                ///Change Player Button
//                VStack() {
//                  NavigationLink (destination: ChangePlayersView())
//                  {
//                    VStack() {
//                      Image(systemName: "person.2.square.stack").font(.system(size:20))
//                      Text("Change Players")
//                        .fontWeight(.light)
//                        .font(.system(size:11))
//                    }
//                    .padding()
//                  }
//                  .disabled(self.apiLoader.queryPlayerList().count < 2)
//                }///Change Player Button
//
//                Spacer()
//
//                ///Add New Player Button
//                VStack {
//                  NavigationLink (destination: AddNewPlayerView())
//                  {
//                    VStack() {
//                      Image(systemName: "person.crop.circle.badge.plus").font(.system(size:20))
//                      Text("Add Players")
//                        .fontWeight(.light)
//                        .font(.system(size:11))
//                    }
//                  }
//                  .padding()
//                }///Add New Player Button
//
//              }
//
//              //  Spacer()
////              HStack {
////
////                Button(action: {
////                  self.nameAndScore.PlayerTwoScore = 0
////                  self.nameAndScore.PlayerOneScore = 0
////                  self.nameAndScore.playerTwoName = "Player Two"
////                  self.nameAndScore.playerOneName = "Player One"
////                  self.nameAndScore.playerOneEmoji = "👩🏻"
////                  self.nameAndScore.playerTwoEmoji = "👨🏻"
////                  self.userData.playerID = "0"
////
////                  self.apiLoader.remove()
////
////
////                })
////                {
////                  Text("Start Over")
////                }
//////                Button(action: {
//////
//////                  self.apiLoader.fetchData()
//////                  print ("This is what I am looking for \(self.apiLoader.records)")
//////
//////                })
//////                {
//////                  Text("file path")
//////                }
////              }
//            }///Tab Bar Row
 //           .border(Color.red)

        }
      }//.border(Color.purple)
      .sheet(isPresented: $showSignInForm) {
          SignInView()
        }
      .navigationBarItems(trailing:
        Button(action: {self.showSignInForm.toggle() }) {
          Image(systemName: "person.circle")
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
