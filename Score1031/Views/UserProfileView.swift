//
//  UserProfileView.swift
//  Score1031
//
//  Created by Danting Li on 11/4/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import Firebase

struct UserProfileView: View {
  @EnvironmentObject var viewRouter: ViewRouter
  @EnvironmentObject var userData: UserData
  @EnvironmentObject var appState: AppState
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var apiLoader = APILoader()
  @ObservedObject var betLoader = BetLoader()
  @ObservedObject var userLoader = UserLoader()
  @State private var user3 = UserLoader().user3
  @State var coordinator: SignInWithAppleCoordinator?
  @State var records = [Recordline]()
  @State var showAlert = false
  @State var email = ""
  
  var body: some View {
    VStack {
      if userData.profileEditMode == false {
        ///Profile View
        ZStack{
          Color.offWhite02.edgesIgnoringSafeArea(.all)
          
          VStack {
            ///header row
            VStack {
              Spacer()
              HStack {
                Button(action: {
                  self.userData.profileEditMode = true
                })
                {
                  Image(systemName: "square.and.pencil")
                    .font(Font.system(size: 20, weight: .regular))
                  Text("Edit")
                }
                //.padding(.leading, 15)
                Spacer()
                Button(action: {
                  self.userData.profileMode = false
                })
                {
                  Text("Done")
                    .font(Font.system(size: 20, weight: .regular))
                }
                // .padding(.trailing, 15)
              }
              
            }.frame(width:350, height: 50, alignment: .top)
            ///header row
            VStack {
              Spacer()
            }.frame(width:350, height: 50, alignment: .top)
            
            ///User info row
            if self.userData.signedInWithApple == true && self.email != "" {
              VStack {
                RoundedRectangle(cornerRadius: 30)
                  .fill(Color.offWhite02)
                  .shadow(color: Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
                  .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
                  .frame(width: 270, height: 210)
                  .overlay(
                    VStack {
                      Text(self.userData.userEmoji ?? "👽")
                        .font(.system(size: 65))
                        .padding(.bottom, 10)
                      Text(self.userData.userName ?? "Anonymous")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color.offblack03)
                      Text(self.email)
                        .font(.system(size: 16))
                        .foregroundColor(Color.offblack01)
                        .padding(.top, 15)
                    }
                  )
                
              }
            } else {
              VStack {
                RoundedRectangle(cornerRadius: 30)
                  .fill(Color.offWhite02)
                  .shadow(color: Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
                  .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
                  .frame(width: 250, height: 190)
                  .overlay(
                    VStack {
                      Text(self.userData.userEmoji ?? "👽")
                        .font(.system(size: 65))
                        .padding(.bottom, 10)
                      Text(self.userData.userName ?? "Anonymous")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .foregroundColor(Color.offblack03)
                    }
                  )
              }
            }///User info row
            
            Spacer()
            if !self.userData.signedInWithApple {
              Text("You are not signed in yet ")
              
              SignInWithAppleButton()
                .frame(width: 260, height: 45)
                .onTapGesture {
                  self.coordinator = SignInWithAppleCoordinator()
                  if let coordinator = self.coordinator {
                    coordinator.startSignInWithAppleFlow {
                      print("You successfully signed in")
                      ///Here you are signing in from anonymous user to an Apple ID, therefore we need to bring in all the saved data in this anonymous account to Apple. Migrate everything from here to that Apple account. The way to do this by modifying the playerID or user id of the Anonymous user data and make the system think these are changed to be the appleID data. Now the question is what is the Key value that makes a system think this data is added to the fetch group? Answer: Auth.auth().currentUser?.uid.
                      
                      for record in self.apiLoader.records {
                        print("record?????????????? \(record)")
                        var record3 = record
                        record3.userId = Auth.auth().currentUser?.uid
                        record3.playerID = "\(String(describing: record.userId))*\(record3.playerID)"
                        self.userData.playerID = record3.playerID
                        print("record3 \(record3)")
                        self.apiLoader.updateData(record3: record3)
                      }
                      
                      print("self.betLoader.bets \(self.betLoader.bets)")
                      
                      for bet in self.betLoader.bets {
                        print("bet??????????????\(bet)")
                        var bet3 = bet
                        bet3.userId = Auth.auth().currentUser?.uid
                        bet3.playerID = "\(String(describing: bet.userId))*\(bet3.playerID)"
                        print("bet3 \(bet3)")
                        self.betLoader.updateData(bets: bet3)
                      }
                      /// Delete current user data
                      for user in self.userLoader.user {
                        print("self.userLoader.user \(user)")
                        self.userLoader.remove(id: user.id)
                        
                      }
                      /// Update existing Signed in with Apple user data
                      self.user3.id = Auth.auth().currentUser?.uid ?? "No userUid"
                      
                      self.user3.userEmoji = self.userData.userEmoji ?? ""
                      self.user3.userName = self.userData.userName ?? ""
                      self.user3.userId = Auth.auth().currentUser?.uid ?? "No userUid"
                      print("This is user33333 \(user3)")
                      self.userLoader.updateData(user: self.user3)
                      
                      self.userData.userUid = Auth.auth().currentUser?.uid
                      self.userData.signedInWithApple = true
                      self.userData.profileMode = false
                      print("You successfully excuted in")
                    }
                  }
                }
              Text("* Sign in with Apple to sync everything across your devices. ")
                .font(.system(size: 13))
                .foregroundColor(Color.gray)
                .frame(width: 260, height: 45)
              VStack(alignment: .leading) {
                HStack {
                  Button(action: {
                    self.showAlert = true
                    print("self.userData.userUid before: \(String(describing: self.userData.userUid))")
                  }) {
                    Text("Delete profile")
                      .italic()
                      .font(.system(size:15))
                      .foregroundColor(Color.lightPurple)
                  }.padding(.leading)
                  .alert(isPresented: self.$showAlert) { () ->
                    Alert in
                    
                    return Alert(title: Text("Are you sure?"), message: Text("Once you delete this profile, all data linked to this account will be permanently erased."), primaryButton: .destructive(Text("Confirm"))
                                  {
                                    do {
                                      for record in self.apiLoader.records {
                                        print("record?????????????? \(record)")
                                        self.apiLoader.removeUser(id: record.id)
                                      }
                                      
                                      for bet in self.betLoader.bets {
                                        print("bet?????????????? \(bet)")
                                        self.betLoader.remove(id: bet.id)
                                      }
                                      
                                      for user in self.userLoader.user {
                                        print("user?????????????? \(user)")
                                        self.userLoader.remove(id: user.id)
                                      }
                                      
                                      try Auth.auth().signOut()
                                      self.userData.signedInWithApple = false
                                      self.userData.userEmoji = nil
                                      self.userData.userName = nil
                                      print("Sign out of apple pressed: Auth.auth().currentUser?.uid \(String(describing: Auth.auth().currentUser?.uid))")
                                      self.viewRouter.currentPage = "onboardingView"
                                      
                                    } catch let err {
                                      print(err)
                                    }
                                    self.userData.finishedOnboarding = false
                                  }, secondaryButton: .cancel(){
                                    
                                  }
                    )
                  }
                  
                  Spacer()
                }.frame(width: 270, height: 50)
              }.padding(.top, 50)
            } else {
              Text("You are signed in with Apple")
                .padding(.top, 32)
              VStack(alignment: .leading) {
                HStack {
                  Button(action: {
                    do {
                      try Auth.auth().signOut()
                      self.userData.signedInWithApple = false
                      self.userData.userEmoji = nil
                      self.userData.userName = nil
                      print("Sign out pressed: Auth.auth().currentUser?.uid \(String(describing: Auth.auth().currentUser?.uid))")
                      self.viewRouter.currentPage = "onboardingView"
                    } catch let err {
                      print(err)
                    }
                    self.userData.finishedOnboarding = false
                  }) {
                    Text("Sign Out")
                  }
                  .padding(.leading)
                  .font(.system(size:17))
                  Spacer()
                }.frame(width: 270, height: 50)
              }.padding(.top, 50)
              
              HStack {
                Button(action: {
                  self.showAlert = true
                  print("self.userData.userUid before: \(String(describing: self.userData.userUid))")
                }) {
                  Text("Delete profile")
                    .italic()
                    .font(.system(size:15))
                    .foregroundColor(Color.lightPurple)
                }.padding(.leading)
                .alert(isPresented: self.$showAlert) { () ->
                  Alert in
                  
                  return Alert(title: Text("Are you sure?"), message: Text("Once you delete this profile, all data linked to this account will be permanently erased."), primaryButton: .destructive(Text("Confirm"))
                                {
                                  do {
                                    for record in self.apiLoader.records {
                                      print("record?????????????? \(record)")
                                      self.apiLoader.removeUser(id: record.id)
                                    }
                                    
                                    for bet in self.betLoader.bets {
                                      print("bet?????????????? \(bet)")
                                      self.betLoader.remove(id: bet.id)
                                    }
                                    
                                    for user in self.userLoader.user {
                                      print("user?????????????? \(user)")
                                      self.userLoader.remove(id: user.id)
                                    }
                                    
                                    try Auth.auth().signOut()
                                    self.userData.signedInWithApple = false
                                    self.userData.userEmoji = nil
                                    self.userData.userName = nil
                                    print("Sign out of apple pressed: Auth.auth().currentUser?.uid \(String(describing: Auth.auth().currentUser?.uid))")
                                    self.viewRouter.currentPage = "onboardingView"
                                    
                                  } catch let err {
                                    print(err)
                                  }
                                  self.userData.finishedOnboarding = false
                                }, secondaryButton: .cancel(){
                                  
                                }
                  )
                }
                Spacer()
              }.frame(width: 270, height: 50)
            }
            Spacer()
            Spacer()
          }
        }
        .onTapGesture {
          endEditing()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .onAppear() {
          self.userData.profileEditMode = false
          print("self.userData.userEmoji \(self.userData.userEmoji ?? "empty")")
          print("self.userData.userName \(self.userData.userName ?? "empty")")
          print("self.userData.userUid \(self.userData.userUid ?? "empty")")
          print("self.userData.signedInWithApple \(self.userData.signedInWithApple)")
          
          let user = Auth.auth().currentUser
          if let user = user {
            
            let uid = user.uid
            let email = user.email
            print("uid \(uid)")
            print("email \(String(describing: email))")
            self.email = user.email ?? ""
          }
          
        }
      }///Profile View
      else {
        ChangeUserInfoView()
      }
    }
    
    
  }
}

struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    UserProfileView()
      .environmentObject(UserData())
      
      .environmentObject(AppState())
  }
}
