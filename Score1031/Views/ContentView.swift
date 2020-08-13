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
  
  var colors: [Color] = [ .babyPink, .white//, .green, .orange
  ]
  @State var index: Int = 0
  @State var progress: CGFloat = 0


  var body: some View {
    
    NavigationView{
      ZStack{
        if self.userData.showEmoji == true {
        Color.babyPink.edgesIgnoringSafeArea(.all)
        } else {
        Color.white.edgesIgnoringSafeArea(.all)
        }
//        VStack {
//
//             SplashView(animationType: .leftToRight, color: self.colors[self.index])
//                 .frame(width: 280, height: 200, alignment: .top)
//                 .cornerRadius(10)
//                 .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
//         }
      
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
                }
                .padding()
              }
              .disabled(self.apiLoader.queryPlayerList().count < 2)
              Spacer()
              
                VStack {
        //        Spacer()
                Text("Emoji Mode")
                  .font(.system(size:12))
        //        Spacer()
                Toggle(isOn: $userData.showEmoji
                  .animation(
                    Animation.spring(dampingFraction: 0.7)
                )
                  
                ) {
                  Text("Emoji Mode")
                }
            //    .padding(.trailing, 35)
                .labelsHidden()
            //      .border(Color.purple)
                .simultaneousGesture(TapGesture().onEnded {
                  self.index = (self.index + 1) % self.colors.count
                  })
              }
            }
            .padding(.trailing, 25)
 
          } .border(Color.purple)
     //     Spacer()
        ZStack{
          VStack {

            SplashView(animationType: .angle(Angle(degrees: 30)), color: self.colors[self.index])
                   .frame(width: 300, height: 250, alignment: .top)
                   .cornerRadius(10)
                   .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
           }
          VStack {
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
            Spacer()
            Spacer()
          } .border(Color.orange)
        }
          ///Add Score Button row
        VStack {
          Spacer()
          VStack {
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
            
          }.border(Color.green)
            .padding()
        //  Spacer()
          
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
          }.border(Color.blue)
          Spacer()
          Spacer()
      }.border(Color.green)
          VStack {
            
      //      Spacer()
            
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
         //       Spacer()
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
           //     Spacer()
              }
            }
          //  Spacer()
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
          }.border(Color.red)
        }.border(Color.purple)
    }//.border(Color.purple)

    }
    .onAppear() {
      if self.nameAndScore.playerTwoName == nil {
        self.nameAndScore.PlayerTwoScore = 0
        self.nameAndScore.PlayerOneScore = 0
        self.nameAndScore.playerTwoName = "Player Two"
        self.nameAndScore.playerOneName = "Player One"
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
