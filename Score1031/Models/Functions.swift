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
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


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

class AddScoreFunc: ObservableObject {
  func createRecord(playerID: String, oldscore: [String], emojiPlusName: [String], names: [String], emojis: [String], editedScore: Int, reason: String, selectedName: Int) -> (Recordline) {
    var record = Recordline(playerID: "0", playerOneEmoji: "✨",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "",
                            recordNameStr: "recordNameStrGUAGUA", recordNameEmo: "💩")
    
    record.id = UUID().uuidString
    record.recordReason = reason
    record.recordEntryTime = Date()
    record.playerID = playerID
    record.playerOneEmoji = emojis[0]
    record.playerTwoEmoji = emojis[1]
    record.playerOneName = names[0]
    record.playerTwoName = names[1]
    record.recordEntryTimeString = getDateString(Date: record.recordEntryTime!)
    record.userId = Auth.auth().currentUser?.uid
    print("&&&&&UserID\(String(describing: record.userId))")
    
    if selectedName == 0 {
      record.playerOneScore = Int(oldscore[0])! + editedScore
      record.playerTwoScore = Int(oldscore[1])!
      record.recordName = emojiPlusName[0]
      record.recordNameStr = names[0]
      record.recordNameEmo = emojis[0]
    } else if selectedName == 1 {
      record.playerTwoScore = Int(oldscore[1])! + editedScore
      record.playerOneScore = Int(oldscore[0])!
      record.recordName = emojiPlusName[1]
      record.recordNameStr = names[1]
      record.recordNameEmo = emojis[1]
      
    }
    
    
    if String(editedScore).first == "-" || String(editedScore) == "0" {
      record.recordScore = String(editedScore)
    } else {
      record.recordScore = "+\(String(editedScore))"
    }
    print("saved record \(record)")
    return record
    
  }
  
}

class AddBetFunc: ObservableObject {
  func createBet(playerID: String, betScore: Int, betDescription: String) -> (BetRecord) {
    var bet = BetRecord(playerID: "0", betDescription: "Default Bet Description", betScore: "0", betEntryTime: Date(), betEntryTimeString: "")
    
    bet.id = UUID().uuidString
    bet.betDescription = betDescription
    bet.betEntryTime = Date()
    bet.playerID = playerID
    bet.betScore = String(betScore)
    bet.betEntryTimeString = getDateString(Date: bet.betEntryTime!)
    bet.userId = Auth.auth().currentUser?.uid
    print("&&&&&UserID\(String(describing: bet.userId))")
    print(bet)
    return bet
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

//1. Create a class for updating the observing views when the keyboard gets toggled
class KeyboardResponder: ObservableObject {
    
    //2. Keeping track off the keyboard's current height
    @Published var currentHeight: CGFloat = 0
   
    //3. We use the NotificationCenter to listen to system notifications
    var _center: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        _center = center
        //4. Tell the notification center to listen to the system keyboardWillShow and keyboardWillHide notification
        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //5.1. Update the currentHeight variable when the keyboards gets toggled
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            withAnimation {
               currentHeight = keyboardSize.height
            }
        }
    }

    //5.2 Update the currentHeight variable when the keyboards collapses
    @objc func keyBoardWillHide(notification: Notification) {
        withAnimation {
           currentHeight = 0
        }
    }
}





