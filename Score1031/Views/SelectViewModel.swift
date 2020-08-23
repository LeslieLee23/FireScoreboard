//
//  SelectViewModel.swift
//  Score1031
//
//  Created by Danting Li on 3/16/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct SelectViewModel: View {
    var playerID: String = ""
    var playerOneName: String = ""
    var playerTwoName: String = ""
    var playerOneScore: String = ""
    var playerTwoScore: String = ""
    var playerOneEmoji: String = ""
    var playerTwoEmoji: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Spacer()
                }
            .frame(width:15,height: 50, alignment: .leading)
                
            VStack(alignment: .leading){
                Text("\(playerOneEmoji) \(playerOneName)")
                Spacer()
                Text(String(playerOneScore))
            }
            .frame(width:130, height: 50, alignment: .leading)
            VStack(alignment: .leading){
                Text("\(playerTwoEmoji) \(playerTwoName)")
                Spacer()
                Text(String(playerTwoScore))
            }
            .frame(width:130, height: 50, alignment: .leading)
       }
    }
}

struct SelectViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SelectViewModel()
    }
}
