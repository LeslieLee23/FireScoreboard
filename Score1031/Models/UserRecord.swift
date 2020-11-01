//
//  UserRecord.swift
//  Score1031
//
//  Created by Danting Li on 10/31/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserRecord: Codable , Identifiable
{
  var id: String = UUID().uuidString
  var userId: String
  var userEmoji: String
  var userName: String
  var userCreateTime: Date?
}
