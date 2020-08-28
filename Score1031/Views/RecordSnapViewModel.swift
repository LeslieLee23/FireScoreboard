//
//  RecordSnapViewModel.swift
//  Score1031
//
//  Created by Danting Li on 8/27/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct RecordSnapViewModel: View {
  var name: String = "mia"
  var score: String = "+2"
  var reason: String = "cute cute monkey"
  var entryTime: String = "Aug 03 2020 5:30pm"
  var playerID: String = ""
  var nameStr: String = "Micheal"
  var nameEmo: String = "🐒"
  var body: some View {
    
    VStack(){
      HStack(){
      VStack(alignment: .leading){
        Spacer()
      }.frame(width:25, height: 40, alignment: .topLeading)
        
      VStack(alignment: .leading){
        Text(nameEmo)
          //  .font(.headline)
          .font(.system(size: 28))
      }.frame(width:45, height: 40, alignment: .topLeading)
        
        VStack(alignment: .leading) {
//          Text(nameStr)
//            .font(.headline)
//          Spacer()
          Text(reason)
          .font(.system(size: 13))
          .multilineTextAlignment(.leading)
          Spacer()
          Text(entryTime)
          .font(.system(size: 11))
        }
        .frame(width:165, height: 40, alignment: .leading)
        
        VStack(alignment: .leading) {
          Text(score)
          .font(.system(size: 20))
          .fontWeight(.medium)
          .foregroundColor(score.first == "-" ? .red : .green)
        }.frame(width:50, height: 40, alignment: .topLeading)
      
      }
    }
    .frame(width:300, height: 45, alignment: .leading)
  }
}

struct RecordSnapViewModel_Previews: PreviewProvider {
  static var previews: some View {
    RecordSnapViewModel()
  }
}
