//
//  NewHistoryView.swift
//  Score1031
//
//  Created by Danting Li on 4/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Foundation
import Resolver

struct NewHistoryView: View {
    @ObservedObject var ListVM = ListViewModel()
    var tests: [Recordline] = testRecordline

    
    var body: some View {
        NavigationView {
          VStack(alignment: .leading) {
            List {
              ForEach (self.tests) { test in
                RecordView(name: test.recordName, score: test.recordScore, reason: test.recordReason, entryTime: test.recordEntryTimeString, playerID: test.playerID)
              }
            }

          }
          .navigationBarTitle("Tests")
        }

    }
}

struct NewHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewHistoryView()
    }
}
