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
    ZStack{
      Color.offWhite02.edgesIgnoringSafeArea(.all)
    
        VStack {
          ///header row
          VStack {
            Spacer()
            HStack {
              Spacer()
              Button(action: {
                 // self.presentationMode.wrappedValue.dismiss()
                self.userData.profileMode = false
              })
              {
                Text("Done")
                  .font(Font.system(size: 20, weight: .regular))
              }
              .padding(.trailing)
            }
            Spacer()
          }.frame(width:350, height: 65, alignment: .top)
          ///header row
          
          //User info row
          VStack {
            Text(self.userData.userEmoji ?? "👽")
              .font(.system(size: 65))
            Text(self.userData.userName)
              .font(.system(size: 23))
              .fontWeight(.bold)
              .foregroundColor(Color.offblack03)
          }
          if !self.userData.signedInWithApple {
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
          } else {
            VStack(alignment: .leading) {
              Button(action: {
                
              }) {
                Text("Sign Out")
              }
            }
          }
          VStack(alignment: .leading) {
            
            Button(action: {
              self.userData.profileEditMode = true
            }
            )
            {
              Text("Edit Name/Emoji")
            }
          }
          VStack {
          if userData.profileEditMode == false {
            Spacer()
          }///Profile View
          else {
            ChangeUserInfoView()

          }
          }
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
    
  }
}

struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    UserProfileView()
  }
}
