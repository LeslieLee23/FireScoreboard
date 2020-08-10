//
//  SignInView.swift
//  Score1031
//
//  Created by Danting Li on 8/4/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct SignInView: View {
  @Environment(\.presentationMode) var presentationMode
  @State var coordinator: SignInWithAppleCoordinator?
    var body: some View {
      VStack{
        Text("Thanks fo using FireScoreboard. Please sign in here.")
        SignInWithAppleButton()
          .frame(width: 280, height: 45)
          .onTapGesture {
            self.coordinator = SignInWithAppleCoordinator()
            if let coordinator = self.coordinator {
            coordinator.startSignInWithAppleFlow {
              print("You successfully signed in")
              self.presentationMode.wrappedValue.dismiss()
            }
            }
        }
      }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
