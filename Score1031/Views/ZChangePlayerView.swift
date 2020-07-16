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

extension String {

    var zcontainsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x2600...0x26FF,   // Misc symbols
                 0x2700...0x27BF,   // Dingbats
                 0xFE00...0xFE0F,   // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }

}


struct ZChangePlayerView: View {
    
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
    @FetchRequest(fetchRequest: Record.getAllRecords()) var records: FetchedResults<Record>
    
    //New repository change
    @State var records3 = APILoader.load()

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
                
                self.userData.maxPlayerID += 1
                self.showAlert = true
                
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
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, yyyy HH:mm a"
                dateFormatter.amSymbol = "AM"
                dateFormatter.pmSymbol = "PM"
                self.records3.recordEntryTimeString = dateFormatter.string(from: Date())
                self.records3.recordAddEdit = true
                do {
               // try Disk.save(self.records3, to: .documents, as: "scores.json")
                    try Disk.append(self.records3, to: "scores.json", in: .documents)
                    print("Yes yes yes this works!")
                 } catch{
                  //  try Disk.save(self.records3, to: .documents, as: "scores.json")
                    print("NONONO This didn't work!")
                }

                
                self.nameAndScore.playerOneName = self.playerOneName
                self.nameAndScore.playerTwoName = self.playerTwoName
                self.nameAndScore.playerOneEmoji = self.playerOneEmoji
                self.nameAndScore.playerTwoEmoji = self.playerTwoEmoji
                self.nameAndScore.PlayerOneScore = 0
                self.nameAndScore.PlayerTwoScore = 0
                self.userData.playerID = String(self.userData.maxPlayerID)
                //trying to save through two enities
                let record = Record(context: self.managedObjectContext)
                record.name = "\(self.playerOneName)+\(self.playerTwoName)"
                record.score = "NA"
                record.reason = "New Palyers Added"
                record.entryTime = Date()
                
                record.entryTimeString = dateFormatter.string(from: Date())
                record.ponescore = "0"
                record.ptwoscore = "0"
                record.addEdit = true
                record.playerID = String(self.userData.maxPlayerID)
                
                record.player = Player(context: self.managedObjectContext)
                record.player?.playerOneName = self.playerOneName
                record.player?.playerTwoName = self.playerTwoName
                record.player?.playerOneEmoji = self.playerOneEmoji
                record.player?.playerTwoEmoji = self.playerTwoEmoji
                record.player?.playerOneScore = 0
                record.player?.playerTwoScore = 0
                record.player?.playerID = String(self.userData.maxPlayerID)
                
                 do {
                     try self.managedObjectContext.save()
                 } catch{
                    print(error)
                }
                
            }) {
                Text("Change Players")
                .padding(.trailing, 35)
            }
                .disabled(playerOneName.isEmpty)
                .disabled(playerOneEmoji.isEmpty)
                .disabled(playerTwoName.isEmpty)
                .disabled(playerTwoEmoji.isEmpty)
                .disabled(playerOneEmoji.zcontainsEmoji == false)
                .disabled(playerTwoEmoji.zcontainsEmoji == false)

            .alert(isPresented: $showAlert) { () ->
                Alert in
                return Alert(title: Text("Player Changed!"), message: Text("You changed player one to \(self.playerOneName), with emoji \(self.playerOneEmoji). You changed player two to \(self.playerTwoName), with emoji \(self.playerTwoEmoji)."), dismissButton: Alert.Button.default(Text("Ok"))
                    {self.presentationMode.wrappedValue.dismiss() }
                    )
                
            }
            }
          //  Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    
    }
}

struct ZChangePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZChangePlayerView()
    }
}
