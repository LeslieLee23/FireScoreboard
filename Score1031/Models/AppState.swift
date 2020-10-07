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
}


