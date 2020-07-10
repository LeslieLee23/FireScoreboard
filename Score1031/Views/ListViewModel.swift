//
//  NewHistoryViewModel.swift
//  Score1031
//
//  Created by Danting Li on 5/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//
//
//import Foundation
//import Combine
//import Resolver
//
//class ListViewModel: ObservableObject, Identifiable {
//  @Published var scoreRepository: ScoreRepository = Resolver.resolve()
//  @Published var cellViewModels = [CellViewModel]()
//  
//  init() {
//    scoreRepository.$records.map { records in
//      records.map { record in
//        CellViewModel(record: record)
//      }
//    }
//  }
//    func addTask(record: Recordline) {
//      scoreRepository.addTask(record)
//    }
//  
//}
//

