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
  @State private var bets = BetLoader().bets3
  @ObservedObject private var keyboard = KeyboardResponder()
  
  
  var body: some View {
    ZStack{
      Color.offWhite.edgesIgnoringSafeArea(.all)

    VStack {
      Spacer()
      HStack{
      Text("Enter bet:")
        .padding(.leading, 50)
      Spacer()
      }
      VStack() {
      TextField("Bet description", text: $bet)
        .textFieldStyle(NeuTextStyle(w: 290, h: 120, cr: 15))
       // .textFieldStyle(RoundedBorderTextFieldStyle())
        .frame(width: 290, height: 120)
        .multilineTextAlignment(.leading)
        
//        .padding(.trailing, 35)
//        .padding(.leading, 35)
      }.padding()
              
      VStack() {
        Text("Enter stake:")
      }
      ///Add and minus button row
      HStack {
        Spacer()
        Button(action: {
          self.betScore -= 1
        }) {
          Text("-")
            .fontWeight(.medium)
            .foregroundColor(Color.darkGray)
            .font(.system(size: 25))
        }
        .frame(width: 35, height: 35)
        .foregroundColor(.offWhite)
        .buttonStyle(CircleStyle())
        
        Text("\(self.betScore)")
          .font(.system(size: 25))
          .padding()
          .foregroundColor(Color.darkGray)
        
        Button(action: {
          self.betScore += 1
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
            playerID: self.userData.playerID!,
            betScore: self.betScore,
            betDescription: self.bet)
          
          
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
             
            }
          )
        }
        Spacer()
      }
      Spacer()
    }
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

