//
//  ChangeUserInfoView.swift
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
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ChangeUserInfoView: View {
  @EnvironmentObject var userData: UserData
  @EnvironmentObject var appState: AppState
  @ObservedObject private var userLoader = UserLoader()
  @State private var user3 = UserLoader().user3
  @State var showAlert = false
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    
    ZStack {
      Color.offWhite02.edgesIgnoringSafeArea(.all)
      VStack{
        ///Back button row
        VStack {
          Spacer()
          HStack {
            Button(action: {
            self.userData.profileEditMode = false
            }
            ){
              Image(systemName: "chevron.left")
                .font(Font.system(size: 20, weight: .regular))
            }.foregroundColor(Color.darkPurple)
            .padding(.leading)
            
            Spacer()
          }
          Spacer()
        }.frame(width:350, height: 65, alignment: .top)
        ///Back button row
        Text("Edit Profile Info")
        Group{
          HStack{
            TextField("New user name", text: $userData.newUserName)
              .textFieldStyle(NeuTextStyle(w: appState.NeuTextWidth, h: appState.NeuTextHeight))
              .padding(.trailing, 35)
              .padding(.bottom, 8)
              .padding(.top, 10)
            //  .padding(.leading, 15)
            
          }
          
          HStack{
            TextField("New Emoji", text: $userData.newUserEmoji)
              .textFieldStyle(NeuTextStyle(w: appState.NeuTextWidth, h: appState.NeuTextHeight))
              .padding(.trailing, 35)
              .padding(.bottom, 8)
            //  .padding(.leading, 15)
          }
        }
        HStack {
          
          //    Spacer()
          Button(action: {
            
            self.user3.id = self.userData.userUid ?? "No userUid"
            
            self.user3.userEmoji = self.userData.newUserEmoji
            self.user3.userName = self.userData.newUserName
            
            self.userLoader.updateData(user: self.user3)
            self.userData.userEmoji = self.userData.newUserEmoji
            self.userData.userName = self.userData.newUserName
            print("self.user3.id \(self.user3.id)")
            print("self.user3.userEmoji \(self.user3.userEmoji)")
            print("self.user3.userName \(self.user3.userName)")
            print("self.userData.userEmoji \(self.userData.userEmoji)")
            print("self.userData.userName \(self.userData.userName)")
           // self.presentationMode.wrappedValue.dismiss()
            self.userData.profileEditMode = false
          }) {
            Text("Confirm")
          }
          .padding(.trailing, 35)
          .buttonStyle(NeuButtonStyle2(
                        addPlayerOneName: self.userData.newUserName,
                        addPlayerOneEmoji: self.userData.newUserEmoji,
                        addPlayerTwoName: "Valid",
                        addPlayerTwoEmoji: "💂🏻‍♂️"))
          .disabled(self.userData.newUserEmoji.isEmpty)
          .disabled(self.userData.newUserName.isEmpty)
          .disabled(self.userData.newUserEmoji.containsEmoji == false)
          
        }
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        
      }
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
    .navigationBarTitle("")
    
    .onAppear() {
      self.userData.newUserName = ""
      self.userData.newUserEmoji = ""
      
    }
  }
}

struct ChangeUserInfoView_Previews: PreviewProvider {
  static var previews: some View {
    ChangeUserInfoView()
  }
}
