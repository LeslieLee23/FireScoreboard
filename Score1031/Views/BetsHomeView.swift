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
  @EnvironmentObject var appState: AppState
  @State var showAlert = false
  
  var body: some View {
    NavigationView {
      ZStack{
        ///ZStack Color Die
        Color.offWhite02.edgesIgnoringSafeArea(.all)
        VStack {
         ///button section
          VStack {
            ///button mix section
            ZStack {
              ///minus button
              HStack() {
                VStack {
                  Toggle(isOn: $userData.deleteMode) {
                    Text("")
                  }
                  .toggleStyle(DeleteToggleStyle())
                    }.frame(width: 55, height: appState.TitleRowHeight, alignment: .leading)
           //     .border(Color.red)
                Spacer()
                }///minus button
              .frame(width: appState.screenWidth, height: appState.TitleRowHeight, alignment: .leading)
              
              ///add button
              HStack() {
              Spacer()
              VStack(alignment: .leading) {
              NavigationLink(destination: AddBetView()
                .environmentObject(UserData())
                .environmentObject(observed())
              ) {
                Image(systemName: "plus.circle.fill")
                  .font(.system(size:21))
              }
                }
             //   .padding(.trailing, 10)
                .frame(width: 55, height: appState.TitleRowHeight, alignment: .leading)
           //   .border(Color.red)
              }///add button
            }
            ///button mix section
          }
          ///button section
         // .border(Color.blue)
          .frame(width: appState.screenWidth, height: appState.TitleRowHeight - 15, alignment: .center)
          ///Gap row
          VStack () {
            Spacer()
          }.frame(width: appState.screenWidth, height: appState.BetGapHeight, alignment: .leading)
          ///Gap row
          
          ///content section
          VStack {
            RoundedRectangle(cornerRadius: 15)
              .fill(Color.offWhite02)
           //   .fill(Color.offGray01)
              .shadow(color: Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
              .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
              .frame(width:appState.scoreboradWidth, height: 250, alignment: .leading)
            .overlay(
          VStack {
            //Ongoing Section
            HStack {
              //Ongoing Section title
              VStack(alignment: .leading) {
                Spacer()
                Text("Ongoing Bets:")
                  .foregroundColor(Color.offblack03)
                  .padding(.leading)
                  .font(Font.headline.weight(.medium))
                Divider()
               
              }
              
            }//Ongoing Section title
            if betLoader.fetchOngoingBet(self.userData.playerID).count < 1 {
              //Ongoing content if no record
              VStack {
                Spacer()
                Text("No ongoing bet. Add a bet!")
                  .padding(.leading)
                  .foregroundColor(Color.offGray02)
                Spacer()
                Spacer()
              }.frame(width:appState.scoreboradWidth, height: 200, alignment: .leading)
             //   .border(Color.red)
            }//Ongoing content if no record
              
            else {
              //Ongoing content with content
              VStack(alignment: .leading) {
                List {
                  ForEach (betLoader.fetchOngoingBet(self.userData.playerID)) { bets3 in
                    if self.userData.deleteMode == false {
                      //Ongoing content in normal mode
                      NavigationLink(destination: BetAssignResultView(bets3: bets3)
                      .environmentObject(UserData())
                      .environmentObject(AppState())
                      
                      ) {
                        HStack(){
                          VStack{
                            BetViewModel(bets3: bets3)
                          }
                          VStack() {
                            VStack() {
                              Text("Stake:")
                                .font(.system(size: 14))
                                .foregroundColor(Color.offblack01)
                            }
                            .frame(width:50, height: 20, alignment: .top)
                            VStack() {
                              Text(bets3.betScore)
                                .font(.system(size: 20))
                                .foregroundColor(Color.offblack03)
                            }
                            .frame(width:50, height: 30, alignment: .center)
                            
                          }
                          .frame(width:50, height: 80, alignment: .leading)
                        }
                        .frame(minWidth: appState.scoreboradWidth, maxWidth: appState.scoreboradWidth, minHeight: 85, maxHeight: 95, alignment: .leading)
                    //    .border(Color.blue)
                      }
                    }//Ongoing content in normal mode
                    else {
                      //Ongoing content in edit mode
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
                      .frame(minWidth: appState.scoreboradWidth, maxWidth: appState.scoreboradWidth, minHeight: 85, maxHeight: 95, alignment: .leading)
                      
                    }//Ongoing content in edit mode
                  }.listRowBackground(Color.offWhite02)
                }
              }
              .frame(width:appState.scoreboradWidth, height: 200, alignment: .leading)
              .foregroundColor(Color.offWhite02)
            }//Ongoing content with content
          }//Ongoing Section
            .frame(minWidth: appState.scoreboradWidth, maxWidth: appState.scoreboradWidth, minHeight: 140, maxHeight: 240, alignment: .leading)
              .cornerRadius(15)
          //  .border(Color.green)
            )
          }
          Spacer()
          Spacer()

          if betLoader.fetchPastBet(self.userData.playerID).count < 1 {
          //PastBet Section if no data
            
          }//PastBet Section if no data
          else {
          //PastBet Section with content
            VStack{
            RoundedRectangle(cornerRadius: 15)
               .fill(Color.offWhite02)
            //   .fill(Color.offGray01)
               .shadow(color: Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
               .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
               .frame(width:appState.scoreboradWidth, height: 250, alignment: .leading)
             .overlay(
            VStack {
            HStack {
            //PastBet Section title
              VStack(alignment: .leading) {
                Spacer()
                Text("Past Bets:")
                  .foregroundColor(Color.offblack03)
                .padding(.leading)
                .font(Font.headline.weight(.medium))
                Divider()
              }
              .frame(minWidth: 0,
              maxWidth: .infinity,
              minHeight: 28,
              maxHeight: 28,
              alignment: .leading)
            }//PastBet Section title
            
            VStack(alignment: .leading) {
            //Pastbet content
              PastBetView()
            }//Pastbet content
            .frame(width:appState.scoreboradWidth, height: 200, alignment: .leading)
            .cornerRadius(15)
          }//PastBet Section with content
          )
            }
          }
          Spacer()
          Spacer()
          Spacer()
         
        }
      }//ZStack Color Die
        //  .frame(minWidth: 370, maxWidth: 370, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        
        
        .onAppear() {
          self.betLoader.fetchBetData()
      }
      .navigationBarTitle("")
      .navigationBarHidden(true)
//      .navigationBarItems(leading:
//          VStack(alignment: .leading) {
//          Toggle(isOn: $userData.deleteMode) {
//            Text("")
//          }
//          .toggleStyle(DeleteToggleStyle())
//            }
//            .padding(.leading, 4)
//
//            , trailing:
//            VStack {
//          NavigationLink(destination: AddBetView()
//            .environmentObject(UserData())
//            ///adding this solved the obj error I have been getting on and off
//            .environmentObject(observed())
//          ) {
//            Image(systemName: "plus.circle.fill")
//              .font(.system(size:21))
//             // .padding(.trailing, 18)
//          }
//            }// .frame(width: 50, height: 50, alignment: .leading)
//            .padding(.trailing, 10)
//
//      )
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
