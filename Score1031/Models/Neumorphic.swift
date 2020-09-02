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
 

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}


struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(25)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
            .animation(nil)
    }
}

struct ColorfulToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
                .padding(25)
                .contentShape(Circle())
        }
        .background(
            ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct CircleStyle: ButtonStyle {
  var color: Color = .white
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    
    Group {
      if configuration.isPressed {
//        Circle()
//          .fill()
//          .shadow(color: Color.black.opacity(0.3), radius: 6, x: 6, y: 6)
//          .shadow(color: Color.white.opacity(0.8), radius: 6, x: -3, y: -3)
//          .overlay(
//            configuration.label
//              .foregroundColor(.white)
//        )
        
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
  public func _body(configuration: TextField<Self._Label>) -> some View {
    
    RoundedRectangle(cornerRadius: 30)
      .stroke(Color.offWhite, lineWidth: 5)
      .shadow(color: Color.black.opacity(0.2), radius: 4, x: 5, y: 5)
      .frame(width: 270, height: 50)
      .clipShape(
        RoundedRectangle(cornerRadius: 30)
    )
      .shadow(color: Color.white, radius: 4, x: -3, y: -3)
      .frame(width: 270, height: 50)
      .clipShape(
        RoundedRectangle(cornerRadius: 30)
    )
      .background(Color.offWhite)
      .cornerRadius(40)
      .frame(width: 270, height: 50)
      .overlay(
        configuration
          .foregroundColor(.darkGray)
          .frame(width: 250, height: 50)
        , alignment: .trailing
    )
    
    //    RoundedRectangle(cornerRadius: 25)
    //              .stroke(Color.gray, lineWidth: 3)
    //              .blur(radius: 3)
    //              .offset(x: 2, y: 2)
    //              .mask(RoundedRectangle(cornerRadius: 13).fill(LinearGradient(Color.black, Color.clear)))
    //
    //              .overlay(
    //                  RoundedRectangle(cornerRadius: 13)
    //                      .stroke(color, lineWidth: 8)
    //                      .blur(radius: 3)
    //                      .offset(x: -2, y: -2)
    //                      .mask(RoundedRectangle(cornerRadius: 13).fill(LinearGradient(Color.clear, Color.black)))
    //              )
    //              .overlay(
    //                configuration
    //                  .foregroundColor(.white)
    //            )
    
  }
}


