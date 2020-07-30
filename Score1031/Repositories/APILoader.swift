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

class APILoader: ObservableObject {
  @Published var records = [Recordline]()
  private var db = Firestore.firestore()
  
  func fetchData() {
    db.collection("records").addSnapshotListener {(querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
      self.records = documents.map {(queryDocumentSnapshot) -> Recordline in
        let data = queryDocumentSnapshot.data()
      //  print ("%%%data \(data)")
        
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
        let recordEntryTime = Date() //data["recordEntryTime"] as? Date?
        let recordEntryTimeString = data["recordEntryTimeString"] as? String ?? ""
        let recordAddEdit = data["recordAddEdit"] as? Bool ?? true
        
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
                  recordAddEdit: recordAddEdit
        )
        
        print("this is abc \(abc)")
        return abc
      }
    }
  }
  
  static private var scoreURL: URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documents.appendingPathComponent("scores.json")
  }

  static func load() -> [Recordline] {
    
    guard let records3 = try? Disk.retrieve("scores.json", from: .documents, as: [Recordline].self).sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})
      else {
        print("error in retriving data, default values shown")
        return [Recordline(playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "", recordAddEdit: true)]
    }
    return records3
  }
  
}

extension APILoader {
  static func queryPlayerList() -> [Recordline] {
    let recordSet = Set<String>(load().map{$0.playerID})
    print("###SET \(recordSet)")

    print("###Full List\(load())")

    var resultArray = [String]()

    for playerID in recordSet {
      let id = load().filter({$0.playerID == playerID}).map{$0.id}.first
      resultArray.append(id!)
      print("###What to Append\(String(describing: id))")
    }
    /// Reset the array before quering it
    var filteredRecords3 = [Recordline]()

    for id in resultArray {
      if let filtered = load().filter({$0.id == id}).first {
        filteredRecords3.append(filtered) }
      else {
        let filteredRecords3 = [Recordline(playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "", recordAddEdit: true)]
      }
    }
    print("The result of printing filteredRecords3 is \(filteredRecords3)")
    return filteredRecords3

  }
}

extension APILoader {
  static func findMaxPlayerID() -> Int {
    let maxPlayerIDInt = load().map{Int($0.playerID)!}.max()
    let maxPlayerID = String(maxPlayerIDInt ?? 0)
    print("&&&\(maxPlayerIDInt)")
    return maxPlayerIDInt!
  }
}

extension APILoader {
  static func saveData(record: Recordline) {
    do {
  //    try Disk.append(record, to: "scores.json", in: .documents)
      print("Yes yes yes this works!")
      ///save to Firebase
      let db = Firestore.firestore()
      db.collection("records").addDocument(data: ["id": record.id, "playerID": record.playerID, "playerOneEmoji": record.playerOneEmoji,"playerOneName": record.playerOneName, "playerOneScore": record.playerOneScore, "playerTwoEmoji": record.playerTwoEmoji, "playerTwoName": record.playerTwoName, "playerTwoScore": record.playerTwoScore, "recordName": record.recordName, "recordScore": record.recordScore, "recordReason": record.recordReason, "recordEntryTime": Date(), "recordEntryTimeString": record.recordEntryTimeString, "recordAddEdit": record.recordAddEdit])
      
    } catch{
      print("NONONO This didn't work!")
    }
    
    
   
  }
}

extension APILoader {
  static func copyrecords3FromBundle() {
    if let path = Bundle.main.path(forResource: "api_records3", ofType: "plist"),
      let data = FileManager.default.contents(atPath: path),
      FileManager.default.fileExists(atPath: scoreURL.path) == false {

      FileManager.default.createFile(atPath: scoreURL.path, contents: data, attributes: nil)
    }
  }
}

extension APILoader {
  static func write(records3: Recordline) {
    let encoder = PropertyListEncoder()

    if let data = try? encoder.encode(records3) {
      if FileManager.default.fileExists(atPath: scoreURL.path) {
        // Update an existing plist
        try? data.write(to: scoreURL)
      } else {
        // Create a new plist
        FileManager.default.createFile(atPath: scoreURL.path, contents: data, attributes: nil)
      }
    }
  }
}

 

