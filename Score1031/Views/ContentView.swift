//
//  ContentView.swift
//  Score1031
//
//  Created by Danting Li on 10/31/19.
//  Copyright © 2019 HULUCave. All rights reserved.
//
import Foundation
import SwiftUI
import Combine
import CoreData
import Disk
import Firebase

struct ContentView: View {
  
  @EnvironmentObject private var nameAndScore: NameAndScore
  @EnvironmentObject private var userData: UserData
  @EnvironmentObject private var addEidtChoice: AddEidtChoice

  @State var emojiPlusName = [String]()
  @State var oldscore = [String]()
  @State var names = [String]()
  @State var emojis = [String]()
  @State var oneEmoji = [String]()
  @State var twoEmoji = [String]()
  @State var filteredRecords3 = ZAPILoader.queryPlayerList()
  @State var records3 = ZAPILoader.load()
  
  var body: some View {
    ZStack{
      Color.offWhite
    
    NavigationView{
      VStack {
        VStack {
          VStack {
            HStack{
              NavigationLink (destination: ChangePlayersView(filteredRecords3: self.filteredRecords3))
              {
                Text("Change Players")
                  .fontWeight(.light)
                  .font(.system(size:15))
                  .padding()
              }
              .simultaneousGesture(TapGesture().onEnded {
                self.filteredRecords3 = ZAPILoader.queryPlayerList()
                self.records3 = ZAPILoader.load()
                print("#####\(self.filteredRecords3)")
              })
              .disabled(!Disk.exists("scores.json", in: .documents))
 
              
              Spacer()
              Text("Emoji Mode")
                .font(.system(size:15))
            }
            .padding(.trailing, 35)
            
            HStack {
              Spacer()
              Toggle(isOn: $userData.showEmoji
                .animation(
                  Animation.spring(dampingFraction: 0.7)
              )
                
              ) {
                Text("Emoji Mode")
              }.padding(.trailing, 35)
                .labelsHidden()
            }
            
            ///Title row
            Spacer()
            Text("Scoreboard")
              .font(.headline)
              .fontWeight(.bold)
              .padding(0.0)
            Spacer()
            
            ///Score row
            HStack {
              Spacer()
              Text("\(self.nameAndScore.PlayerOneScore)")
                .font(.system(size: 25))
              Spacer()
              Text("\(self.nameAndScore.PlayerTwoScore)")
                .font(.system(size: 25))
              Spacer()
            }
            //Name row
          }
          VStack {
            Spacer()
            if self.userData.showEmoji == true {
            HStack {
                Spacer()
              
                Text(self.nameAndScore.playerOneEmoji ?? "👩🏻")
                .font(.system(size: 45))
                .transition(.scale(scale: 5))

                Spacer()
                Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
                .font(.system(size: 45))
                Spacer()
            }
            } else {
              HStack {
                  Spacer()
                
                  Text(self.nameAndScore.playerOneName ?? "Miu")
                  .font(.system(size: 25))
                  Spacer()
                  Text(self.nameAndScore.playerTwoName ?? "Whof")
                  .font(.system(size: 25))
                  Spacer()
              }
            }
            Spacer()
            Spacer()
          }
          ///Add Score Button row
          VStack {
            NavigationLink (destination: AddScoreView(emojiPlusName: emojiPlusName, oldscore: oldscore, names: names, emojis: emojis)) {
              Text("Add Score!")
                .fontWeight(.semibold)
            }
            .frame(width: 89, height: 8, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("isaacblue"), Color("destinygreen")]), startPoint: .leading, endPoint: .trailing))
           
            .cornerRadius(13)
       //     .shadow(color: Color.black.opacity(0.2), radius: 5, x: 10, y: 10)
       //     .shadow(color: Color.white.opacity(1), radius: 5, x: -5, y: -5)
            .simultaneousGesture(TapGesture().onEnded {
              self.addEidtChoice.addViewSelected = true
              self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
              self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
              self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
              self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
              })
            
          }
          Spacer()
          Spacer()
          
          ///Edit Score Button row
          VStack {
            NavigationLink (destination: AddScoreView(emojiPlusName: emojiPlusName, oldscore: oldscore, names: names, emojis: emojis)) {
              Text("Edit Score!")
                .fontWeight(.semibold)
            }
            .frame(width: 89, height: 8, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("destinygreen"), Color("isaacblue")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(13)
              
            .simultaneousGesture(TapGesture().onEnded {
              self.addEidtChoice.addViewSelected = false
              self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
              self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
              self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
              self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
            })
            
          }
          VStack {
            
            Spacer()
            Spacer()
            
            /// View History row
            HStack {
              VStack {
                NavigationLink (destination: HistoryView()){
                  Text("View History")
                    .fontWeight(.light)
                    .font(.system(size:15))
                }
                .padding()
                Spacer()
              }
              Spacer()
              VStack {
                NavigationLink (destination: AddNewPlayerView())
                {
                  Text("Add Players")
                    .fontWeight(.light)
                    .font(.system(size:15))
                }
                .padding()
                Spacer()
              }
            }
            Spacer()
            HStack {
              
              Button(action: {
                self.nameAndScore.PlayerTwoScore = 0
                self.nameAndScore.PlayerOneScore = 0
                self.nameAndScore.playerTwoName = "Player Two"
                self.nameAndScore.playerOneName = "Player One"
                self.nameAndScore.playerOneEmoji = "👩🏻"
                self.nameAndScore.playerTwoEmoji = "👨🏻"
                self.userData.playerID = "0"
         ///Check if file exist

                    if Disk.exists("scores.json", in: .documents) {
                      
                      let dateFormatter = DateFormatter()
                      dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                      dateFormatter.amSymbol = "AM"
                      dateFormatter.pmSymbol = "PM"
                      
                      let defaultPlayer = [Recordline(id: UUID().uuidString, playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "recordEntryTimeString", recordAddEdit: true)]
                        print(defaultPlayer)
                        try! Disk.remove("scores.json", from: .documents)
  
                        try! Disk.save(defaultPlayer, to: .documents, as: "scores.json")
                        print("emptied score.json and put in default value in the file")
                    } else {
                      print("There is no scores.json file")
                  }

                
              })
              {
                Text("Start Over")
              }
              Button(action: {
              
                let db = Firestore.firestore()
                db.collection("records").getDocuments { (snapshot, error) in
                  
                  if error == nil && snapshot != nil {
                    for document in snapshot!.documents {
                      let documentData = document.data()
                      print ("One example \(documentData)")
                    }
                  }
                  
                }
               
                
               // ref.childByAutoId().setValue(["playerID": "0", "playerOneEmoji": "👩🏻","playerOneName": "Player One", "playerOneScore": 0, "playerTwoEmoji": "👨🏻", "playerTwoName": "Player Two", "playerTwoScore": 0, "recordName": "Player one and two", "recordScore": "NA", "recordReason": "Default players created", "recordEntryTime": Date(), "recordEntryTimeString": "", "recordAddEdit": true])
                
                
              })
              {
                Text("file path")
              }
            }
          }
        }
      }
    }
    }
   // .edgesIgnoringSafeArea(.all)
  }
  
  
  
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(["iPhone XS Max"], id: \.self) { deviceName in
        ContentView()
          .previewDevice(PreviewDevice(rawValue: deviceName))
          .previewDisplayName(deviceName)
      }
      .environmentObject(NameAndScore())
      .environmentObject(UserData())
      
    }
  }
  
}
