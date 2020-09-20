//
//  BetSnapViewModel.swift
//  Score1031
//
//  Created by Danting Li on 9/20/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetSnapViewModel: View {
  @ObservedObject var betLoader = BetLoader()
   @State var bets3: BetRecord = BetRecord(id: "110", playerID: "0", betDescription: "Default Bet Description", betScore: "0", betEntryTime: Date(), betEntryTimeString: "")
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BetSnapViewModel_Previews: PreviewProvider {
    static var previews: some View {
        BetSnapViewModel()
    }
}
