//
//  History.swift
//  Score1031
//
//  Created by Danting Li on 1/9/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//
import SwiftUI

struct RecordViewModel: View {

  var records3 = Recordline(playerID: "0", playerOneEmoji: "👩🏻", playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "👩🏻", recordReason: "Default players created!", recordEntryTime: Date(), recordEntryTimeString: getDateString(Date: Date()), recordNameStr: "Welcome!", recordNameEmo: "👨🏻")
  
  var body: some View  {
      
      VStack(){
        
        HStack(){
          VStack(alignment: .leading) {
          Spacer()
          Text(records3.recordNameEmo ?? "🐒")
            .font(.system(size: 25))
          }
          .frame(width:45, height: 20, alignment: .leading)
          VStack(alignment: .leading) {
          Spacer()
          Text(records3.recordNameStr ?? "Wowo")
            .font(.headline)
            .foregroundColor(Color.offblack04)
            
          }
          .frame(width:165, height: 20, alignment: .leading)
          
          VStack(alignment: .trailing) {
          Spacer()
          Text(records3.recordEntryTimeString)
            .font(.system(size: 11))
            .foregroundColor(Color.offGray03)
          }
          .frame(width:130, height: 20, alignment: .trailing)
   //       .border(Color.purple)
        }
        .frame(width:335, height: 20, alignment: .leading)
   //     .border(Color.blue)
        
        HStack(){
        VStack(alignment: .leading){
          Spacer()
          Spacer()
          Text(records3.recordScore)
          //  .font(.headline)
            .font(.system(size: 25))
            .fontWeight(.medium)
            .foregroundColor( records3.recordScore.first == "-" ? .red : .green)
        }
        .frame(width:45,height: 35, alignment: .leading)
   //     .border(Color.purple)
        
        
        VStack(alignment: .leading){
          
          Text(records3.recordReason)
            .font(.system(size: 13))
            .multilineTextAlignment(.leading)
            .foregroundColor(Color.offblack04)

        }
        .frame(width:250, height: 35, alignment: .leading)
    //      .border(Color.purple)
        
        VStack(alignment: .leading){
          Spacer()
          }
          .frame(width:40, height: 35, alignment: .leading)
     //     .border(Color.blue)
      }
        .frame(width:335, height: 35, alignment: .leading)
      }

    }
}

struct RecordViewModel_Preview: PreviewProvider
{
  static var previews: some View {
    RecordViewModel()
  }
}
