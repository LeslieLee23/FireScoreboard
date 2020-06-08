//
//  NewHistoryCellViewModel.swift
//  Score1031
//
//  Created by Danting Li on 6/8/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import Combine

class CellViewModel: ObservableObject, Identifiable  {
  @Published var record: Recordline
  var id: String = ""
  private var cancellables = Set<AnyCancellable>()
    
    init(record: Recordline) {
      self.record = record

      $record
        .map { $0.id }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
}
