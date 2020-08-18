//import Foundation
//import SwiftUI
//import Combine
//import CoreData
//import Disk
//import Firebase
//
//struct ContentView2: View {
//  
//  @EnvironmentObject private var nameAndScore: NameAndScore
//  @EnvironmentObject private var userData: UserData
//  @EnvironmentObject private var addEidtChoice: AddEidtChoice
//  @ObservedObject private var apiLoader = APILoader()
//  
//  @State var emojiPlusName = [String]()
//  @State var oldscore = [String]()
//  @State var names = [String]()
//  @State var emojis = [String]()
//  @State var oneEmoji = [String]()
//  @State var twoEmoji = [String]()
//  @State var records = [Recordline]()
//  @State var editMode = false
//  
//  @State var showSignInForm = false
//  
//  var colors: [Color] = [ .niceBlue, .white]
//  @State var index: Int = 0
//  @State var progress: CGFloat = 0
//  
//  @State var scoreEdited = ""
//  @State var reason = ""
//  @State var selectedName = 0
//  @State var selectedNameString = ""
//  @State var pointGrammar = "points"
//  @State var showAlert = false
//  
//  
//  var body: some View {
//    
//    NavigationView{
//      ZStack{
//        if self.editMode == true {
//          Color.babyPP.edgesIgnoringSafeArea(.all)
//        } else {
//          Color.white.edgesIgnoringSafeArea(.all)
//        }
//        
//        
//        VStack {
//          ///Edit Mode Row (60)
//          VStack {
//            HStack{
//              VStack() {
//                Text("Edit Mode")
//                  .font(.system(size:12))
//                Toggle(isOn: $editMode
//                  .animation(
//                    Animation.spring(dampingFraction: 0.7)
//                  )
//                  
//                ) {
//                  Text("Edit Mode")
//                }
//                .labelsHidden()
//              }
//              Spacer()
//              VStack {
//                Text("Emoji Mode")
//                  .font(.system(size:12))
//                Toggle(isOn: $userData.showEmoji
//                  .animation(
//                    Animation.spring(dampingFraction: 0.7)
//                  )
//                  
//                ) {
//                  Text("Emoji Mode")
//                }
//                .labelsHidden()
//                .simultaneousGesture(TapGesture().onEnded {
//                  self.index = (self.index + 1) % self.colors.count
//                })
//              }
//            }
//            .padding(.trailing, 25)
//            .padding(.leading, 25)
//          }///Edit Mode Row
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
//          
//          ///Scoreboard Section
//          ZStack{
//            ///Color Change View
//            VStack {
//              SplashView(animationType: .angle(Angle(degrees: 40)), color: self.colors[self.index])
//                .frame(width: 340, height: 260, alignment: .top)
//                .cornerRadius(20)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
//            }///Color Change View
//            
//            ///Scoreboard Content View
//            VStack {
//              ///Title row (60)
//              VStack {
//                Text("Scoreboard")
//                  .font(.system(size: 23))
//                  .fontWeight(.bold)
//              } ///Title row
//                .frame(width: 340, height: 60, alignment: .center)
//                .border(Color.black)
//              
//              ///Score row (60)
//              HStack {
//                VStack() {
//                  Text("\(self.nameAndScore.PlayerOneScore)")
//                    .font(.system(size: 45))
//                    .foregroundColor(self.editMode ? .gray : .black)
//                }
//                .frame(width: 160, height: 60, alignment: .center)
//                .border(Color.blue)
//                VStack() {
//                  Text("\(self.nameAndScore.PlayerTwoScore)")
//                    .font(.system(size: 45))
//                    .foregroundColor(self.editMode ? .gray : .black)
//                }
//                .frame(width: 160, height: 60, alignment: .center)
//                
//              }///Score row
//                .frame(width: 340, height: 60, alignment: .top)
//              
//              ///NameEmojiRow (140)
//              HStack {
//                ///NameEmojiRow (140) (Normal Mode)
//                if self.editMode == false {
//                  if self.userData.showEmoji == true {
//                    HStack {
//                      VStack{
//                        Text(self.nameAndScore.playerOneEmoji ?? "👩🏻")
//                          .font(.system(size: 45))
//                          .transition(.scale(scale: 5))
//                      }
//                      .frame(width: 160, height: 140, alignment: .center)
//                      .border(Color.green)
//                      VStack{
//                        Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
//                          .font(.system(size: 45))
//                      }
//                      .frame(width: 160, height: 140, alignment: .center)
//                    }
//                    .frame(width: 340, height: 140, alignment: .center)
//                  } else {
//                    HStack {
//                      VStack{
//                        Text(self.nameAndScore.playerOneName ?? "Miu")
//                          .font(.system(size: 28))
//                      }
//                      .frame(width: 160, height: 140, alignment: .center)
//                      VStack{
//                        Text(self.nameAndScore.playerTwoName ?? "Whof")
//                          .font(.system(size: 28))
//                      }
//                      .frame(width: 160, height: 140, alignment: .center)
//                    }
//                    .frame(width: 340, height: 140, alignment: .center)
//                  }
//                } ///NameEmojiRow (140) (Normal Mode)
//                  
//                ///NameEmojiRow (140) (Edit Mode)
//                else {
//                    ///NameEmojiRow (140) (Edit Mode) (Emoji Mode)
//                    if self.userData.showEmoji == true {
//                      HStack {
//                          Button(action: {
//                           self.selectedName = 0
//                          }) {
//                              Text(self.nameAndScore.playerOneEmoji ?? "👩🏻")
//                         //  .foregroundColor(Color.white)
//                           .font(.system(size: 45))
//                          }
//                          .frame(width: 160, height: 140, alignment: .center)
//                          .foregroundColor(.gray)
//                
//                          Button(action: {
//                            self.selectedName = 1
//                           }) {
//                               Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
//                     //       .foregroundColor(Color.white)
//                            .font(.system(size: 45))
//                           }
//                           .frame(width: 160, height: 140, alignment: .center)
//                           .foregroundColor(.gray)
//                        }
//                        .buttonStyle(CircleStyleEmoji())
//                        .border(Color.green)
//                    }///NameEmojiRow (140) (Edit Mode) (Emoji Mode)
//                    else {
//                      HStack {
//                          Text("Bubu")
//                      }
//                  }
//
//
//                
//                  //                      Circle().strokeBorder(Color.gray, lineWidth: 5)
//                  //                        .aspectRatio(contentMode: .fit)
//                  //                        .overlay(Text(self.nameAndScore.playerOneEmoji ?? "👩🏻")
//                  //                          .font(.system(size: 45))
//                  //                          .transition(.scale(scale: 5))
//                  //                          .padding(0))
//                  //                        .modifier(FitToWidth(fraction: 3))
//                  //
//                  //                        .frame(width: 160, height: 140, alignment: .center)
//                  //                        .border(Color.black)
//                  //
//                  //                      Circle().strokeBorder(Color.blue, lineWidth: 5)
//                  //                        .aspectRatio(contentMode: .fit)
//                  //                        .overlay(Text(self.nameAndScore.playerTwoEmoji ?? "👨🏻")
//                  //                          .font(.system(size: 45))
//                  //                          .transition(.scale(scale: 5))
//                  //                          .padding(0))
//                  //                        .modifier(FitToWidth(fraction: 3))
//                  //
//                  //                        .frame(width: 160, height: 140, alignment: .center)
//                  //                        .border(Color.black)
//                  //                    }
//                  //                    .frame(width: 340, height: 140, alignment: .center)
//                  //                    .border(Color.red)
//                  //                  } else {
//                  //                    HStack {
//                  //                      VStack() {
//                  //                        Text(self.nameAndScore.playerOneName ?? "Miu")
//                  //                          .font(.system(size: 28))
//                  //                      } .frame(width: 160, height: 140, alignment: .center)
//                  //                      VStack() {
//                  //                        Text(self.nameAndScore.playerTwoName ?? "Whof")
//                  //                          .font(.system(size: 28))
//                  //                      } .frame(width: 160, height: 140, alignment: .center)
//                  //                    }
//                  //                    .frame(width: 340, height: 140, alignment: .center)
//                  //                    .border(Color.black)
//                }///NameEmojiRow (140) (Edit Mode)
//                
//              } //NameEmojiRow
//                .frame(width: 340, height: 140, alignment: .top)
//          }///Scoreboard Content View
//            .frame(width: 340, height: 260, alignment: .top)
//            .border(Color.red)
//        }///Scoreboard Section
//          .frame(width: 340, height: 260, alignment: .top)
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        if self.editMode == false {
//          ///Add Score Button row
//          VStack {
//            Spacer()
//            VStack {
//              VStack {
//                NavigationLink (destination:
//                  //%%%%%%%%%%%%%%%%%%%%
//                  //  AddScoreView
//                EditModeView(oldscore: oldscore, names: names, emojis: emojis)){
//                  Text("Add Score!")
//                    .fontWeight(.semibold)
//                }
//                .frame(width: 89, height: 8, alignment: .center)
//                .padding()
//                .foregroundColor(.white)
//                .background(LinearGradient(gradient: Gradient(colors: [Color("isaacblue"), Color("destinygreen")]), startPoint: .leading, endPoint: .trailing))
//                  
//                .cornerRadius(13)
//                .simultaneousGesture(TapGesture().onEnded {
//                  self.addEidtChoice.addViewSelected = true
//                  self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
//                  self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
//                  self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
//                  self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
//                })
//                
//              }.border(Color.green)
//                .padding()
//              //  Spacer()
//              
//              ///Edit Score Button row
//              VStack {
//                NavigationLink (destination: NameEmojiRowView()) {
//                  Text("Edit Score!")
//                    .fontWeight(.semibold)
//                }
//                .frame(width: 89, height: 8, alignment: .center)
//                .padding()
//                .foregroundColor(.white)
//                .background(LinearGradient(gradient: Gradient(colors: [Color("destinygreen"), Color("isaacblue")]), startPoint: .leading, endPoint: .trailing))
//                .cornerRadius(13)
//                  
//                .simultaneousGesture(TapGesture().onEnded {
//                  self.addEidtChoice.addViewSelected = false
//                  self.emojiPlusName  = ["\(self.nameAndScore.playerOneEmoji!) \( self.nameAndScore.playerOneName!)","\( self.nameAndScore.playerTwoEmoji!) \( self.nameAndScore.playerTwoName!)"]
//                  self.oldscore = ["\(self.nameAndScore.PlayerOneScore)", "\(self.nameAndScore.PlayerTwoScore)"]
//                  self.emojis = [self.nameAndScore.playerOneEmoji!, self.nameAndScore.playerTwoEmoji!]
//                  self.names = [self.nameAndScore.playerOneName!, self.nameAndScore.playerTwoName!]
//                })
//                
//              }
//            }.border(Color.blue)
//            Spacer()
//            Spacer()
//          }.border(Color.green)
//        } else {
//          //            VStack {
//          //              if addEidtChoice.addViewSelected == true {
//          //                TextField("Score to add", text: $scoreEdited)
//          //                  .textFieldStyle(RoundedBorderTextFieldStyle())
//          //                  .keyboardType(.numberPad)
//          //                  .padding(.trailing, 35)
//          //                  .padding(.leading, 35)
//          //              } else {
//          //                TextField("New Score", text: $scoreEdited)
//          //                  .textFieldStyle(RoundedBorderTextFieldStyle())
//          //                  .keyboardType(.numberPad)
//          //                  .padding(.trailing, 35)
//          //                  .padding(.leading, 35)
//          //              }
//          //
//          //              TextField("What for?", text: $reason)
//          //                .textFieldStyle(RoundedBorderTextFieldStyle())
//          //                .padding(.trailing, 35)
//          //                .padding(.leading, 35)
//          //
//          //              Spacer()
//          //            } .border(Color.green)
//        }
//        if self.editMode == false {
//          VStack {
//            
//            /// View History row
//            HStack {
//              VStack {
//                NavigationLink (destination: HistoryView()
//                  .navigationBarTitle(Text("x"))
//                  .navigationBarHidden(true)
//                  )
//                {
//                  VStack() {
//                    Image(systemName: "eye").font(.system(size:20))
//                    Text("View History")
//                      .fontWeight(.light)
//                      .font(.system(size:12))
//                  }
//                }
//                .padding()
//                //       Spacer()
//              }
//              Spacer()
//              VStack() {
//                NavigationLink (destination: ChangePlayersView())
//                {
//                  VStack() {
//                    Image(systemName: "person.2.square.stack").font(.system(size:20))
//                    Text("Change Players")
//                      .fontWeight(.light)
//                      .font(.system(size:12))
//                  }
//                  .padding()
//                }
//                .disabled(self.apiLoader.queryPlayerList().count < 2)
//              }
//              Spacer()
//              VStack {
//                NavigationLink (destination: AddNewPlayerView())
//                {
//                  VStack() {
//                    Image(systemName: "person.crop.circle.badge.plus").font(.system(size:20))
//                    Text("Add Players")
//                      .fontWeight(.light)
//                      .font(.system(size:12))
//                  }
//                }
//                .padding()
//                //     Spacer()
//              }
//            }
//            
//            //  Spacer()
//            HStack {
//              
//              Button(action: {
//                self.nameAndScore.PlayerTwoScore = 0
//                self.nameAndScore.PlayerOneScore = 0
//                self.nameAndScore.playerTwoName = "Player Two"
//                self.nameAndScore.playerOneName = "Player One"
//                self.nameAndScore.playerOneEmoji = "👩🏻"
//                self.nameAndScore.playerTwoEmoji = "👨🏻"
//                self.userData.playerID = "0"
//                
//                self.apiLoader.remove()
//                
//                
//              })
//              {
//                Text("Start Over")
//              }
//              Button(action: {
//                
//                self.apiLoader.fetchData()
//                print ("This is what I am looking for \(self.apiLoader.records)")
//                
//              })
//              {
//                Text("file path")
//              }
//            }
//          }.border(Color.red)
//        } else {
//          VStack() {
//            EditModeView()
//          }.border(Color.red)
//        }
//      }
//    }//.border(Color.purple)
//    
//  }
//  .onAppear() {
//  if self.nameAndScore.playerTwoName == nil {
//  self.nameAndScore.PlayerTwoScore = 0
//  self.nameAndScore.PlayerOneScore = 0
//  self.nameAndScore.playerTwoName = "Player Two"
//  self.nameAndScore.playerOneName = "Player One"
//  self.nameAndScore.playerOneEmoji = "👩🏻"
//  self.nameAndScore.playerTwoEmoji = "👨🏻"
//  self.userData.playerID = "0"
//  }
//  }
//}
//
//
//
//
//struct ContentView2_Previews: PreviewProvider {
//  static var previews: some View {
//    ForEach(["iPhone XS Max"], id: \.self) { deviceName in
//      ContentView2()
//        .previewDevice(PreviewDevice(rawValue: deviceName))
//        .previewDisplayName(deviceName)
//    }
//    .environmentObject(NameAndScore())
//    .environmentObject(UserData())
//    
//  }
//}
//
//}
