//
//  NewHistoryViewModel.swift
//  Score1031
//
//  Created by Danting Li on 5/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import Combine
import Resolver

class ListViewModel: ObservableObject {
  @Published var scoreRepository: ScoreRepository = Resolver.resolve()
  @Published var cellViewModels = [CellViewModel]()
  private var cancellables = Set<AnyCancellable>()
    
  init() {
    scoreRepository.$records.map { records in
      records.map { record in
        CellViewModel(record: record)
      }
    }
    .assign(to: \.cellViewModels, on: self)
    .store(in: &cancellables)
  }
  
}


