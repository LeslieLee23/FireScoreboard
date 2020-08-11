//
//  History.swift
//  Score1031
//
//  Created by Danting Li on 1/9/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//
import SwiftUI

struct RecordViewModel: View {
  var name: String = ""
  var score: String = ""
  var reason: String = ""
  var entryTime: String = ""
  var playerID: String = ""
  var nameStr: String = "Player Default"
  var nameEmo: String = "🐒"
  
  var body: some View  {
      
      VStack(){
        
        HStack(){
          VStack(alignment: .leading) {
          Spacer()
          Text(nameEmo)
          //  .font(.headline)
            .font(.system(size: 25))
          }
          .frame(width:45, height: 20, alignment: .leading)
      //    .border(Color.purple)
          VStack(alignment: .leading) {
          Spacer()
          Text(nameStr)
            .font(.headline)
          }
          .frame(width:145, height: 20, alignment: .leading)
          
          VStack(alignment: .trailing) {
          Spacer()
          Text(entryTime)
            .font(.system(size: 11))
          }
          .frame(width:140, height: 20, alignment: .trailing)
   //       .border(Color.purple)
        }
        .frame(width:335, height: 20, alignment: .leading)
     //   .border(Color.blue)
        
        HStack(){
        VStack(alignment: .leading){
          Spacer()
          Spacer()
          Text(score)
          //  .font(.headline)
            .font(.system(size: 20))
            .fontWeight(.medium)
            .foregroundColor(score.first == "-" ? .red : .green)
        }
        .frame(width:45,height: 45, alignment: .leading)
     //    .border(Color.purple)
        
        
        VStack(alignment: .leading){
          Spacer()
          Text(reason)
            .font(.system(size: 13))
            .multilineTextAlignment(.leading)
  //        Text(entryTime)
  //          .font(.system(size: 13))
        }
        .frame(width:230, height: 35, alignment: .leading)
  //        .border(Color.purple)
        
        VStack(alignment: .leading){
          Spacer()
          }
          .frame(width:40, height: 35, alignment: .leading)
     //     .border(Color.blue)
      }
        .frame(width:335, height: 35, alignment: .leading)
      }
      .frame(width:345, height: 55, alignment: .leading)
//      .border(Color.blue)
    }
}

struct RecordViewModel_Preview: PreviewProvider
{
  static var previews: some View {
    RecordViewModel()
  }
}
