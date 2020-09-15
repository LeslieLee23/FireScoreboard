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
  var color: Color = .white
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    
    Group {
      if configuration.isPressed {
        
        Circle()
          .stroke(Color.gray, lineWidth: 3)
          .blur(radius: 3)
          .offset(x: 2, y: 2)
          .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
          
          .overlay(
            Circle()
              .stroke(color, lineWidth: 8)
              .blur(radius: 3)
              .offset(x: -2, y: -2)
              .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
        )
          .overlay(
            configuration.label
              .foregroundColor(.white)
        )
        
      } else {
        Circle()
          .fill()
          .shadow(color: Color.black.opacity(0.3), radius: 6, x: 6, y: 6)
          .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
          .overlay(
            configuration.label
              .foregroundColor(.white)
        )
      }
    }
    
    
  }
}

public struct NeuTextStyle : TextFieldStyle {
  var color: Color = .white
  var w: CGFloat = 270
  var h:CGFloat = 50
  var cr:CGFloat = 30
  
  public func _body(configuration: TextField<Self._Label>) -> some View {
    
    RoundedRectangle(cornerRadius: cr)
      .stroke(Color.offWhite, lineWidth: 5)
      .shadow(color: Color.black.opacity(0.2), radius: 4, x: 5, y: 5)
      .frame(width: w, height: h)
      .clipShape(
        RoundedRectangle(cornerRadius: cr)
    )
      .shadow(color: Color.white, radius: 4, x: -3, y: -3)
      .frame(width: w, height: h)
      .clipShape(
        RoundedRectangle(cornerRadius: cr)
    )
      .background(Color.offWhite)
      .cornerRadius(cr + 10)
      .frame(width: w, height: h)
      .overlay(
        configuration
          .foregroundColor(.darkGray)
          .frame(width: w - 20, height: h)
        , alignment: .trailing
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
      if configuration.isPressed {
        
        RoundedRectangle(cornerRadius: 30)
          .stroke(Color.offWhite, lineWidth: 5)
          .shadow(color: Color.black.opacity(0.2), radius: 4, x: 5, y: 5)
          .frame(width: w, height: h)
          .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
          .shadow(color: Color.white, radius: 4, x: -3, y: -3)
          .frame(width: w, height: h)
          .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
          .background(Color.offWhite)
          .cornerRadius(40)
          .frame(width: w, height: h)
          .overlay(
            configuration.label
              .foregroundColor(.darkGray)
        )
        
      } else if ((editedScore == 0 && reason.isEmpty) || selectedName == 5) {
        RoundedRectangle(cornerRadius: 30)
          .fill(Color.offWhite)
          .shadow(color: Color.black.opacity(0.2), radius: 6, x: 6, y: 6)
          .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
          .frame(width: w, height: h)
          .overlay(
            configuration.label
              .foregroundColor(.lightGray)
        )
      }
      else {
        RoundedRectangle(cornerRadius: 30)
          .fill(Color.offWhite)
          .shadow(color: Color.black.opacity(0.2), radius: 6, x: 6, y: 6)
          .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
          .frame(width: w, height: h)
          .overlay(
            configuration.label
              .foregroundColor(.darkGray)
        )
      }
    }
    
    
  }
}

