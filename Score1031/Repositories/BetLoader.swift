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
//  func findMaxPlayerID() -> Int
  func saveData(bets3: BetRecord)
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
    .whereField("userId", isEqualTo: userId)
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
        
        
        let abc = BetRecord(
                  id: id,
                  playerID: playerID,
                  betDescription: betDescription,
                  betScore: betScore,
                  betEntryTime: betEntryTime,
                  betEntryTimeString: betEntryTimeString,
                  userId: userId
        )
        return abc
      }.sorted(by: { $0.betEntryTime! >= $1.betEntryTime!})
    }
  }

  func saveData(bets3: BetRecord) {
    do {

      db.collection("bets").addDocument(data: [
        "id": bets3.id,
        "playerID": bets3.playerID,
        "betDescription": bets3.betDescription,
        "betScore": bets3.betScore,
        "betEntryTime": Date(),
        "betEntryTimeString": bets3.betEntryTimeString,
        "userId": bets3.userId ?? "0"])
      
      print("Yes yes bet this works!")
      
    } catch{
      print("NONONO This didn't work!")
    }
    
    
   
  }
  
   func remove() -> Void {
    db.collection("bets").getDocuments { (querySnapshot, error) in
      if error != nil {
        print(error)
      } else {
        for document in querySnapshot!.documents {
          document.reference.delete()
        }
      }
    }
  }
}





 


