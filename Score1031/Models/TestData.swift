//
//  Recordline.swift
//  Score1031
//
//  Created by Danting Li on 6/26/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation

struct Testdata: Codable //, Identifiable
{
    
  var id: String = UUID().uuidString
  var playerID: String
  var playerOneEmoji: String
  var playerOneName: String
 
}
