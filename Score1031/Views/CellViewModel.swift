//
//  NewHistoryCellViewModel.swift
//  Score1031
//
//  Created by Danting Li on 6/8/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import Combine
import Resolver

class CellViewModel: ObservableObject, Identifiable  {
  @Published var record: Recordline
  @Injected var scoreRepository: ScoreRepository
    
  static func newTask() -> CellViewModel {
    CellViewModel(record: Recordline(playerID: "1", playerOneEmoji: "🥰", playerOneName: "Default1", playerOneScore: 0, playerTwoEmoji: "🥶", playerTwoName: "Default2", playerTwoScore: 0, recordName: "Default1", recordScore: "0", recordReason: "default reason", recordEntryTimeString: "default time", recordAddEdit: true))
  }
    
    init(record: Recordline) {
      self.record = record
        //self.scoreRepository = scoreRepository
    }
}
