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
  static var test:String = ""
  static var testBinding = Binding<String>(get: { test }, set: { test = $0 } )
  
  
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
    //  TextField("Bet description", text: $bet)
    //    .textFieldStyle(NeuTextStyle(w: 290, h: 120, cr: 15))
        RoundedRectangle(cornerRadius: 25)
          .stroke(Color.offWhite, lineWidth: 5)
          .shadow(color: Color.black.opacity(0.2), radius: 4, x: 5, y: 5)
          .frame(width: 290, height: 120)
          .clipShape(
            RoundedRectangle(cornerRadius: 25)
        )
          .shadow(color: Color.white, radius: 4, x: -3, y: -3)
          .frame(width: 290, height: 120)
          .clipShape(
            RoundedRectangle(cornerRadius: 25)
        )
          .background(Color.offWhite)
          .cornerRadius(30)
          .frame(width: 290, height: 120)
       
        .overlay(
          MultilineTextField("Type here", text: $bet) {
            UIApplication.shared.endEditing()
          }
            .frame(minWidth: 270, maxWidth: 270, minHeight: 0, maxHeight: 120),
           // .border(Color.red),
          alignment: .top
        )
     

        
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

