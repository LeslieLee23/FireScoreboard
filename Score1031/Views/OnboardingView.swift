//
//  OnboardingView.swift
//  Score1031
//
//  Created by Danting Li on 10/28/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
      ZStack {
        LinearGradient(gradient: Gradient(colors: [.mixedBlue, .mixedPurple]), startPoint: .topLeading, endPoint: .bottomTrailing)
      }.edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingView()
    }
}
