//
//  NewHistoryView.swift
//  Score1031
//
//  Created by Danting Li on 4/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct NewHistoryView: View {
    var tests: [Recordline] = testRecordline
    
    var body: some View {
        NavigationView { // (2)
          VStack(alignment: .leading) {
            List {
              ForEach (self.tests) { test in // (3)
                RecordView(name: test.recordName, score: test.recordScore, reason: test.recordReason, entryTime: test.recordEntryTimeString, playerID: test.playerID) // (6)
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
