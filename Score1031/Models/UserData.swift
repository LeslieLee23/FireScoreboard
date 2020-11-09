//
//  UserData.swift
//  Score1031
//
//  Created by Danting Li on 11/19/19.
//  Copyright © 2019 HULUCave. All rights reserved.
//

import SwiftUI
import Combine

class UserData: ObservableObject {
  
  @Published var emojiPlusName: [String] = UserDefaults.standard.stringArray(forKey: "emojiPlusName") ?? ["👩🏻 Player One", "👨🏻 Player Two"] {
    didSet {
      UserDefaults.standard.set(self.emojiPlusName, forKey: "emojiPlusName")
    }
  }
  
  @Published var oldscore: [String] = UserDefaults.standard.stringArray(forKey: "oldscore") ?? ["0", "0"] {
    didSet {
      UserDefaults.standard.set(self.oldscore, forKey: "oldscore")
    }
  }
  
  @Published var names: [String] = UserDefaults.standard.stringArray(forKey: "names") ?? ["Player One", "Player Two"] {
    didSet {
      UserDefaults.standard.set(self.names, forKey: "names")
    }
  }
  
  @Published var emojis: [String] = UserDefaults.standard.stringArray(forKey: "emojis") ?? ["👩🏻", "👨🏻"] {
    didSet {
      UserDefaults.standard.set(self.emojis, forKey: "emojis")
    }
  }
  
  @Published var editMode: Bool = UserDefaults.standard.bool(forKey: "editMode") {
    didSet {
      UserDefaults.standard.set(self.editMode, forKey: "editMode")
    }
  }
  
  @Published var showEmoji: Bool = UserDefaults.standard.bool(forKey: "showEmoji") {
    didSet {
      UserDefaults.standard.set(self.showEmoji, forKey: "showEmoji")
    }
  }
  
  @Published var playerID = UserDefaults.standard.string(forKey: "playerID") ?? "0" {
    didSet {
      UserDefaults.standard.set(self.playerID, forKey: "playerID")
    }
  }
  
  @Published var maxPlayerID = UserDefaults.standard.integer(forKey: "maxPlayerID") {
    didSet {
      UserDefaults.standard.set(self.maxPlayerID, forKey: "maxPlayerID")
    }
  }
  
  @Published var selectedName: Int = UserDefaults.standard.integer(forKey: "selectedName") {
    didSet {
      UserDefaults.standard.set(self.selectedName, forKey: "selectedName")
    }
  }
  
  @Published var addPlayerOneName = UserDefaults.standard.string(forKey: "addPlayerOneName") ?? ("") {
    didSet {
      UserDefaults.standard.set(self.addPlayerOneName, forKey: "addPlayerOneName")
    }
  }
  
  @Published var addPlayerOneEmoji = UserDefaults.standard.string(forKey: "addPlayerOneEmoji") ?? ("") {
    didSet {
      UserDefaults.standard.set(self.addPlayerOneEmoji, forKey: "addPlayerOneEmoji")
    }
  }
  
  @Published var addPlayerTwoName = UserDefaults.standard.string(forKey: "addPlayerTwoName") ?? ("") {
    didSet {
      UserDefaults.standard.set(self.addPlayerTwoName, forKey: "addPlayerTwoName")
    }
  }
  
  @Published var addPlayerTwoEmoji = UserDefaults.standard.string(forKey: "addPlayerTwoEmoji") ?? ("") {
    didSet {
      UserDefaults.standard.set(self.addPlayerTwoEmoji, forKey: "addPlayerTwoEmoji")
    }
  }
  
  @Published var betWinnerName: Int = UserDefaults.standard.integer(forKey: "betWinnerName") {
    didSet {
      UserDefaults.standard.set(self.betWinnerName, forKey: "betWinnerName")
    }
  }
  
  @Published var deleteMode: Bool = UserDefaults.standard.bool(forKey: "deleteMode") {
    didSet {
      UserDefaults.standard.set(self.deleteMode, forKey: "deleteMode")
    }
  }
  
  @Published var onboardingStage = UserDefaults.standard.string(forKey: "onboardingStage") ?? ("1") {
    didSet {
      UserDefaults.standard.set(self.onboardingStage, forKey: "onboardingStage")
    }
  }
  
  @Published var userEmoji = UserDefaults.standard.string(forKey: "userEmoji") {
    didSet {
      UserDefaults.standard.set(self.userEmoji, forKey: "userEmoji")
    }
  }
  
  @Published var userName = UserDefaults.standard.string(forKey: "userName") {
    didSet {
      UserDefaults.standard.set(self.userName, forKey: "userName")
    }
  }
  
  @Published var userUid = UserDefaults.standard.string(forKey: "userUid") {
    didSet {
      UserDefaults.standard.set(self.userUid, forKey: "userUid")
    }
  }
  
  @Published var newUserEmoji = UserDefaults.standard.string(forKey: "newUserEmoji") ?? "" {
    didSet {
      UserDefaults.standard.set(self.newUserEmoji, forKey: "newUserEmoji")
    }
  }
  
  @Published var newUserName = UserDefaults.standard.string(forKey: "newUserName") ?? "" {
    didSet {
      UserDefaults.standard.set(self.newUserName, forKey: "newUserName")
    }
  }
  
  @Published var signedInWithApple: Bool = UserDefaults.standard.bool(forKey: "signedInWithApple") {
    didSet {
      UserDefaults.standard.set(self.signedInWithApple, forKey: "signedInWithApple")
    }
  }
  
  @Published var profileMode: Bool = UserDefaults.standard.bool(forKey: "profileMode") {
    didSet {
      UserDefaults.standard.set(self.profileMode, forKey: "profileMode")
    }
  }
  
  @Published var profileEditMode: Bool = UserDefaults.standard.bool(forKey: "profileEditMode") {
    didSet {
      UserDefaults.standard.set(self.profileEditMode, forKey: "profileEditMode")
    }
  }
  
}
