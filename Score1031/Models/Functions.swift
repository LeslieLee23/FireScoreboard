//
//  Functions.swift
//  Score1031
//
//  Created by Danting Li on 7/15/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import Resolver
import Disk
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


extension String {
  
  var containsEmoji: Bool {
    for scalar in unicodeScalars {
      switch scalar.value {
      case 0x1F600...0x1F64F, // Emoticons
      0x1F300...0x1F5FF, // Misc Symbols and Pictographs
      0x1F680...0x1F6FF, // Transport and Map
      0x2600...0x26FF,   // Misc symbols
      0x2700...0x27BF,   // Dingbats
      0xFE00...0xFE0F,   // Variation Selectors
      0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
      0x1F1E6...0x1F1FF: // Flags
        return true
      default:
        continue
      }
    }
    return false
  }
  
}

extension Color {
  static let babyPP = Color(red: 184 / 255, green: 200 / 255, blue: 243 / 255)
  static let niceBlue = Color(red: 161 / 255, green: 217 / 255, blue: 241 / 255)
  static let grayCircle = Color(red: 157 / 255, green: 157 / 255, blue: 157 / 255)
  static let offWhite = Color(red: 223 / 255, green: 228 / 255, blue: 235 / 255)
  static let darkGray = Color(red: 70 / 255, green: 70 / 255, blue: 70 / 255)
  static let lightGray = Color(red: 206 / 255, green: 206 / 255, blue: 206 / 255)
  static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
  static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
  static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
  static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)

  
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
  static let offWhite = UIColor(red: 223, green: 228, blue: 235)
   
}

class AddScoreFunc: ObservableObject {
  func createRecord(playerID: String, oldscore: [String], emojiPlusName: [String], names: [String], emojis: [String], editedScore: Int, reason: String, selectedName: Int) -> (Recordline) {
    var record = Recordline(playerID: "0", playerOneEmoji: "✨",playerOneName: "Player One", playerOneScore: 0, playerTwoEmoji: "👨🏻", playerTwoName: "Player Two", playerTwoScore: 0, recordName: "Player one and two", recordScore: "NA", recordReason: "Default players created", recordEntryTime: Date(), recordEntryTimeString: "",
                            recordNameStr: "recordNameStrGUAGUA", recordNameEmo: "💩")
    
    record.id = UUID().uuidString
    record.recordReason = reason
    record.recordEntryTime = Date()
    record.playerID = playerID
    record.playerOneEmoji = emojis[0]
    record.playerTwoEmoji = emojis[1]
    record.playerOneName = names[0]
    record.playerTwoName = names[1]
    record.recordEntryTimeString = getDateString(Date: record.recordEntryTime!)
    record.userId = Auth.auth().currentUser?.uid
    print("&&&&&UserID\(String(describing: record.userId))")
    
    
    ///AddView
    //   if addViewSelected == true {
    
    if selectedName == 0 {
      record.playerOneScore = Int(oldscore[0])! + editedScore
      record.playerTwoScore = Int(oldscore[1])!
      record.recordName = emojiPlusName[0]
      record.recordNameStr = names[0]
      record.recordNameEmo = emojis[0]
    } else if selectedName == 1 {
      record.playerTwoScore = Int(oldscore[1])! + editedScore
      record.playerOneScore = Int(oldscore[0])!
      record.recordName = emojiPlusName[1]
      record.recordNameStr = names[1]
      record.recordNameEmo = emojis[1]
      
    }
    
    
    if String(editedScore).first == "-" || String(editedScore) == "0" {
      record.recordScore = String(editedScore)
    } else {
      record.recordScore = "+\(String(editedScore))"
    }
    print(record)
    return record
    
  }
  
}

func getDateString(Date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
  dateFormatter.amSymbol = "AM"
  dateFormatter.pmSymbol = "PM"
  
  let dateTimeString = dateFormatter.string(from: Date)
  return dateTimeString
}

struct SplashShape: Shape {
  
  public enum SplashAnimation {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
    case angle(Angle)
    case circle
  }
  
  var progress: CGFloat
  var animationType: SplashAnimation
  
  var animatableData: CGFloat {
    get { return progress }
    set { self.progress = newValue}
  }
  
  func path(in rect: CGRect) -> Path {
    
    switch self.animationType {
    case .leftToRight:
      return leftToRight(rect: rect)
    case .rightToLeft:
      return rightToLeft(rect: rect)
    case .topToBottom:
      return topToBottom(rect: rect)
    case .bottomToTop:
      return bottomToTop(rect: rect)
    case .angle(let splashAngle):
      return angle(rect: rect, angle: splashAngle)
    case .circle:
      return circle(rect: rect)
    }
    
  }
  
  func leftToRight(rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: 0)) // Top Left
    path.addLine(to: CGPoint(x: rect.width * progress, y: 0)) // Top Right
    path.addLine(to: CGPoint(x: rect.width * progress, y: rect.height)) // Bottom Right
    path.addLine(to: CGPoint(x: 0, y: rect.height)) // Bottom Left
    path.closeSubpath() // Close the Path
    return path
  }
  
  func rightToLeft(rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.width, y: 0))
    path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: 0))
    path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: rect.height))
    path.addLine(to: CGPoint(x: rect.width, y: rect.height))
    path.closeSubpath()
    return path
  }
  
  func topToBottom(rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: rect.width, y: 0))
    path.addLine(to: CGPoint(x: rect.width, y: rect.height * progress))
    path.addLine(to: CGPoint(x: 0, y: rect.height * progress))
    path.closeSubpath()
    return path
  }
  
  func bottomToTop(rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.height))
    path.addLine(to: CGPoint(x: rect.width, y: rect.height))
    path.addLine(to: CGPoint(x: rect.width, y: rect.height - (rect.height * progress)))
    path.addLine(to: CGPoint(x: 0, y: rect.height - (rect.height * progress)))
    path.closeSubpath()
    return path
  }
  
  func circle(rect: CGRect) -> Path {
    let a: CGFloat = rect.height / 2.0
    let b: CGFloat = rect.width / 2.0
    
    let c = pow(pow(a, 2) + pow(b, 2), 0.5)
    let radius = c * progress
    // Build Circle Path
    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
    return path
    
  }
  
  func angle(rect: CGRect, angle: Angle) -> Path {
    
    var cAngle = Angle(degrees: angle.degrees.truncatingRemainder(dividingBy: 90))
    
    // Return Path Using Other Animations (topToBottom, leftToRight, etc) if angle is 0, 90, 180, 270
    if angle.degrees == 0 || cAngle.degrees == 0 { return leftToRight(rect: rect)}
    else if angle.degrees == 90 || cAngle.degrees == 90 { return topToBottom(rect: rect)}
    else if angle.degrees == 180 || cAngle.degrees == 180 { return rightToLeft(rect: rect)}
    else if angle.degrees == 270 || cAngle.degrees == 270 { return bottomToTop(rect: rect)}
    
    
    // Calculate Slope of Line and inverse slope
    let m = CGFloat(tan(cAngle.radians))
    let m_1 = pow(m, -1) * -1
    let h = rect.height
    let w = rect.width
    
    // tan (angle) = slope of line
    // y = mx + b ---> b = y - mx   ~ 'b' = y intercept
    let b = h - (m_1 * w) // b = y - (m * x)
    
    // X and Y coordinate calculation
    var x = b * m * progress
    var y = b * progress
    
    // Triangle Offset Calculation
    let xOffset = (angle.degrees > 90 && angle.degrees < 270) ? rect.width : 0
    let yOffset = (angle.degrees > 180 && angle.degrees < 360) ? rect.height : 0
    
    // Modify which side the triangle is drawn from depending on the angle
    if angle.degrees > 90 && angle.degrees < 180 { x *= -1 }
    else if angle.degrees > 180 && angle.degrees < 270 { x *= -1; y *= -1 }
    else if angle.degrees > 270 && angle.degrees < 360 { y *= -1 }
    
    // Build Triangle Path
    var path = Path()
    path.move(to: CGPoint(x: xOffset, y: yOffset))
    path.addLine(to: CGPoint(x: xOffset + x, y: yOffset))
    path.addLine(to: CGPoint(x: xOffset, y: yOffset + y))
    path.closeSubpath()
    return path
    
  }
}

struct FitToWidth: ViewModifier {
  var fraction: CGFloat = 1.0
  func body(content: Content) -> some View {
    GeometryReader { g in
      content
        .font(.system(size: 1000))
        .minimumScaleFactor(0.005)
        .lineLimit(1)
        .frame(width: g.size.width*self.fraction)
    }
  }
}


struct CircleStyleEmoji: ButtonStyle {
  var color: Color = .green
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    
    Circle()
      .strokeBorder(color, lineWidth: 6.5)
      
      .opacity(configuration.isPressed ? 0.3 : 1)
      .aspectRatio(contentMode: .fit)
      .overlay(
        configuration.label
          .transition(.scale(scale: 5))
          .opacity(configuration.isPressed ? 0.3 : 1)
    )
      .modifier(FitToWidth(fraction: 3))
      .frame(width: 160, height: 125, alignment: .center)
    
  }
}

struct SquareStyle: ButtonStyle {
  var color: Color = .green
  func makeBody(configuration: Self.Configuration) -> some View {
    RoundedRectangle(cornerRadius: 13)
      .stroke(color, lineWidth: 7.5)
      .frame(width: 135, height: 60, alignment: .center)
      .cornerRadius(13)
      .opacity(configuration.isPressed ? 0.3 : 1)
      .aspectRatio(contentMode: .fit)
      .overlay(
        configuration.label
          .transition(.scale(scale: 5))
          .opacity(configuration.isPressed ? 0.3 : 1)
    )
      .modifier(FitToWidth(fraction: 3))
      .frame(width: 135, height: 60, alignment: .center)
  }
}


struct Functions_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}


