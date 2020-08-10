//
//  SigninWithAppleButton.swift
//  Score1031
//
//  Created by Danting Li on 8/4/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable {
  
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
  }
  
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<SignInWithAppleButton>) {
    
  }
}
