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

struct ContentView: View {
  
  @EnvironmentObject private var nameAndScore: NameAndScore
  @EnvironmentObject private var userData: UserData
  @EnvironmentObject private var addEidtChoice: AddEidtChoice

  @State var names = [String]()
  @State var oldscore = [String]()
  @State var oneEmoji = [String]()
  @State var twoEmoji = [String]()
  @State var filteredRecords3 = ZAPILoader.queryPlayerList()
  @State var records3 = ZAPILoader.load()
  
  var body: some View {
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
              })
              .disabled(!Disk.exists("scores.json", in: .documents))
 
              
              Spacer()
              Text("Emoji Mode")
                .font(.system(size:15))
            }
            .padding(.trailing, 35)
            
            HStack {
              Spacer()
              Toggle(isOn: $userData.showEmoji) {
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
            HStack {
              Spacer()
              Text("\((self.userData.showEmoji ? self.nameAndScore.playerOneEmoji ?? "" : self.nameAndScore.playerOneName ?? "") )")
                .font(.system(size: self.userData.showEmoji ? 45 : 25))
              Spacer()
              Text("\((self.userData.showEmoji ? self.nameAndScore.playerTwoEmoji ?? "" : self.nameAndScore.playerTwoName ?? "") )")
                .font(.system(size: self.userData.showEmoji ? 45 : 25))
              Spacer()
            }
            Spacer()
            Spacer()
          }
          ///Add Score Button row
          VStack {
            NavigationLink (destination: AddScoreView(names: names, oldscore: oldscore)) {
              Text("Add Score!")
                .fontWeight(.semibold)
            }
            .frame(width: 89, height: 8, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("isaacblue"), Color("destinygreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(13)
            .simultaneousGesture(TapGesture().onEnded {
              self.addEidtChoice.addViewSelected = true
              self.names  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
              self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
              })
            
          }
          Spacer()
          Spacer()
          
          ///Edit Score Button row
          VStack {
            NavigationLink (destination: AddScoreView(names: names, oldscore: oldscore)) {
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
              self.names  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
              self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
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
         ///Check if file exist

                    if Disk.exists("scores.json", in: .documents) {
                      
                      let dateFormatter = DateFormatter()
                      dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
                      dateFormatter.amSymbol = "AM"
                      dateFormatter.pmSymbol = "PM"
                      
                      let defaultPlayer = [Recordline(playerID: "0", playerOneEmoji: "👩🏻",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "recordEntryTimeString", recordAddEdit: true)]
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
//                // Delete file function
//                do {
//                    let filemgr = FileManager.default
//
//                    let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
//
//                    let docsDir = dirPaths[0]
//                    ///put the name of the file to delete here:
//                    let filePath = docsDir.appendingPathComponent("scores.json")
//
//                    try FileManager.default.removeItem(at: filePath)
//                    print("File deleted")
//
//                }
//                catch {
//                    print("Error")
//                }
//                // End of delete function
                let filemgr = FileManager.default

                let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)

                let docsDir = dirPaths[0]

                print("docsDir:\(docsDir)")

//                let records3 = try! Disk.retrieve("scores.json", from: .documents, as: [Recordline].self)
//                print(records3)


                do {
                  //    try Disk.clear(.documents)
                  let filelist = try filemgr.contentsOfDirectory(atPath: docsDir.path)

                  for filename in filelist {
                    print("filename:\(filename)")
                  }
                } catch let error {
                  print("Error: \(error.localizedDescription)")
                }
                
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
