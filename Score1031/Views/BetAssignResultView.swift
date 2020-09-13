//
//  BetAssignResultView.swift
//  Score1031
//
//  Created by Danting Li on 9/13/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct BetAssignResultView: View {
    var body: some View {
       ZStack{
        Color.offWhite.edgesIgnoringSafeArea(.all)
        VStack {
          Spacer()
               HStack{
               Text("Enter bet:")
                 .padding(.leading, 50)
               Spacer()
               }
        }
      }
    }
}

struct BetAssignResultView_Previews: PreviewProvider {
    static var previews: some View {
        BetAssignResultView()
    }
}
