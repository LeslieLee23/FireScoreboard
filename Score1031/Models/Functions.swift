//
//  Functions.swift
//  Score1031
//
//  Created by Danting Li on 7/15/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import Resolver
import Disk

extension String {

    var containsEmoji: Bool {
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

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}


class AddScoreFunc: ObservableObject {
  func createRecord(playerID: String, oldscore: [String], emojiPlusName: [String], names: [String], emojis: [String], scoreEdited: String, addViewSelected: Bool, reason: String, selectedName: Int) -> (Recordline) {
    var record = ZAPILoader.load().first!
    
    record.id = UUID().uuidString
    record.recordReason = reason
    record.recordAddEdit = addViewSelected
    record.recordEntryTime = Date()
    record.playerID = playerID
    record.playerOneEmoji = emojis[0]
    record.playerTwoEmoji = emojis[1]
    record.playerOneName = names[0]
    record.playerTwoName = names[1]
    record.recordEntryTimeString = getDateString(Date: record.recordEntryTime!)
    
  
    
///AddView
    if addViewSelected == true {
      
      if selectedName == 0 {
        record.playerOneScore = Int(oldscore[0])! + Int(scoreEdited)!
        record.playerTwoScore = Int(oldscore[1])!
        record.recordName = emojiPlusName[0]
      } else if selectedName == 1 {
        record.playerTwoScore = Int(oldscore[1])! + Int(scoreEdited)!
        record.playerOneScore = Int(oldscore[0])!
        record.recordName = emojiPlusName[1]
      }
      
      
      if scoreEdited.first == "-" || scoreEdited == "0" {
        record.recordScore = scoreEdited
      } else {
        record.recordScore = "+\(scoreEdited)"
      }
      
    }
    
///EditView
    else {
      
      if selectedName == 0 {
        record.playerOneScore = Int(scoreEdited)!
        record.playerTwoScore = Int(oldscore[1])!
        record.recordName = emojiPlusName[0]
        
        record.recordScore = String(Int(record.playerOneScore) - (Int(oldscore[0])!))
      }
      else if selectedName == 1 {
        record.playerTwoScore = Int(scoreEdited)!
        record.playerOneScore = Int(oldscore[0])!
        record.recordName = emojiPlusName[1]
        
        record.recordScore = String(Int(record.playerTwoScore) - (Int(oldscore[1])!))
      }
      if record.recordScore.first != "-" && record.recordScore.first != "0" {
        record.recordScore = "+\(record.recordScore)"
      }
    }
    return record
  }
  
}

func getDateString(Date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
  dateFormatter.amSymbol = "AM"
  dateFormatter.pmSymbol = "PM"
  
  let dateTimeString = dateFormatter.string(from: Date)
  return dateTimeString
}
