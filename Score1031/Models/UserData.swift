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
  
  @Published var emojiPlusName: [String] = UserDefaults.standard.stringArray(forKey: "emojiPlusName") ?? ["A", "B"] {
      didSet {
          UserDefaults.standard.set(self.emojiPlusName, forKey: "emojiPlusName")
      }
  }
  
  @Published var oldscore: [String] = UserDefaults.standard.stringArray(forKey: "oldscore") ?? ["A", "B"] {
      didSet {
          UserDefaults.standard.set(self.oldscore, forKey: "oldscore")
      }
  }
  
  @Published var names: [String] = UserDefaults.standard.stringArray(forKey: "names") ?? ["A", "B"] {
      didSet {
          UserDefaults.standard.set(self.names, forKey: "names")
      }
  }
  
  @Published var emojis: [String] = UserDefaults.standard.stringArray(forKey: "emojis") ?? ["A", "B"] {
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
  
    @Published var betState: Int = UserDefaults.standard.integer(forKey: "betState") {
        didSet {
            UserDefaults.standard.set(self.betState, forKey: "betState")
          // 0 stands for no ongoing or past bet
          // 1 stands for ongoing bet avaliable
          // 2 stands for no ongoing bet avaliable but past bet is avaliable
        }
    }
}
