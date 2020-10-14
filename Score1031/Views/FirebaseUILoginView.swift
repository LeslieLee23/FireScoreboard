////
////  FirebaseUILoginView.swift
////  Score1031
////
////  Created by Danting Li on 10/13/20.
////  Copyright © 2020 HULUCave. All rights reserved.
////
//
//import SwiftUI
//import Firebase
//import FirebaseUI
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//
//
//struct FirebaseUILoginView : UIViewControllerRepresentable {
//    
// //   @Binding var user: FirebaseAuth.User?
//    
//    func makeCoordinator() -> FirebaseUILoginView.Coordinator {
//        Coordinator(self)
//    }
//    
//    func makeUIViewController(context: Context) -> UIViewController
//    {
//        let authUI = FUIAuth.defaultAuthUI()
//        
//        let providers : [FUIAuthProvider] = [
//            FUIEmailAuth(),
//            FUIGoogleAuth(),
//            FUIOAuth.appleAuthProvider()
//        ]
//        
//        authUI?.providers = providers
//        authUI?.delegate = context.coordinator
//        
//        let authViewController = authUI?.authViewController()
//
////        // Customization
////        let view = authViewController!.view!
////        
////        let marginInsets: CGFloat = 16
////        let imageHeight: CGFloat = 180
////        let imageY = view.center.y - imageHeight
////        
////        let logoFrame = CGRect(x: view.frame.origin.x + marginInsets, y: imageY, width: view.frame.width - (marginInsets*2), height: imageHeight)
////        
////        let logoImageView = UIImageView(frame: logoFrame)
////        logoImageView.image = UIImage(systemName: "gamecontroller")
////        logoImageView.contentMode = .scaleAspectFit
////        authViewController!.view.addSubview(logoImageView)
//        
//        
//        return authViewController!
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<FirebaseUILoginView>)
//    {
//        
//    }
//    
//    // Coordinator
//    class Coordinator : NSObject, FUIAuthDelegate {
//        var parent : FirebaseUILoginView
//        
//        init(_ customLoginViewController : FirebaseUILoginView) {
//            self.parent = customLoginViewController
//        }
//        
//        // MARK: FUIAuthDelegate
//        func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?)
//        {
//            parent.user = authDataResult?.user
//        }
//        
//        func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?)
//        {
//        }
//        
//    }
//}
