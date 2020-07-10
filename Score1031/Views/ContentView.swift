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

    //CoreData var
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Record.getAllRecords()) var records: FetchedResults<Record>
    @State var names = [String]()
    @State var oldscore = [String]()
    @State var oneEmoji = [String]()
    @State var twoEmoji = [String]()
    @State var filteredRecords3 = [Recordline]()
    
    
    var body: some View {
        NavigationView{
        VStack {

            VStack {
                //Toggle row
                VStack {
                    
                    HStack{
                        NavigationLink (destination: NewSelectPlayersView(filteredRecords3: self.filteredRecords3))
                        {
                            Text("Change Players")
                                .fontWeight(.light)
                                .font(.system(size:15))
                                .padding()
                        }
                        .simultaneousGesture(TapGesture().onEnded {
        //query a list of id that is the most recent record for each player
                        let records3 = try! Disk.retrieve("scores.json", from: .documents, as: [Recordline].self).sorted(by: { $0.recordEntryTime! >= $1.recordEntryTime!})
                            
                        let recordSet = Set<String>(try! Disk.retrieve("scores.json", from: .documents, as: [Recordline].self).map{$0.playerID})
                            print(recordSet)

                            print(records3)
                                                       
                            var resultArray = [String]()
                            
                            for playerID in recordSet {
                                let id = records3.filter({$0.playerID == playerID}).map{$0.id}.first
                                resultArray.append(id!)
                            }
                           //     print(resultArray)
                            self.filteredRecords3.removeAll()
                            for id in resultArray {
                                let filtered = records3.filter({$0.id == id}).first
                                print("\(id) -> \(filtered)")
                                self.filteredRecords3.append(filtered!)
                            }
                                print(self.filteredRecords3)
                            
                // This step is to save the current score to the Player entity, becuase this button will lead user to change to other players, and before changing to other players we need save the current players. 
                            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Player")
                            fetchRequest.predicate = NSPredicate(format: "playerID == %@", self.userData.playerID!)
                            do
                            {
                                let player = try self.managedObjectContext.fetch(fetchRequest)

                                    let objectUpdate = player[0] as! NSManagedObject
                                    objectUpdate.setValue(self.nameAndScore.PlayerOneScore, forKey: "playerOneScore")
                                    objectUpdate.setValue(self.nameAndScore.PlayerTwoScore, forKey: "playerTwoScore")
                                do{
                                    try self.managedObjectContext.save()
                                }
                                catch
                                {
                                    print(error)
                                }
                            }
                            catch
                            {
                                print(error)
                            }
                            //json data query
                            
                        })
                            .disabled(Player.getProductCount() < 2 )
                        
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
                //Title row
                Spacer()
                Text("Scoreboard")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(0.0)
                Spacer()
                //Score row
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
            //Add Score Button row
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
            //Edit Score Button row
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
            // View History row
                    
                HStack {
                    VStack {
                        NavigationLink (destination: NewHistoryView())

                        {
                            Text("View History")
                                .fontWeight(.light)
                                .font(.system(size:15))
                        }
                        .padding()
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        NavigationLink (destination: ZChangePlayerView())
                        {
                            Text("Add Players")
                                .fontWeight(.light)
                                .font(.system(size:15))
                        }
                        .padding()
                            
// Set player record with updated scores
                        .simultaneousGesture(TapGesture().onEnded {
                            if Player.getProductCount() == 0 {
                            self.userData.playerID = "0"
                            self.userData.maxPlayerID = 0
                            let player = Player(context: self.managedObjectContext)
                            player.playerID = self.userData.playerID ?? "0"
                            player.playerOneEmoji = self.nameAndScore.playerOneEmoji
                            player.playerTwoEmoji = self.nameAndScore.playerTwoEmoji
                            player.playerOneName = self.nameAndScore.playerOneName
                            player.playerTwoName = self.nameAndScore.playerTwoName
                            player.playerOneScore = Int16(self.nameAndScore.PlayerOneScore)
                            player.playerTwoScore = Int16(self.nameAndScore.PlayerTwoScore)
                            } else {
                            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Player")
                            fetchRequest.predicate = NSPredicate(format: "playerID == %@", self.userData.playerID!)
                            do
                            {
                                let player = try self.managedObjectContext.fetch(fetchRequest)
                                let objectUpdate = player[0] as! NSManagedObject
                                objectUpdate.setValue(self.nameAndScore.PlayerOneScore, forKey: "playerOneScore")
                                objectUpdate.setValue(self.nameAndScore.PlayerTwoScore, forKey: "playerTwoScore")
                                do{
                                    try self.managedObjectContext.save()
                                }
                                catch
                                {
                                    print(error)
                                }
                            }
                            catch
                            {
                                print(error)
                            }
                            }
                        })
                        
                        Spacer()
                    }
                }
                    
                    Spacer()
                    HStack {
                        
                        Button(action: {
                            self.nameAndScore.PlayerTwoScore = 0
                            self.nameAndScore.PlayerOneScore = 0
                        //Delete all Record Data rows
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
                        fetchRequest.includesPropertyValues = false
                        
                        do {
                            let items = try self.managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
                            for item in items {
                                self.managedObjectContext.delete(item)
                            }
                            try self.managedObjectContext.save()
                        } catch let error {
                            print("Detele all data in Record error :", error)
                        }
                        //Delete all Player Data rows
                            let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
                            fetchRequest2.includesPropertyValues = false
                            
                            do {
                                let items = try self.managedObjectContext.fetch(fetchRequest2) as! [NSManagedObject]
                                for item in items {
                                    self.managedObjectContext.delete(item)
                                }
                                try self.managedObjectContext.save()
                            } catch let error {
                                print("Detele all data in Record error :", error)
                            }
                            
                            
                            
                        })
                        {
                            Text("Start Over")
                        }
                        Button(action: {
  // Delete file function
//                            do {
//                                let filemgr = FileManager.default
//
//                                let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
//
//                                let docsDir = dirPaths[0]
//                                //put the name of the file to delete here:
//                                let filePath = docsDir.appendingPathComponent("scores2.json")
//
//                                try FileManager.default.removeItem(at: filePath)
//                                print("File deleted")
//
//                            }
//                            catch {
//                                print("Error")
//                            }
  // End of delete function
                            let filemgr = FileManager.default

                            let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)

                            let docsDir = dirPaths[0]

                            print("docsDir:\(docsDir)")
                            
                            do {
                            //    try Disk.clear(.documents)
                                let filelist = try filemgr.contentsOfDirectory(atPath: docsDir.path)

                                for filename in filelist {
                                    print("filename:\(filename)")
                                }
                            } catch let error {
                                print("Error: \(error.localizedDescription)")
                            }
                            
                            
                            
                            do {
//                             let records3Dic = Dictionary(grouping: try! Disk.retrieve("scores.json", from: .documents, as: [Recordline].self), by: { $0.playerID })
//                              print(records3Dic)
                           
//                                let playerOneEmoji = records3.filter({$0.playerID == playerID}).map{$0.playerOneEmoji}
//                                let playerOneName = records3.filter({$0.playerID == playerID}).map{$0.playerOneName}
//                                let playerOneScore = records3.filter({$0.playerID == playerID}).map{$0.playerOneScore}
//                                let playerTwoEmoji = records3.filter({$0.playerID == playerID}).map{$0.playerTwoEmoji}
//                                let playerTwoName = records3.filter({$0.playerID == playerID}).map{$0.playerTwoName}
//                                let playerTwoScore = records3.filter({$0.playerID == playerID}).map{$0.playerTwoScore}
                                    
     //                           resultArray.append(Playerline(
     //                                   id: id
//                                    ,
//                                        playerID: playerID, playerOneEmoji:playerOneEmoji, playerOneName:playerOneName, playerOneScore:playerOneScore, playerTwoEmoji:playerTwoEmoji, playerTwoName:playerTwoName, playerTwoScore:playerTwoScore
     //                               ))
                                    
                                }
       //                         print(resultArray)
                                
                // ^^%&*(*& remove this one
//                                let records3 = try Disk.retrieve("scores.json", from: .documents, as: [Recordline].self)
//
//                               print(records3)
                                
                                
//                                let mirror = Mirror(reflecting: records3)
//
//                                for child in mirror.children  {
//                                    print("key: \(child.label), value: \(child.value)")
//                                }
//
//                                for playerID in records3.playerID {
//                                    print("filename:\(records3.playerID)")
//                                }

//                            
//                             var plistURL: URL {
//                              let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//                              return documents.appendingPathComponent("api_records3.plist")
//                            }
//                            print("plistURL:\(plistURL)")
//                            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//                             let url = NSURL(fileURLWithPath: path)
//                             if let pathComponent = url.appendingPathComponent("api_records3") {
//                                 let filePath = pathComponent.path
//                                 let fileManager = FileManager.default
//                                 if fileManager.fileExists(atPath: filePath) {
//                                     print("FILE AVAILABLE")
//                                 } else {
//                                     print("FILE NOT AVAILABLE")
//                                 }
//                             } else {
//                                 print("FILE PATH NOT AVAILABLE")
//                             }

                        })
                        {
                            Text("file path")
                        }
                    }
                }
            }
            }} }
    



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
