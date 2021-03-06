//
//  Neumorphic.swift
//  Score1031
//
//  Created by Danting Li on 8/26/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//


import Foundation
import SwiftUI
import Combine
import UIKit



extension LinearGradient {
  init(_ colors: Color...) {
    self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
  }
}


struct CircleStyle: ButtonStyle {
  var color: Color = .offWhite01
  func makeBody(configuration: Configuration) -> some View {
    
    Circle()
      .fill()
      .shadow(color: configuration.isPressed ? Color.white.opacity(0) : Color.white.opacity(0.9), radius: 5, x: -3, y: -3)
      .shadow(color: configuration.isPressed ? Color.offGray01.opacity(0) : Color.offGray01.opacity(1), radius: 4, x: 5.5, y: 5.5)
      
      
      // for is pressed
      .overlay(
        Circle()
          .stroke(!configuration.isPressed ? Color.clear : Color.offGray03, lineWidth: 3)
          .blur(radius: 3)
          .offset(x: 2, y: 2)
          .mask(Circle().fill(LinearGradient(!configuration.isPressed ? Color.clear : Color.offblack03, Color.clear)))
          
          .overlay(
            Circle()
              .stroke(!configuration.isPressed ? Color.clear : color, lineWidth: 8)
              .blur(radius: 3)
              .offset(x: -2, y: -2)
              .mask(Circle().fill(LinearGradient(Color.clear, !configuration.isPressed ? Color.clear : Color.offblack03)))
          )
      )
      
      .overlay(
        configuration.label
          .foregroundColor(.offWhite01)
      )
  }
}

public struct NeuTextStyle : TextFieldStyle {
  var color: Color = .white
  var w: CGFloat = 270
  var h:CGFloat = 50
  var cr:CGFloat = 15
  
  public func _body(configuration: TextField<Self._Label>) -> some View {
    
    RoundedRectangle(cornerRadius: cr)
      .stroke(Color.offWhite02, lineWidth: 5)
      .shadow(color: Color.offGray01.opacity(1), radius: 4, x: 5, y: 5)
      .frame(width: w, height: h)
      .clipShape(
        RoundedRectangle(cornerRadius: cr)
    )
      .shadow(color: Color.white, radius: 4, x: -3, y: -3)
      .frame(width: w, height: h)
      .clipShape(
        RoundedRectangle(cornerRadius: cr)
    )
      .background(Color.offWhite02)
      .cornerRadius(cr + 5)
      .frame(width: w, height: h)
      .overlay(
        configuration
          .foregroundColor(.offblack01)
          .frame(width: w - 25, height: h)
        , alignment: .center
    )
  }
}

struct NeuButtonStyle: ButtonStyle {
  var color: Color = .white
  var editedScore: Int = 0
  var reason: String = "ABC"
  var selectedName: Int = 3
  var w: CGFloat = 85
  var h:CGFloat = 45
  
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    
    Group {
      if ((editedScore == 0 && reason.isEmpty) || selectedName == 5) {
        RoundedRectangle(cornerRadius: 30)
          .fill(Color.offWhite02)
          .shadow(color: Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
          .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
          .frame(width: w, height: h)
          .overlay(
            configuration.label
              .foregroundColor(.offGray01)
        )
      }
      else {

        RoundedRectangle(cornerRadius: 30)
          .fill(Color.offWhite02)
          .shadow(color: configuration.isPressed ? Color.offGray01.opacity(0) : Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
          .shadow(color: configuration.isPressed ? Color.white.opacity(0) : Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
          .frame(width: w, height: h)
          
          // for is pressed
          .overlay(
          RoundedRectangle(cornerRadius: 30)
            .stroke(!configuration.isPressed ? Color.offWhite02.opacity(0) : Color.offWhite02, lineWidth: 5)
            .shadow(color: !configuration.isPressed ? Color.offGray01.opacity(0) : Color.offGray01.opacity(0.9), radius: 3.5, x: 4, y: 4)
            .frame(width: w + 5, height: h + 5)
            .clipShape(
              RoundedRectangle(cornerRadius: 30)
          )
            .shadow(color: !configuration.isPressed ? Color.white.opacity(0) : Color.white, radius: 4, x: -3, y: -3)
            .frame(width: w + 5, height: h + 3)
            .clipShape(
              RoundedRectangle(cornerRadius: 30)
          )
          )

          .overlay(
            configuration.label
              .foregroundColor(.offblack02)
        )
      }
    }
    
    
  }
}

struct NeuButtonStyle2: ButtonStyle {
  var addPlayerOneName = ""
  var addPlayerOneEmoji = ""
  var addPlayerTwoName = ""
  var addPlayerTwoEmoji = ""

  var w: CGFloat = 85
  var h:CGFloat = 45
  
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    
    Group {
//      if configuration.isPressed {
//
//        RoundedRectangle(cornerRadius: 30)
//          .stroke(Color.offWhite02, lineWidth: 5)
//          .shadow(color: Color.offGray01.opacity(1), radius: 3.5, x: 5, y: 5)
//          .frame(width: w, height: h)
//          .clipShape(
//            RoundedRectangle(cornerRadius: 30)
//        )
//          .shadow(color: Color.white, radius: 4, x: -3, y: -3)
//          .frame(width: w, height: h)
//          .clipShape(
//            RoundedRectangle(cornerRadius: 30)
//        )
//          .background(Color.offWhite02)
//          .cornerRadius(40)
//          .frame(width: w, height: h)
//          .overlay(
//            configuration.label
//              .foregroundColor(.offblack02)
//        )
//
//      } else
      if
        addPlayerOneName.isEmpty ||
        addPlayerOneEmoji.isEmpty ||
        addPlayerTwoName.isEmpty ||
        addPlayerTwoEmoji.isEmpty ||
        addPlayerOneEmoji.containsEmoji == false ||
        addPlayerTwoEmoji.containsEmoji == false
    {
        RoundedRectangle(cornerRadius: 30)
          .fill(Color.offWhite02)
          .shadow(color: Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
          .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
          .frame(width: w, height: h)
          .overlay(
            configuration.label
              .foregroundColor(.offGray01)
        )
      }
      else {
        
        RoundedRectangle(cornerRadius: 30)
          .fill(Color.offWhite02)
          .shadow(color: configuration.isPressed ? Color.offGray01.opacity(0) : Color.offGray01.opacity(1), radius: 5, x: 6, y: 6)
          .shadow(color: configuration.isPressed ? Color.white.opacity(0) : Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
          .frame(width: w, height: h)
          
          // for is pressed
          .overlay(
          RoundedRectangle(cornerRadius: 30)
            .stroke(!configuration.isPressed ? Color.offWhite02.opacity(0) : Color.offWhite02, lineWidth: 5)
            .shadow(color: !configuration.isPressed ? Color.offGray01.opacity(0) : Color.offGray01.opacity(0.9), radius: 3.5, x: 4, y: 4)
            .frame(width: w + 5, height: h + 5)
            .clipShape(
              RoundedRectangle(cornerRadius: 30)
          )
            .shadow(color: !configuration.isPressed ? Color.white.opacity(0) : Color.white, radius: 4, x: -3, y: -3)
            .frame(width: w + 5, height: h + 3)
            .clipShape(
              RoundedRectangle(cornerRadius: 30)
          )
          )

          .overlay(
            configuration.label
              .foregroundColor(.offblack02)
        )
      }
    }
    
    
  }
}


