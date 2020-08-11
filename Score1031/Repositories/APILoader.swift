//
//  APILoader.swift
//  Score1031
//
//  Created by Danting Li on 7/28/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import Disk
import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

class BaseScoreRepository {
  @Published var records = [Recordline]()
  @Published var records3 = Recordline(playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "", recordAddEdit: true, recordNameStr: "recordNameStr", recordNameEmo: "👩🏻")
}

protocol ScoreRepository: BaseScoreRepository {
  func queryPlayerList() -> [Recordline]
  func findMaxPlayerID() -> Int
  func saveData(record3: Recordline)
}

class APILoader: BaseScoreRepository, ScoreRepository, ObservableObject {
  private var db = Firestore.firestore()
  
  override init() {
    super.init()
    fetchData()
  }
  
  func defaultValue() -> [Recordline] {
    let defaultValue = [Recordline(playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "", recordAddEdit: true, recordNameStr: "recordNameStr", recordNameEmo: "👩🏻")]
      return defaultValue
  }
  
  func fetchData() {
    let userId = Auth.auth().currentUser?.uid
  //  print ("%%%userId \(userId)")
    db.collection("records")
    .whereField("userId", isEqualTo: userId)
      .addSnapshotListener {(querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      self.records = documents.map {(queryDocumentSnapshot) -> Recordline in
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
        let recordAddEdit = data["recordAddEdit"] as? Bool ?? true
        let recordNameStr = data["recordNameStr"] as? String ?? ""
        let recordNameEmo = data["recordNameEmo"] as? String ?? ""
        let abc = Recordline(
                  id: id,
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
                  recordAddEdit: recordAddEdit,
                  userId: userId,
                  recordNameStr: recordNameStr,
                  recordNameEmo: recordNameEmo
        )
        return abc
      }.sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})
    }
  }
  func queryPlayerList() -> [Recordline] {
    let recordSet = Set<String>(self.records.map{$0.playerID})

    var resultArray = [String]()

    for playerID in recordSet {
      let id = self.records.filter({$0.playerID == playerID}).map{$0.id}.first
      resultArray.append(id!)

    }
    /// Reset the array before quering it
    var filteredRecords3 = [Recordline]()

    for id in resultArray {
      if let filtered = self.records.filter({$0.id == id}).first {
        filteredRecords3.append(filtered) }
      else {
        let filteredRecords3 = [Recordline(playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "", recordAddEdit: true, recordNameStr: "recordNameStr", recordNameEmo: "👩🏻")]
      }
    }
    return filteredRecords3.sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})

  }
  
  func findMaxPlayerID() -> Int {
    let maxPlayerIDInt = self.records.map{Int($0.playerID)!}.max()
    let maxPlayerID = String(maxPlayerIDInt ?? 0)
    print("&&&\(maxPlayerIDInt)")
    return maxPlayerIDInt ?? 0
  }
  
  func saveData(record3: Recordline) {
    do {

      db.collection("records").addDocument(data: ["id": record3.id, "playerID": record3.playerID, "playerOneEmoji": record3.playerOneEmoji,"playerOneName": record3.playerOneName, "playerOneScore": record3.playerOneScore, "playerTwoEmoji": record3.playerTwoEmoji, "playerTwoName": record3.playerTwoName, "playerTwoScore": record3.playerTwoScore, "recordName": record3.recordName, "recordScore": record3.recordScore, "recordReason": record3.recordReason, "recordEntryTime": Date(), "recordEntryTimeString": record3.recordEntryTimeString, "recordAddEdit": record3.recordAddEdit, "userId": record3.userId!, "recordNameStr": record3.recordNameStr!, "recordNameEmo": record3.recordNameEmo! ])
      
      print("Yes yes yes this works!")
      
    } catch{
      print("NONONO This didn't work!")
    }
    
    
   
  }
  
   func remove() -> Void {
    db.collection("records").getDocuments { (querySnapshot, error) in
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





 
