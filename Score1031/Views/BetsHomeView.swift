//
//  BetsHomeView.swift
//  Score1031
//
//  Created by Danting Li on 9/8/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import Foundation

struct BetsHomeView: View {
  
  @EnvironmentObject var userData: UserData
  @ObservedObject var betLoader = BetLoader()
  @ObservedObject private var apiLoader = APILoader()
  @State var showAlert = false
  
  var body: some View {
    NavigationView {
      ZStack{
        Color.offWhite.edgesIgnoringSafeArea(.all)
        VStack {
          HStack {
            VStack(alignment: .leading) {
              Text("Ongoing Bets:")
            }
            .frame(width:200, height: 15, alignment: .leading)
            .padding()
            // .border(Color.red)
            Spacer()
          }
          
          VStack(alignment: .leading) {
            //Ongoing Bet
            List {
              ForEach (betLoader.fetchOngoingBet(self.userData.playerID!)) { bets3 in
                  if self.userData.deleteMode == false {
                    NavigationLink(destination: BetAssignResultView(bets3: bets3)) {
                      HStack(){
                        VStack{
                          BetViewModel(bets3: bets3)
                        }
                        VStack() {
                          VStack() {
                            Text("Stake:")
                              .font(.system(size: 14))
                          }
                          .frame(width:50, height: 20, alignment: .top)
                          VStack() {
                            Text(bets3.betScore)
                              .font(.system(size: 20))
                          }
                          .frame(width:50, height: 30, alignment: .center)
                        }
                        .frame(width:50, height: 80, alignment: .leading)
                      }
                      .frame(minWidth: 350, maxWidth: 350, minHeight: 85, maxHeight: 95, alignment: .leading)
                    }
                  } else {
                    HStack(){
                      VStack{
                        BetViewModel(bets3: bets3)
                      }
                      VStack(alignment: .leading) {
                        Button(action: {
                          self.showAlert = true
                        })
                        {
                          Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                            .font(.system(size:20))
                        }
                        .alert(isPresented: self.$showAlert) { () ->
                          Alert in
                          
                          return Alert(title: Text("Confirm your action:"), message: Text("Are you sure you want to delete the bet \(bets3.betDescription) from the app?"), primaryButton: .destructive(Text("Confirm"))
                          {
                            self.betLoader.remove(id: bets3.id)
                            self.userData.deleteMode = false
                            }, secondaryButton: .cancel(){
                                self.userData.deleteMode = false
                            })
                        }
                      }.frame(width:50, height: 80, alignment: .center)
                    }
                    .frame(minWidth: 350, maxWidth: 350, minHeight: 85, maxHeight: 95, alignment: .leading)
                  }
              }.listRowBackground(Color.offWhite)
            }
          }//Ongoing Bet
          .frame(width:370, height: 190, alignment: .leading)
          HStack {
            VStack(alignment: .leading) {
              Text("Past Bets:")
            }
            .frame(width:200, height: 15, alignment: .leading)
            .padding()
            Spacer()
          }
          
          VStack(alignment: .leading) {
            PastBetView()
          }
          .frame(width:370, height: 190, alignment: .leading)
        }
      }
      .frame(minWidth: 370, maxWidth: 370, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        
      .onAppear() {
        self.betLoader.fetchBetData()
      }
      .navigationBarItems(leading:
        HStack(spacing: 81){
          Button(action: {
            self.userData.deleteMode = true
          })
          {
            Toggle(isOn: $userData.deleteMode) {
              Text("")
            }
            .toggleStyle(DeleteToggleStyle())
            .padding(.leading, 18)
          }
          Spacer()
          Spacer()
          NavigationLink(destination: AddBetView()) {
            Image(systemName: "plus.circle.fill")
              .font(.system(size:21))
              .padding(.trailing, 18)
          }
        }
      )
    }
     .onAppear() {
      self.userData.deleteMode = false
    }
  }
}



struct BetsHomeView_Previews: PreviewProvider {
  static var previews: some View {
    BetsHomeView()
  }
}
