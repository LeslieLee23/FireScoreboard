//
//  ScoreRepository.swift
//  Score1031
//
//  Created by Danting Li on 4/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation

class BaseScoreRepository {
  @Published var records = [Recordline]()
}

protocol ScoreRepository: BaseScoreRepository {
  func addTask(_ record: Recordline)
  func removeTask(_ record: Recordline)
  func updateTask(_ record: Recordline)
}

class TestDataScoreRepository: BaseScoreRepository, ScoreRepository, ObservableObject {
  override init() {
    super.init()
    self.records = testRecordline
  }
  
  func addTask(_ record: Recordline) {
    records.append(record)
  }
  
  func removeTask(_ record: Recordline) {
    if let index = records.firstIndex(where: { $0.id == record.id }) {
      records.remove(at: index)
    }
  }
  
  func updateTask(_ record: Recordline) {
    if let index = self.records.firstIndex(where: { $0.id == record.id } ) {
      self.records[index] = record
    }
  }
}
