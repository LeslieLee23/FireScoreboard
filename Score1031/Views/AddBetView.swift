//
//  AddBetView.swift
//  Score1031
//
//  Created by Danting Li on 9/7/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import Disk
import Firebase

struct AddBetView: View {
  @State var bet = ""
  @State var betScore = 0
  @State var selectedNameString = ""
  @State var pointGrammar = "points"
  @State var showAlert = false
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject var addBetFunc: AddBetFunc
  @EnvironmentObject var userData: UserData
  @ObservedObject private var betLoader = BetLoader()
  @Environment(\.presentationMode) var presentationMode
  @State private var bets = BetLoader().bets3
  
  var body: some View {
    ZStack{
      Color.offWhite02.edgesIgnoringSafeArea(.all)

    VStack {
      
      HStack{
      Text("Enter bet:")
        .padding(.leading, 50)
        .foregroundColor(.offblack03)
      Spacer()
      }

      MultiTextField2("  Enter bet here:", text: $bet)
      
      VStack() {
        Text("Enter stake:")
        .foregroundColor(.offblack03)
      }
      ///Add and minus button row
      HStack {
        Spacer()
        Button(action: {
          self.betScore -= 1
        }) {
          Text("-")
            .fontWeight(.medium)
            .foregroundColor(self.betScore == 0 ? .offGray01 : .offblack01)
            .font(.system(size: 25))
        }
        .frame(width: 35, height: 35)
        .foregroundColor(.offWhite02)
        .buttonStyle(CircleStyle())
        .disabled(self.betScore == 0)
        
        Text("\(self.betScore)")
          .font(.system(size: 25))
          .padding()
          .foregroundColor(Color.offblack02)
        
        Button(action: {
          self.betScore += 1
        }) {
          Text("+")
            .fontWeight(.medium)
         //   .foregroundColor(Color.white)
            .foregroundColor(Color.offblack01)
            .font(.system(size: 25))
        }
        .frame(width: 35, height: 35)
        .foregroundColor(.offWhite02)
        .buttonStyle(CircleStyle())
        Spacer()
      }///Add and minus button row
      
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
          print("Name is \(self.userData.selectedName)")
        }) {
          Text("Cancel")
          
        }
        .buttonStyle(NeuButtonStyle())
        Spacer()
        
        Button(action: {
          self.showAlert = true
          if self.betScore == 1 {
            self.pointGrammar = "point"
          }
          self.bets = self.addBetFunc.createBet(
            playerID: self.userData.playerID,
            betScore: self.betScore,
            betDescription: self.bet)
          print(self.bets)
          
          self.betLoader.saveData(bets3: self.bets)
          
          
        }) {
          Text("Confirm")
        }
        .buttonStyle(NeuButtonStyle(editedScore: betScore, reason: bet, selectedName: 4))
        .disabled(betScore == 0 && bet.isEmpty)
        
          
        .alert(isPresented: $showAlert) { () ->
          Alert in
       
          return Alert(title: Text("New bet added!"), message: Text("You added a bet and set the stake to \(self.betScore)"), dismissButton: Alert.Button.default(Text("Ok"))
            {
             self.presentationMode.wrappedValue.dismiss()
            }
          )
        }
        Spacer()
      }
      Spacer()
      Spacer()
      Spacer()
      Spacer()

    }
          }.onTapGesture {
              endEditing()
          }
  }
}

struct AddBetView_Previews: PreviewProvider {
  static var previews: some View {
    AddBetView()
    .environmentObject(NameAndScore())
    .environmentObject(UserData())
    .environmentObject(AddScoreFunc())
    .environmentObject(AppState())
  }
}

