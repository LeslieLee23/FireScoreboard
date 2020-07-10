//
//  NewSelectPlayerView.swift
//  Score1031
//
//  Created by Danting Li on 7/6/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Disk

struct NewSelectPlayersView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Player.getAllRecords()) var players: FetchedResults<Player>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var records3 =  try? Disk.retrieve("scores.json", from: .documents, as: [Recordline].self).sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})

    var filteredRecords3 = [Recordline]()
   
    
    @EnvironmentObject private var nameAndScore: NameAndScore
    @EnvironmentObject private var userData: UserData
    
    var playerID: String = ""
    var playerOneScore: String = ""
    var playerTwoScore: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(self.filteredRecords3) { records3 in

                    HStack{
                    VStack{
                        SelectView(playerID: records3.playerID, playerOneName: records3.playerOneName , playerTwoName: records3.playerTwoName, playerOneScore: String(records3.playerOneScore), playerTwoScore: String(records3.playerTwoScore), playerOneEmoji: records3.playerOneEmoji, playerTwoEmoji: records3.playerTwoEmoji)

                        }
                    VStack{
                        Button(action: {
                            self.userData.playerID = records3.playerID
                            self.nameAndScore.playerOneName = records3.playerOneName
                            self.nameAndScore.playerTwoName = records3.playerTwoName
                            self.nameAndScore.playerOneEmoji = records3.playerOneEmoji
                            self.nameAndScore.playerTwoEmoji = records3.playerTwoEmoji
                            self.nameAndScore.PlayerOneScore = records3.playerOneScore
                            self.nameAndScore.PlayerTwoScore = records3.playerTwoScore
                            self.presentationMode.wrappedValue.dismiss()
                        })
                        {
                            Text("Go")
                                .foregroundColor(.green)
                        }
                    }
                    }
                    }
                }
            }
        }
    }

struct NewSelectPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayersView()
    }
}
