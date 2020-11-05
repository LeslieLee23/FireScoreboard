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
        NavigationView {
            ZStack {
                Color.offWhite02.edgesIgnoringSafeArea(.all)
                VStack{
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
                            self.user3.id = Auth.auth().currentUser?.uid ?? "0"
                            self.user3.userEmoji = self.userData.newUserEmoji
                            self.user3.userName = self.userData.newUserName
                            
                            self.userLoader.updateData(user: self.user3)
                            
                            
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
                        
                        .alert(isPresented: $showAlert) { () ->
                            Alert in
                            return Alert(title: Text("User info changed!"), message: Text("You changed your name to \(self.userData.newUserName) and change your emoji \(self.userData.newUserEmoji)."), dismissButton: Alert.Button.default(Text("Ok"))
                            {
                                
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            )
                            
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
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
