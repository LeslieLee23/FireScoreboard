//
//  BetLoader.swift
//  Score1031
//
//  Created by Danting Li on 9/7/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

class BaseBetRepository {
  @Published var bets = [BetRecord]()
  @Published var bets3 = BetRecord(playerID: "0", betDescription: "Default Bet Description", betScore: "0", betEntryTime: Date(), betEntryTimeString: "")
}

protocol BetRepository: BaseBetRepository {
  func saveData(bets3: BetRecord)
  func updateData(bets: BetRecord)
}

class BetLoader: BaseBetRepository, BetRepository, ObservableObject {

  private var db = Firestore.firestore()
  
  override init() {
    super.init()
    fetchBetData()
  }
  
  func fetchBetData() {
    let userId = Auth.auth().currentUser?.uid
    db.collection("bets")
    .whereField("userId", isEqualTo: userId ?? "0")
      .addSnapshotListener {(querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      self.bets = documents.map {(queryDocumentSnapshot) -> BetRecord in
        let data = queryDocumentSnapshot.data()
        let userId = data["userId"] as? String ?? ""
        let id = data["id"] as? String ?? ""
        let playerID = data["playerID"] as? String ?? ""
        let betDescription = data["betDescription"] as? String ?? ""
        let betScore = data["betScore"] as? String ?? ""
        let timestamp: Timestamp = data["betEntryTime"] as! Timestamp
        let betEntryTime: Date = timestamp.dateValue()
        let betEntryTimeString = data["betEntryTimeString"] as? String ?? ""
        let winnerName = data["winnerName"] as? String
        let winnerNameStr = data["winnerNameStr"] as? String
        let winnerNameEmo = data["winnerNameEmo"] as? String
        
        let abc = BetRecord(
                  id: id,
                  playerID: playerID,
                  betDescription: betDescription,
                  betScore: betScore,
                  betEntryTime: betEntryTime,
                  betEntryTimeString: betEntryTimeString,
                  userId: userId,
                  winnerName: winnerName,
                  winnerNameStr: winnerNameStr,
                  winnerNameEmo: winnerNameEmo
        )
        return abc
        
      }.sorted(by: { $0.betEntryTime! >= $1.betEntryTime!})
    }
  }
  
  func fetchOngoingBet(_ playerID: String) -> [BetRecord] {
    let betsCopy = self.bets
    var pastPlayerData = [BetRecord]()
    
    for item in betsCopy {
      if item.winnerName == nil && item.playerID == playerID {
        pastPlayerData.append(item)
      }
    }
    return pastPlayerData.sorted(by: {
      $0.betEntryTime! >= $1.betEntryTime!
    })
  }
  
  func fetchPastBet(_ playerID: String) -> [BetRecord] {
    let betsCopy = self.bets
    var pastPlayerData = [BetRecord]()
    
    for item in betsCopy {
      if item.winnerName != nil && item.playerID == playerID {
        pastPlayerData.append(item)
      }
    }
    return pastPlayerData.sorted(by: {
      $0.betEntryTime! >= $1.betEntryTime!
    })
  }

  func saveData(bets3: BetRecord) {
    do {
      let newDocumentID = bets3.id
      db.collection("bets").document(newDocumentID).setData([
        "id": bets3.id,
        "playerID": bets3.playerID,
        "betDescription": bets3.betDescription,
        "betScore": bets3.betScore,
        "betEntryTime": Date(),
        "betEntryTimeString": bets3.betEntryTimeString,
        "userId": bets3.userId ?? "0"])
      
      print("Yes yes this bet works!")
      
    }
//    catch{
//      print("NONONO This didn't work!")
//    }
    
    
   
  }
  
  func updateData(bets: BetRecord) {
    let betID = bets.id
    do {
      try db.collection("bets").document(betID).setData(from: bets)
    }
    catch {
      fatalError("Unable to update data: \(error.localizedDescription)")
    }
    
  }
  func remove(id: String) -> Void {
    db.collection("bets").whereField("id", isEqualTo: id).getDocuments { (querySnapshot, error) in
      if error != nil {
        print(error ?? "Remove error")
      } else {
        for document in querySnapshot!.documents {
          document.reference.delete()
        }
      }
    }
  }
}





 


