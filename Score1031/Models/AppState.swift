//
//  AppState.swift
//  Score1031
//
//  Created by Danting Li on 8/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
  @Published var selectedTab: TabBarView.Tab = .home
  var screenWidth  = UIScreen.main.bounds.width
  var screenHeight = UIScreen.main.bounds.height
  
  lazy var ratio = Int(floor(screenHeight / screenWidth)) //small: 1 big: 2
  lazy var scoreboradWidth = screenWidth * 0.9 //340
 
  lazy var scoreboradHeight = screenWidth * (0.56 + CGFloat(ratio) * 0.05) //0.61_0.66 -> 230_250
  
  lazy var scoreboradGap = scoreboradWidth  * (0.05 + CGFloat(ratio) * 0.02) //0.07_0.09 -> 20_30
  lazy var ScoreRowWidth = scoreboradWidth / 2.06 //165
  lazy var ScoreRowHeight = scoreboradHeight / 4.6 //55
  lazy var NameEmojiRowHeight = scoreboradHeight / 2 //125
  lazy var HistorySnapViewWidth = screenWidth * 0.84 //320
  lazy var HistorySnapViewHeight = screenWidth * 0.36 //135
  lazy var HistorySnapViewListWidth = screenWidth * 0.79 //290
  lazy var HistorySnapViewListHeight = screenWidth * (0.26 + CGFloat(ratio) * 0.025) //0.285 //0.31 //107//116
  lazy var HistorySnapViewListWidth280 = screenWidth * 0.75 //280
  lazy var HistorySnapViewListHeight50_63 = screenWidth * (0.096 + CGFloat(ratio) * 0.037) //0.133_0.170 -> 50_68
    
  lazy var BetSnapViewWidth = screenWidth * 0.84 //320
  lazy var BetSnapViewHeight = screenWidth * (0.28 + CGFloat(ratio) * 0.08) // 0.36_0.44 150_165
  lazy var BetSnapViewListWidth280 = screenWidth * 0.75 //280
  lazy var BetSnapViewListHeight50_75 = screenWidth * (0.067 + CGFloat(ratio) * 0.067) //0.133_0.2 -> 50_75
  lazy var TitleRowHeight = CGFloat(40) + CGFloat(ratio) * 20 //  -> 60_80
  
}




