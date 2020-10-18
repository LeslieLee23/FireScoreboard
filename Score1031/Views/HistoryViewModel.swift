//
//  HistoryViewModel.swift
//  Score1031
//
//  Created by Danting Li on 10/18/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

class HistoryViewModel: ObservableObject {
  @Published var historyData: [Recordline] = []
  
  
  
  func fetchHistoryData(playerId: String) {
    let userId = Auth.auth().currentUser?.uid
    Firestore.firestore().collection("records")
    .whereField("userId", isEqualTo: userId ?? "")
      .addSnapshotListener {(querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
        var records = [Recordline]()
      records = documents.map {(queryDocumentSnapshot) -> Recordline in
        let data = queryDocumentSnapshot.data()
        
        let userId = data["userId"] as? String ?? ""
        let id = data["id"] as? String ?? ""
        let playerID = data["playerID"] as? String ?? ""
        let playerOneEmoji = data["playerOneEmoji"] as? String ?? ""
        let playerOneName = data["playerOneName"] as? String ?? ""
        let playerOneScore = data["playerOneScore"] as? Int ?? 0
        let playerTwoEmoji = data["playerTwoEmoji"] as? String ?? ""
        let playerTwoName = data["playerTwoName"] as? String ?? ""
        let playerTwoScore = data["playerTwoScore"] as? Int ?? 0
        let recordName = data["recordName"] as? String ?? ""
        let recordScore = data["recordScore"] as? String ?? ""
        let recordReason = data["recordReason"] as? String ?? ""
        let timestamp: Timestamp = data["recordEntryTime"] as! Timestamp
        let recordEntryTime: Date = timestamp.dateValue()
       // let recordEntryTime = data["recordEntryTime"] as? Date??
        let recordEntryTimeString = data["recordEntryTimeString"] as? String ?? ""
        let recordNameStr = data["recordNameStr"] as? String ?? ""
        let recordNameEmo = data["recordNameEmo"] as? String ?? ""
        let abc = Recordline(
          id: UUID(uuidString: id)!,
                  playerID: playerID,
                  playerOneEmoji: playerOneEmoji,
                  playerOneName: playerOneName,
                  playerOneScore: playerOneScore,
                  playerTwoEmoji: playerTwoEmoji,
                  playerTwoName: playerTwoName,
                  playerTwoScore: playerTwoScore,

                  recordName: recordName,
                  recordScore: recordScore,
                  recordReason: recordReason,
                  recordEntryTime: recordEntryTime,
                  recordEntryTimeString: recordEntryTimeString,
                  userId: userId,
                  recordNameStr: recordNameStr,
                  recordNameEmo: recordNameEmo
        )
        return abc
      }.sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})
        
        var filteredPlayerData = [Recordline]()
        
        for item in records {
          if item.playerID == playerId {
            filteredPlayerData.append(item)
          }
        }
        self.historyData = filteredPlayerData.sorted(by: { $0.recordEntryTime ?? Date() >= $1.recordEntryTime ?? Date()})
    
    }
  }
}
