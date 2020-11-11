//
//  ViewRouter.swift
//  Score1031
//
//  Created by Danting Li on 10/28/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewRouter: ObservableObject {

    init() {
      if
       // !UserDefaults.standard.bool(forKey: "didLaunchBefore") &&
          Auth.auth().currentUser?.uid == nil {
      //      UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "onboardingView"
        } else {
            currentPage = "tabBarView"
        }
    }
    
    @Published var currentPage: String
    
}
