//
//  BetRecord.swift
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

struct BetRecord: Codable , Identifiable
{
  var id: String = UUID().uuidString
  var playerID: String
  var betDescription: String
  var betScore: String
  var betEntryTime: Date?
  var betEntryTimeString: String
  var userId: String?
  var winnerName: String?
  var winnerNameStr: String?
  var winnerNameEmo: String?
}

