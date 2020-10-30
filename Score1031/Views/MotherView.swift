//
//  MotherView.swift
//  Score1031
//
//  Created by Danting Li on 10/28/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit

struct MotherView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var appState: AppState
  
    var body: some View {
        VStack {
            if viewRouter.currentPage == "onboardingView" {
                OnboardingView()
            } else if viewRouter.currentPage == "tabBarView" {
              TabBarView()
                .environmentObject(ViewRouter())
                .environmentObject(NameAndScore())
                .environmentObject(UserData())
                .environmentObject(AddScoreFunc())
                .environmentObject(appState)
                .environmentObject(AddBetFunc())
                .environmentObject(observed())
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
