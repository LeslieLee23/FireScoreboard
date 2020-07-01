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
   
    @State private var records3 = APILoader.load()
    
    var body: some View {
        NavigationView {
          VStack(alignment: .leading) {
            List {
              //ForEach (self.records3) { records3 in
                RecordView(name: records3.playerID, score: records3.playerOneEmoji, reason: records3.playerOneName, entryTime: records3.playerOneName, playerID: records3.playerID)
              //}
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

