//
//  UserLoader.swift
//  Score1031
//
//  Created by Danting Li on 10/31/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

class BaseUserRepository {
  @Published var user = [UserRecord]()
  @Published var user3 = UserRecord(id: "0", userId: "0", userEmoji: "userEmoji", userName: "userName", userCreateTime: Date())
}

protocol UserRepository: BaseUserRepository {
  func saveData(user3: UserRecord)
  func updateData(user: UserRecord)
  func getUserData() -> String
}

class UserLoader: BaseUserRepository, UserRepository, ObservableObject {

  private var db = Firestore.firestore()
  
  override init() {
    super.init()
    fetchUserData()
  }
  
  func fetchUserData() {
    let userId = Auth.auth().currentUser?.uid
    db.collection("user")
    .whereField("userId", isEqualTo: userId ?? "0")
      .addSnapshotListener {(querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("didn't find userid \(String(describing: Auth.auth().currentUser?.uid)) in firebase")
        return
      }
      self.user = documents.map {(queryDocumentSnapshot) -> UserRecord in
        let data = queryDocumentSnapshot.data()
        
        let id = data["id"] as? String ?? "no id"
        let userId = data["userId"] as? String ?? "no userID"
        let userEmoji = data["userEmoji"] as? String ?? "no userEmoji"
        let userName = data["userName"] as? String ?? "no userName"
        let timestamp: Timestamp = data["userCreateTime"] as! Timestamp
        let userCreateTime: Date = timestamp.dateValue()
        
        
        let abc = UserRecord(
                  id: id,
                  userId: userId,
                  userEmoji: userEmoji,
                  userName: userName,
                  userCreateTime: userCreateTime
        )
       // print("abc info load \(abc)")
        return abc
        
      }.sorted(by: { $0.userCreateTime! >= $1.userCreateTime!})
    }

  }

  func getUserData() -> String {
    let emojiSet = Set<String>(self.user.map{$0.userEmoji})
    print("emojiSet \(emojiSet)")
    return emojiSet.first ?? "NA"
   
  }


  func saveData(user3: UserRecord) {
    do {
      let newDocumentID = user3.id
      db.collection("user").document(newDocumentID).setData([
        "id": user3.id,
        "userId": user3.userId,
        "userEmoji": user3.userEmoji,
        "userName": user3.userName,
        "userCreateTime": Date()
        ])
      
      print("Yes yes user info saved!")
      
    }

    
    
   
  }
  
  func updateData(user: UserRecord) {
    let userID2 = user.id
    do {
      try db.collection("user").document(userID2).setData(from: user)
    }
    catch {
      fatalError("Unable to update data: \(error.localizedDescription)")
    }
    
  }
  
  func remove(id: String) -> Void {
    db.collection("user").whereField("id", isEqualTo: id).getDocuments { (querySnapshot, error) in
      if error != nil {
        print(error ?? "Remove error")
      } else {
        for document in querySnapshot!.documents {
          document.reference.delete()
        }
      }
    }
  }
}




