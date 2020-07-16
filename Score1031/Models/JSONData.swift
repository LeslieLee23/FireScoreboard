//
//  JSONData.swift
//  Score1031
//
//  Created by Danting Li on 4/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Recordline: Codable , Identifiable
{
  
  var id: String = UUID().uuidString
  var playerID: String
  var playerOneEmoji: String
  var playerOneName: String
  var playerOneScore: Int
  var playerTwoEmoji: String
  var playerTwoName: String
  var playerTwoScore: Int
  var recordName: String
  var recordScore: String
  var recordReason: String
  var recordEntryTime: Date?
  var recordEntryTimeString: String
  var recordAddEdit: Bool
  
  
  
}

struct Playerline: Identifiable
{
  
  var id: String
  //  var playerID: String
  //  var playerOneEmoji: String
  //  var playerOneName: String
  //  var playerOneScore: Int
  //  var playerTwoEmoji: String
  //  var playerTwoName: String
  //  var playerTwoScore: Int
  
}

#if DEBUG
let testRecordline = [
  Recordline(playerID: "1", playerOneEmoji: "🥰", playerOneName: "Jiujiu", playerOneScore: 4, playerTwoEmoji: "🥶", playerTwoName: "Cold Face", playerTwoScore: 3, recordName: "Jiujiu", recordScore: "+2", recordReason: "Being a good girl", recordEntryTimeString: "Apr 20, 2020 11:17 PM", recordAddEdit: true),
  Recordline(playerID: "1", playerOneEmoji: "🥰", playerOneName: "Jiujiu", playerOneScore: 5, playerTwoEmoji: "🥶", playerTwoName: "Cold Face", playerTwoScore: 3, recordName: "Jiujiu", recordScore: "+1", recordReason: "Being a good party girl", recordEntryTimeString: "Apr 20, 2020 11:18 PM",recordAddEdit: true),
  Recordline(playerID: "2", playerOneEmoji: "🤓", playerOneName: "Nerd Face", playerOneScore: 6, playerTwoEmoji: "😳", playerTwoName: "Flushed Face", playerTwoScore: 8, recordName: "Flushed Face", recordScore: "+4", recordReason: "Being a bad boy", recordEntryTimeString: "Apr 20, 2020 11:19 PM", recordAddEdit: false)
]
#endif

