//
//  ScoreRepository.swift
//  Score1031
//
//  Created by Danting Li on 4/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import Disk

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

//Disk added
class LocalScoreRepository: BaseScoreRepository, ScoreRepository, ObservableObject {
  override init() {
    super.init()
    loadData()
  }
  
  func addTask(_ record: Recordline) {
    self.records.append(record)
    saveData()
  }
  
  func removeTask(_ record: Recordline) {
    if let index = records.firstIndex(where: { $0.id == record.id }) {
      records.remove(at: index)
      saveData()
    }
  }
  
  func updateTask(_ record: Recordline) {
    if let index = self.records.firstIndex(where: { $0.id == record.id } ) {
      self.records[index] = record
      saveData()
    }
  }
  
  private func loadData() {
    if let retrievedScores = try? Disk.retrieve("scores.json", from: .documents, as: [Recordline].self) {
      self.records = retrievedScores
    }
  }
  
  private func saveData() {
    do {
      try Disk.save(self.records, to: .documents, as: "scores.json")
    }
    catch let error as NSError {
      fatalError("""
        Domain: \(error.domain)
        Code: \(error.code)
        Description: \(error.localizedDescription)
        Failure Reason: \(error.localizedFailureReason ?? "")
        Suggestions: \(error.localizedRecoverySuggestion ?? "")
        """)
    }
  }
}
