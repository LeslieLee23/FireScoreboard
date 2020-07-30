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

struct AddNewPlayerView: View {
    
    @State var playerOneName = ""
    @State var playerOneEmoji = ""
    @State var playerTwoName = ""
    @State var playerTwoEmoji = ""
    @State var id = ""
    @State var showAlert = false

    @EnvironmentObject var nameAndScore: NameAndScore
    @EnvironmentObject var addEidtChoice: AddEidtChoice
    @EnvironmentObject private var userData: UserData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //New repository change
  @State var records3 = ZAPILoader.load().first!

    var body: some View {
        VStack{
            Group{
        HStack{
        Text("Enter name for player one:")
            .padding(.leading)
        Spacer()
        }
        HStack{
        TextField("Player One Name", text: $playerOneName)
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
        TextField("Player One Emoji", text: $playerOneEmoji)
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
        TextField("Player Two Name", text: $playerTwoName)
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
        TextField("Player Two Emoji", text: $playerTwoEmoji)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.trailing, 35)
        .padding(.leading, 35)
        }
            }
        Spacer()
        HStack{
           
            Spacer()
            Button(action: {
                
                self.userData.maxPlayerID = ZAPILoader.findMaxPlayerID() + 1
                self.showAlert = true
                self.records3.id = UUID().uuidString
                self.records3.playerOneName = self.playerOneName
                self.records3.playerTwoName = self.playerTwoName
                self.records3.playerOneEmoji = self.playerOneEmoji
                self.records3.playerTwoEmoji = self.playerTwoEmoji
                self.records3.playerOneScore = 0
                self.records3.playerTwoScore = 0
                self.records3.playerID = String(self.userData.maxPlayerID)
                self.records3.recordName = "\(self.playerOneName)+\(self.playerTwoName)"
                self.records3.recordScore = "NA"
                self.records3.recordReason = "New Palyers Added"
                self.records3.recordEntryTime = Date()
                self.records3.recordEntryTimeString = getDateString(Date: self.records3.recordEntryTime!)
                self.records3.recordAddEdit = true

                APILoader.saveData(record: self.records3)

                
                self.nameAndScore.playerOneName = self.playerOneName
                self.nameAndScore.playerTwoName = self.playerTwoName
                self.nameAndScore.playerOneEmoji = self.playerOneEmoji
                self.nameAndScore.playerTwoEmoji = self.playerTwoEmoji
                self.nameAndScore.PlayerOneScore = 0
                self.nameAndScore.PlayerTwoScore = 0
                self.userData.playerID = String(self.userData.maxPlayerID)
                
            }) {
                Text("Change Players")
                .padding(.trailing, 35)
            }
                .disabled(playerOneName.isEmpty)
                .disabled(playerOneEmoji.isEmpty)
                .disabled(playerTwoName.isEmpty)
                .disabled(playerTwoEmoji.isEmpty)
                .disabled(playerOneEmoji.containsEmoji == false)
                .disabled(playerTwoEmoji.containsEmoji == false)

            .alert(isPresented: $showAlert) { () ->
                Alert in
                return Alert(title: Text("Player Changed!"), message: Text("You changed player one to \(self.playerOneName), with emoji \(self.playerOneEmoji). You changed player two to \(self.playerTwoName), with emoji \(self.playerTwoEmoji)."), dismissButton: Alert.Button.default(Text("Ok"))
                    {self.presentationMode.wrappedValue.dismiss() }
                    )
                
            }
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    
    }
}

struct AddNewPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlayerView()
    }
}
