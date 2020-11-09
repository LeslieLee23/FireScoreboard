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
  @State var coordinator: SignInWithAppleCoordinator?
  @State var records = [Recordline]()
  
  
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
                      self.userData.playerID = "\(Auth.auth().currentUser?.uid)*\(self.userData.playerID)"
                      for record in self.apiLoader.records {
                        print("record?????????????? \(record)")
                        var record3 = record
                        record3.userId = Auth.auth().currentUser?.uid
                        record3.playerID = "\(Auth.auth().currentUser?.uid)*\(record3.playerID)"
                        
                        print("record3 \(record3)")
                        self.apiLoader.updateData(record3: record3)
                      }
                      self.userData.signedInWithApple = true
                      self.userData.userUid = Auth.auth().currentUser?.uid
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
                }) {
                  Text("Sign Out")
                }
              }
            } else {
              Text("Signed in with Apple")
              VStack(alignment: .leading) {
                Button(action: {
                  do {
                    try Auth.auth().signOut()
                    self.userData.signedInWithApple = false
                    self.userData.userEmoji = nil
                    self.userData.userName = nil
                    print("Sign out of apple pressed: Auth.auth().currentUser?.uid \(String(describing: Auth.auth().currentUser?.uid))")
                    self.viewRouter.currentPage = "onboardingView"
                    
                  } catch let err {
                    print(err)
                  }
                }) {
                  Text("Sign Out")
                }
              }
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
//          self.records = self.apiLoader.records
//          print("self.records!!!!!!!! \(self.records)")
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
