//
//  APILoader.swift
//  Score1031
//
//  Created by Danting Li on 6/23/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation

class APILoader {
  static private var plistURL: URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documents.appendingPathComponent("api_records3.plist")
  }

  static func load() -> Testdata {
    let decoder = PropertyListDecoder()

    guard let data = try? Data.init(contentsOf: plistURL),
      let records3 = try? decoder.decode(Testdata.self, from: data)
      else { return Testdata(playerID: "008", playerOneEmoji: "playerOneEmoji", playerOneName: "playerOneName"
//        , playerOneScore: 0, playerTwoEmoji: "playerTwoEmoji", playerTwoName: "playerTwoName", playerTwoScore: 0, recordName: "recordName", recordScore: "999", recordReason: "biubiu", recordEntryTimeString: "recordEntryTimeString", recordAddEdit: true
        ) }

    return records3
  }
}

extension APILoader {
  static func copyrecords3FromBundle() {
    if let path = Bundle.main.path(forResource: "api_records3", ofType: "plist"),
      let data = FileManager.default.contents(atPath: path),
      FileManager.default.fileExists(atPath: plistURL.path) == false {

      FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
    }
  }
}

extension APILoader {
  static func write(records3: Testdata) {
    let encoder = PropertyListEncoder()

    if let data = try? encoder.encode(records3) {
      if FileManager.default.fileExists(atPath: plistURL.path) {
        // Update an existing plist
        try? data.write(to: plistURL)
      } else {
        // Create a new plist
        FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
      }
    }
  }
}
