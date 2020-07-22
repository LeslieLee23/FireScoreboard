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



