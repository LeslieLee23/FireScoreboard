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
        .frame(width: 320, height: 100)
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
      }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

//
//import SwiftUI
//import FirebaseUI
//import Firebase
//
//public var screenWidth: CGFloat {
//  return UIScreen.main.bounds.width
//}
//
//public var screenHeight: CGFloat {
//  return UIScreen.main.bounds.height
//}
//
//struct LoginView : View {
//
//    @State private var viewState = CGSize(width: 0, height: screenHeight)
//    @State private var MainviewState = CGSize.zero
//
//  var body : some View {
//    ZStack {
//      CustomLoginViewController { (error) in
//        if error == nil {
//          self.status()
//        }
//      }.offset(y: self.MainviewState.height).animation(.spring())
//      ContentView()
//        .environmentObject(UserData())
//        .environmentObject(NameAndScore())
//        .environmentObject(AddScoreFunc())
//        .environmentObject(AddBetFunc())
//        .environmentObject(AppState())
//        .offset(y: self.viewState.height).animation(.spring())
//    }
//  }
//
//  func status() {
//    self.viewState = CGSize(width: 0, height: 0)
//    self.MainviewState = CGSize(width: 0, height: screenHeight)
//  }
//}
//
//struct LoginView_Previews : PreviewProvider {
//  static var previews : some View {
//    LoginView()
//  }
//}
//
//struct CustomLoginViewController : UIViewControllerRepresentable {
//
//  var dismiss : (_ error : Error? ) -> Void
//
//  func makeCoordinator() -> CustomLoginViewController.Coordinator {
//    Coordinator(self)
//  }
//
//  func makeUIViewController(context: Context) -> UIViewController
//  {
//    let authUI = FUIAuth.defaultAuthUI()
//
//    let providers : [FUIAuthProvider] = [
//      FUIEmailAuth(),
//    //  FUIGoogleAuth(),
//      FUIOAuth.appleAuthProvider()
//    ]
//
//    authUI?.providers = providers
//    authUI?.delegate = context.coordinator
//
//    let authViewController = authUI?.authViewController()
//
//    return authViewController!
//  }
//
//  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomLoginViewController>)
//  {
//
//  }
//
//  //coordinator
//  class Coordinator : NSObject, FUIAuthDelegate {
//    var parent : CustomLoginViewController
//
//    init(_ customLoginViewController : CustomLoginViewController) {
//      self.parent = customLoginViewController
//    }
//
//    // MARK: FUIAuthDelegate
//    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?)
//    {
//      if let error = error {
//        parent.dismiss(error)
//      }
//      else {
//        parent.dismiss(nil)
//      }
//    }
//
//    func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?)
//    {
//    }
//  }
//}
