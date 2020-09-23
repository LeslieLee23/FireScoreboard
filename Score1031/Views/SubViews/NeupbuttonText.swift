//
//  NeupbuttonText.swift
//  Score1031
//
//  Created by Danting Li on 9/23/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct NeupbuttonText: View {
    var body: some View {
      ZStack{
        Color.offWhite02.edgesIgnoringSafeArea(.all)
        VStack{
        Circle()
      //    .background(Color.offWhite02)
          .fill(Color.offWhite02)
          .shadow(color: Color.offGray01.opacity(1), radius: 4, x: 5, y: 5)
          .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
          .overlay(
            Text("+")
        )
          .frame(height: 45)
    }
      }
  }
}

struct NeupbuttonText_Previews: PreviewProvider {
    static var previews: some View {
        NeupbuttonText()
    }
}
