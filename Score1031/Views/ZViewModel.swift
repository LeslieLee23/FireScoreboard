//
//  ZViewModel.swift
//  Score1031
//
//  Created by Danting Li on 6/10/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ZViewModel: ObservableObject {
  @Published var scoreRepository: ScoreRepository = Resolver.resolve()
  @Published var record: Recordline
  init(scoreRepository: ScoreRepository, record: Recordline ) {
    self.scoreRepository = scoreRepository
    self.record = record
  }
  
}
