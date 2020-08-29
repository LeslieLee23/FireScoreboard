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

struct AddNewPlayerView: View {

  @State var id = ""
    @State var showAlert = false

    @EnvironmentObject var nameAndScore: NameAndScore
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
  
  @ObservedObject var keyboardResponder = KeyboardResponder()
    
    //New repository change
  @State private var records3 = APILoader().records3
  
  @ObservedObject private var apiLoader = APILoader()
  
    var body: some View {
      NavigationView {
        VStack{
          Spacer()
//                     Spacer()
//                     Spacer()
//                     Spacer()
//                     Spacer()
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
    
              }
            }
            .padding(.trailing, 25)
            .padding(.leading, 25)
          }///Edit Mode Row
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
          ZStack {
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
                 }
          
         if self.userData.editMode == false {
            Group{
        HStack{
        Text("Enter name for player one:")
            .padding(.leading)
        Spacer()
        }
              
              
        HStack{
          TextField("Player One Name", text: $userData.addPlayerOneName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
        HStack{
        Text("Enter Emoji for player one:")
            .padding(.leading)
        Spacer()
        }
        HStack{
        TextField("Player One Emoji", text: $userData.addPlayerOneEmoji)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
        HStack{
        Text("Enter name for player two:")
            .padding(.leading)
        Spacer()
        }
        HStack{
        TextField("Player Two Name", text: $userData.addPlayerTwoName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
        HStack{
        Text("Enter emoji for player two:")
            .padding(.leading)
        Spacer()
        }
        HStack{
        TextField("Player Two Emoji", text: $userData.addPlayerTwoEmoji)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
            }
          } else {
          VStack() {
            EditModeView()
          }
          }
        Spacer()
        HStack{
           
            Spacer()
            Button(action: {
                
                self.userData.maxPlayerID = self.apiLoader.findMaxPlayerID() + 1
                self.showAlert = true
                self.records3.id = UUID().uuidString
                self.records3.playerOneName = self.userData.addPlayerOneName
                self.records3.playerTwoName = self.userData.addPlayerTwoName
                self.records3.playerOneEmoji = self.userData.addPlayerOneEmoji
                self.records3.playerTwoEmoji = self.userData.addPlayerTwoEmoji
                self.records3.playerOneScore = 0
                self.records3.playerTwoScore = 0
                self.records3.playerID = String(self.userData.maxPlayerID)
              self.records3.recordName = "\(self.userData.addPlayerOneName)+\(self.userData.addPlayerTwoName)"
                self.records3.recordScore = self.userData.addPlayerOneEmoji
                self.records3.recordReason = "New Palyers Added"
                self.records3.recordEntryTime = Date()
                self.records3.recordEntryTimeString = getDateString(Date: self.records3.recordEntryTime!)
                self.records3.userId = Auth.auth().currentUser?.uid
                self.records3.recordNameStr = "Player Pairs Created!"
                self.records3.recordNameEmo = self.userData.addPlayerTwoEmoji

              self.apiLoader.saveData(record3: self.records3)


              self.nameAndScore.playerOneName = self.userData.addPlayerOneName
              self.nameAndScore.playerTwoName = self.userData.addPlayerTwoName
              self.nameAndScore.playerOneEmoji = self.userData.addPlayerOneEmoji
              self.nameAndScore.playerTwoEmoji = self.userData.addPlayerTwoEmoji
              self.nameAndScore.PlayerOneScore = 0
              self.nameAndScore.PlayerTwoScore = 0
              self.userData.playerID = String(self.userData.maxPlayerID)
                
            }) {
                Text("Change Players")
                .padding(.trailing, 35)
            }
                .disabled(self.userData.addPlayerOneName.isEmpty)
                .disabled(self.userData.addPlayerOneEmoji.isEmpty)
                .disabled(self.userData.addPlayerTwoName.isEmpty)
                .disabled(self.userData.addPlayerTwoEmoji.isEmpty)
                .disabled(self.userData.addPlayerOneEmoji.containsEmoji == false)
                .disabled(self.userData.addPlayerTwoEmoji.containsEmoji == false)

            .alert(isPresented: $showAlert) { () ->
                Alert in
                return Alert(title: Text("Player Changed!"), message: Text("You changed player one to \(self.userData.addPlayerOneName), with emoji \(self.userData.addPlayerOneEmoji). You changed player two to \(self.userData.addPlayerTwoName), with emoji \(self.userData.addPlayerTwoEmoji)."), dismissButton: Alert.Button.default(Text("Ok"))
                    {self.appState.selectedTab = .home
                    self.userData.addPlayerOneName = ""
                    self.userData.addPlayerTwoName = ""
                    self.userData.addPlayerOneEmoji = ""
                    self.userData.addPlayerTwoEmoji = ""
                    
                  }
                    )
                
            }
            }
//            Spacer()
//            Spacer()
//            Spacer()
//            Spacer()
//            Spacer()
        }
        .navigationBarItems(trailing:
          HStack{
          Spacer()
          }
        )
      }.offset(y: -keyboardResponder.currentHeight*0.5)

      
    }
}

struct AddNewPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlayerView()
    }
}
