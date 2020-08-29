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
import Firebase

struct ContentView: View {
  
//  @EnvironmentObject var nameAndScore: NameAndScore
//  @EnvironmentObject var userData: UserData
  @EnvironmentObject var appState: AppState
//  @ObservedObject private var apiLoader = APILoader()
  
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
  @ObservedObject var keyboardResponder = KeyboardResponder()
  
  @State var showSignInForm = false
  
  var colors: [Color] = [.offWhite, .niceBlue]
  @State var index: Int = 0
  @State var progress: CGFloat = 0
  
  
  var body: some View {
    
    NavigationView{
      ZStack{
        
        Color.offWhite.edgesIgnoringSafeArea(.all)
        
//        if self.userData.editMode == true {
//          LinearGradient(Color.darkStart, Color.darkEnd).edgesIgnoringSafeArea(.all)
//        } else {
//          Color.offWhite.edgesIgnoringSafeArea(.all)
//        }
        
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
                //    self.addEidtChoice.addViewSelected = true
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
   //           if self.userData.editMode == true {
   //             SplashView(animationType: .angle(Angle(degrees: 40)), color: .darkEnd)
   //             .frame(width: 340, height: 275, alignment: .top)
   //             .cornerRadius(30)
   //             .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
   //             .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
   //           } else {
              SplashView(animationType: .angle(Angle(degrees: 40)), color: .offWhite)
                .frame(width: 340, height: 275, alignment: .top)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 8, y: 8)
                .shadow(color: Color.white.opacity(0.6), radius: 6, x: -4, y: -4)
    //          }
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
                .frame(width: 165, height: 55, alignment: .center)
                
                VStack() {
                  Text("\(self.nameAndScore.PlayerTwoScore)")
                    .font(.system(size: 45))
                    .foregroundColor(self.userData.editMode ? .grayCircle : .black)
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
               VStack {
                Spacer()
                ///Add and minus button row
                HStack {
                  Spacer()
                  Button(action: {
                    self.editedScore -= 1
                  }) {
                    Text("-")
                      .fontWeight(.medium)
                      .foregroundColor(Color.darkGray)
                      .font(.system(size: 25))
                  }
                  .frame(width: 35, height: 35)
                  .foregroundColor(.offWhite)
                  .buttonStyle(CircleStyle())
                  
                  Text("\(self.editedScore)")
                    .font(.system(size: 25))
                    .padding()
                    .foregroundColor(Color.darkGray)
                  
                  Button(action: {
                    self.editedScore += 1
                  }) {
                    Text("+")
                      .fontWeight(.medium)
                   //   .foregroundColor(Color.white)
                      .foregroundColor(Color.darkGray)
                      .font(.system(size: 25))
                  }
                  .frame(width: 35, height: 35)
               //   .foregroundColor(.purple)
               //   .buttonStyle(CircleStyle(color: .purple))
                  .foregroundColor(.offWhite)
                  .buttonStyle(CircleStyle())
                  Spacer()
                }///Add and minus button row
                  
                
                ///Reason text input row
                Spacer()
                VStack() {
                TextField("What for?", text: $reason)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.trailing, 35)
                .padding(.leading, 35)
                }.border(Color.red)
                ///Reason text input row
                
                Spacer()
                
                HStack {
                  Spacer()
                  Button(action: {
                    print("Name is \(self.userData.selectedName)")
                  }) {
                    Text("Cancel")
                    
                  }
                  Spacer()
                  
                  Button(action: {
                    self.showAlert = true
                    if self.editedScore == 1 {
                      self.pointGrammar = "point"
                    }
                    self.userData.editMode = false
                    self.records3 = self.addScoreFunc.createRecord(
                      playerID: self.userData.playerID!,
                      oldscore: self.userData.oldscore,
                      emojiPlusName: self.userData.emojiPlusName,
                      names: self.userData.names,
                      emojis: self.userData.emojis,
                      editedScore: self.editedScore,
                      reason: self.reason,
                      selectedName: self.userData.selectedName)
                    
                    self.nameAndScore.playerOneEmoji = self.records3.playerOneEmoji
                    self.nameAndScore.playerTwoEmoji = self.records3.playerTwoEmoji
                    self.nameAndScore.playerOneName = self.records3.playerOneName
                    self.nameAndScore.playerTwoName = self.records3.playerTwoName
                    self.nameAndScore.PlayerOneScore = self.records3.playerOneScore
                    self.nameAndScore.PlayerTwoScore = self.records3.playerTwoScore
                    
                    self.apiLoader.saveData(record3: self.records3)
                    
                    
                  }) {
                    Text("Confirm")
                  }
                  .disabled(editedScore == 0 && reason.isEmpty)
                  .disabled(self.userData.selectedName == 5)
                    
                  .alert(isPresented: $showAlert) { () ->
                    Alert in
                 
                    return Alert(title: Text("Score edited!"), message: Text("You edited \(self.records3.recordName)'s score to \(self.editedScore)"), dismissButton: Alert.Button.default(Text("Ok"))
                    )
                  }
                  Button(action: {
                    self.nameAndScore.PlayerTwoScore = 0
                    self.nameAndScore.PlayerOneScore = 0
                    self.nameAndScore.playerTwoName = "Player Two"
                    self.nameAndScore.playerOneName = "Player One"
                    self.nameAndScore.playerOneEmoji = "👩🏻"
                    self.nameAndScore.playerTwoEmoji = "👨🏻"
                    self.userData.playerID = "0"
                    
                    self.userData.emojiPlusName = ["👩🏻 Player One", "👨🏻 Player Two"]
                    self.userData.oldscore = ["0", "0"]
                    self.userData.names = ["Player One", "Player Two"]
                    self.userData.emojis = ["👩🏻", "👨🏻"]
                    self.apiLoader.remove()
                    
                    
                  })
                  {
                    Text("Start Over")
                  }
                  Spacer()
                }
                Spacer()
              }
              Spacer()
            }
          } else {
            VStack() {
              EditModeView()
            }
          }
        }
      }
        .sheet(isPresented: $showSignInForm) {
          SignInView()
      }
      
//      .navigationBarItems(trailing:
//        Button(action: {self.showSignInForm.toggle() }) {
//          Image(systemName: "person.circle")
//        }
//      )
    }
    .offset(y: -keyboardResponder.currentHeight*0.5)
      
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
      .environmentObject(AddScoreFunc())
      .environmentObject(AppState())
      
    }
  }
  
}
