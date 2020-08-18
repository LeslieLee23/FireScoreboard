//
//  EditModeView.swift
//  Score1031
//
//  Created by Danting Li on 8/14/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import Disk
import Firebase

struct EditModeView: View {
  @State var scoreEdited = ""
  @State var reason = ""
  @State var selectedName = 0
//%%%%%
  @State var editedScore = 0
  @State var selectedNameString = ""
  @State var pointGrammar = "points"
  @State var showAlert = false
  @EnvironmentObject var nameAndScore: NameAndScore
  @EnvironmentObject var addEidtChoice: AddEidtChoice
  @EnvironmentObject var addScoreFunc: AddScoreFunc
  @EnvironmentObject private var userData: UserData
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject private var apiLoader = APILoader()
  @State private var records3 = APILoader().records3
  
  
    var body: some View {
      VStack {
        HStack {
                   Spacer()
                   Button(action: {
                    self.editedScore -= 1
                   }) {
                       Text("-")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .font(.system(size: 25))
                   }
                   .frame(width: 35, height: 35)
                   .foregroundColor(.red)
          
                   Text("\(self.editedScore)")
                   .font(.system(size: 25))
                   .padding()
          
                   Button(action: {
                    self.editedScore += 1
                   }) {
                       Text("+")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .font(.system(size: 25))
                   }
                   .frame(width: 35, height: 35)
                   .foregroundColor(.green)
                   Spacer()
               }
               .buttonStyle(CircleStyle())
        Spacer()
        TextField("What for?", text: $reason)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding(.trailing, 35)
          .padding(.leading, 35)
        
        Spacer()
      }//.border(Color.purple)
    }
}

struct EditModeView_Previews: PreviewProvider {
    static var previews: some View {
        EditModeView()
    }
}
