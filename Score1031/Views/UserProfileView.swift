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
  @EnvironmentObject var userData: UserData
  @EnvironmentObject var appState: AppState
  @Environment(\.presentationMode) var presentationMode
  @State var coordinator: SignInWithAppleCoordinator?
  
  
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
                  Text(self.userData.userName)
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
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
              Text("* Sign in with Apple to sync everything across your devices. ")
                .font(.system(size: 13))
                .foregroundColor(Color.gray)
                .frame(width: 260, height: 45)
            } else {
              VStack(alignment: .leading) {
                Button(action: {
                  
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
        print("self.userData.userEmoji \(self.userData.userEmoji)")
        print("self.userData.userName \(self.userData.userName)")
        print("self.userData.userUid \(self.userData.userUid)")
        print("self.userData.signedInWithApple \(self.userData.signedInWithApple)")
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
