//
//  DWView.swift
//  Score1031
//
//  Created by Danting Li on 6/30/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct DWView: View {
  @State private var records3 = APILoader.load()

  var body: some View {
    VStack {
      TextField("playerID", text: $records3.playerID)
      TextField("playerOneEmoji", text: $records3.playerOneEmoji)
      TextField("playerOneName", text: $records3.playerOneName)
      Button("Update", action: {
        APILoader.write(records3: self.records3)
      })
    }
  }
}
