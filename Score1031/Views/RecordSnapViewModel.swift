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
        Text(nameEmo)
          //  .font(.headline)
          .font(.system(size: 28))
      }.frame(width:40, height: 50, alignment: .leading)
        
        VStack(alignment: .leading) {
          VStack(alignment: .leading) {
          Text(reason)
          .font(.system(size: 13))
          .multilineTextAlignment(.leading)
          }//.frame(width:165, height: 40, alignment: .leading)
            .frame(minWidth: 165, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .leading)

        //  Spacer()
          VStack(alignment: .leading) {
          Text(entryTime)
          .font(.system(size: 11))
            .foregroundColor(Color.darkGray)
          }//.frame(width:165, height: 40, alignment: .leading)
          .frame(minWidth: 150, maxWidth: .infinity, minHeight: 10, maxHeight: 10, alignment: .leading)
        }
        
        
        VStack(alignment: .leading) {
          Text(score)
          .font(.system(size: 20))
          .fontWeight(.medium)
          .foregroundColor(score.first == "-" ? .red : .green)
        }.frame(width:45, height: 50, alignment: .center)
      
      }
    }
    .frame(width:270, height: 50, alignment: .center)
  //  .border(Color.blue)
  }
}

struct RecordSnapViewModel_Previews: PreviewProvider {
  static var previews: some View {
    RecordSnapViewModel()
  }
}
