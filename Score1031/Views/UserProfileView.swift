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
    @State var showChangeUserInfoView = false
    
    var body: some View {
        ZStack{
          Color.offWhite02.edgesIgnoringSafeArea(.all)
           VStack {
            ///Header row
            VStack {
                ///buttons row
                VStack(alignment: .trailing) {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                  Text("Done")
                  .font(Font.system(size: 20, weight: .regular))
                }
                .padding(.trailing, 30)
                  Spacer()
                  Spacer()
                  Spacer()
                  Spacer()
                  
                }///buttons row
                .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .trailing)
            }///header row
            
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
                    self.showChangeUserInfoView.toggle()
                })
                {
                    Text("Edit Name/Emoji")
                }
            }

           }
        }
        .sheet(isPresented: $showChangeUserInfoView) {

            ChangeUserInfoView()
                .environmentObject(UserData())
                .environmentObject(AppState())

        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
