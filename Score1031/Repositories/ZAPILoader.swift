//
//  ZAPILoader.swift
//  Score1031
//
//  Created by Danting Li on 7/14/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import Disk
import SwiftUI
import Combine

class ZAPILoader: ObservableObject {
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

extension ZAPILoader {
  static func queryPlayerList() -> [Recordline] {
    let recordSet = Set<String>(load().map{$0.playerID})
    print(recordSet)

    print("Look at this \(load())")

    var resultArray = [String]()

    for playerID in recordSet {
      let id = load().filter({$0.playerID == playerID}).map{$0.id}.first
      resultArray.append(id!)
    }
    /// Reset the array before quering it
    var filteredRecords3 = [Recordline]()

    for id in resultArray {
      if let filtered = load().filter({$0.id == id}).first {
        filteredRecords3.append(filtered) }
      else {
        var filteredRecords3 = [Recordline(playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "", recordAddEdit: true)]        
      }
    }
    print("The result of printing filteredRecords3 is \(filteredRecords3)")
    return filteredRecords3

  }
}

extension ZAPILoader {
  func loadOne() -> Recordline {
    let decoder = PropertyListDecoder()

    guard let data = try? Data.init(contentsOf: ZAPILoader.scoreURL),
      let records3 = try? decoder.decode(Recordline.self, from: data)
      else { return Recordline(playerID: "008", playerOneEmoji: "playerOneEmoji", playerOneName: "playerOneName"
        , playerOneScore: 0, playerTwoEmoji: "playerTwoEmoji", playerTwoName: "playerTwoName", playerTwoScore: 0, recordName: "recordName", recordScore: "999", recordReason: "biubiu", recordEntryTimeString: "recordEntryTimeString", recordAddEdit: true
        ) }

    return records3
  }
}

extension ZAPILoader {
  static func copyrecords3FromBundle() {
    if let path = Bundle.main.path(forResource: "api_records3", ofType: "plist"),
      let data = FileManager.default.contents(atPath: path),
      FileManager.default.fileExists(atPath: scoreURL.path) == false {

      FileManager.default.createFile(atPath: scoreURL.path, contents: data, attributes: nil)
    }
  }
}

extension ZAPILoader {
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

 

