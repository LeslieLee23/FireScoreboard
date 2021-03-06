//
//  Styles.swift
//  Score1031
//
//  Created by Danting Li on 9/15/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit

extension Color {
  static let babyPP = Color(red: 184 / 255, green: 200 / 255, blue: 243 / 255)
  static let niceBlue = Color(red: 161 / 255, green: 217 / 255, blue: 241 / 255)
  static let grayCircle = Color(red: 157 / 255, green: 157 / 255, blue: 157 / 255)
  static let darkGray = Color(red: 70 / 255, green: 70 / 255, blue: 70 / 255)
  static let lightGray = Color(red: 206 / 255, green: 206 / 255, blue: 206 / 255)
  static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
  static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
  static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
  static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
  static let darkPurple = Color(red: 130 / 255, green: 0 / 255, blue: 174 / 255)
  static let lightPurple = Color(red: 172 / 255, green: 85 / 255, blue: 201 / 255)
  static let mixedBlue = Color(red: 43 / 255, green: 89 / 255, blue: 254 / 255)
  static let mixedPurple = Color(red: 223 / 255, green: 78 / 255, blue: 255 / 255)
  static let offWhite = Color(red: 228 / 255, green: 232 / 255, blue: 240 / 255)
  static let lightOffWhite = Color(red: 240 / 255, green: 245 / 255, blue: 251 / 255)
  
  static let offWhite01 = Color(red: 243 / 255, green: 245 / 255, blue: 248 / 255)
  static let offWhite015 = Color(red: 237 / 255, green: 240 / 255, blue: 244 / 255)
  static let offWhite02 = Color(red: 231 / 255, green: 234 / 255, blue: 240 / 255)
  static let offGray00 = Color(red: 185 / 255, green: 195 / 255, blue: 211 / 255)
  static let offGray01 = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
  static let offGray02 = Color(red: 136 / 255, green: 148 / 255, blue: 165 / 255)
  static let offGray03 = Color(red: 109 / 255, green: 119 / 255, blue: 132 / 255)
  static let offblack01 = Color(red: 82 / 255, green: 89 / 255, blue: 99 / 255)
  static let offblack02 = Color(red: 66 / 255, green: 71 / 255, blue: 79 / 255)
  static let offblack03 = Color(red: 55 / 255, green: 59 / 255, blue: 66 / 255)
  static let offblack04 = Color(red: 39 / 255, green: 41 / 255, blue: 47 / 255)
  static let signInGray = Color(red: 211 / 255, green: 211 / 255, blue: 211 / 255)
}
extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    let newRed = CGFloat(red)/255
    let newGreen = CGFloat(green)/255
    let newBlue = CGFloat(blue)/255
    
    self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
  }
  
  static let offWhite = UIColor(red: 228, green: 232, blue: 240)
  static let lightOffWhite = UIColor(red: 240, green: 245, blue: 251)
  static let darkPurple = UIColor(red: 38, green: 0, blue: 50)
  
  static let offWhite01 = UIColor(red: 243, green: 245, blue: 248)
  static let offWhite015 = UIColor(red: 237, green: 240, blue: 244)
  static let offWhite02 = UIColor(red: 231, green: 234, blue: 240)
  static let offGray00 = UIColor(red: 185, green: 195, blue: 211)
  static let offGray01 = UIColor(red: 163, green: 177, blue: 198)
  static let offGray02 = UIColor(red: 136, green: 148, blue: 165)
  static let offblack01 = UIColor(red: 82, green: 89, blue: 99)
  static let offblack02 = UIColor(red: 66, green: 71, blue: 79)
  static let offblack03 = UIColor(red: 55, green: 59, blue: 66)
}


struct CircleStyleEmoji: ButtonStyle {
  var player: Int = 5
  var selectedPlayer: Int = 6
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    LinearGradient(gradient: Gradient(colors: player == selectedPlayer ? [.mixedBlue, .mixedPurple] : [.offGray00, .offGray00]), startPoint: .topLeading, endPoint: .bottomTrailing)
      .frame(width: 125, height: 125, alignment: .center)
      .mask(Circle()
              .strokeBorder(player == selectedPlayer ? Color.purple : Color.offGray00, lineWidth: 6.5)
              .opacity(configuration.isPressed ? 0.3 : 1)
              .aspectRatio(contentMode: .fit)

      )
      .overlay(
        configuration.label
          .transition(.scale(scale: 5))
          .opacity(configuration.isPressed ? 0.2 : 1)
      )
      .frame(width: 160, height: 125, alignment: .center)
  }
}

struct SquareStyle: ButtonStyle {
  var player: Int = 5
  var selectedPlayer: Int = 6
  
  func makeBody(configuration: Self.Configuration) -> some View {
    LinearGradient(gradient: Gradient(colors: player == selectedPlayer ? [.mixedBlue, .mixedPurple] : [.offGray00, .offGray00]), startPoint: .topLeading, endPoint: .bottomTrailing)
      .frame(width: 160, height: 80, alignment: .center)
      .mask(RoundedRectangle(cornerRadius: 15)
              .stroke(player == selectedPlayer ? Color.purple : Color.offGray00, lineWidth: 8)
              .frame(width: 150, height: 60, alignment: .center)
              .cornerRadius(13)
              .opacity(configuration.isPressed ? 0.2 : 1)
              .aspectRatio(contentMode: .fit)
      )
      .overlay(
        configuration.label
          .transition(.scale(scale: 5))
          .opacity(configuration.isPressed ? 0.3 : 1)
          .foregroundColor(.offblack04)
      )
      .frame(width: 135, height: 60, alignment: .center)
  }
}

struct DeleteToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    return HStack {
      //  configuration.label
      Spacer()
      Image(systemName: configuration.isOn ? "minus.circle.fill" : "minus.circle")
        .resizable()
        .frame(width: 21, height: 21)
        .onTapGesture { configuration.isOn.toggle() }
    }
  }
}

struct EditToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    return HStack {
      //  configuration.label
      Image(systemName: configuration.isOn ? "multiply.circle" : "square.and.pencil")
        .font(Font.system(size: configuration.isOn ? 25 : 30))
        .foregroundColor(configuration.isOn ? Color.offGray02 : Color.darkPurple)
        .onTapGesture { configuration.isOn.toggle() }
    }.padding(.leading, 15)
  }
}

struct EmojiToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    return HStack {
      //  configuration.label
      Image(systemName: configuration.isOn ? "a.circle" : "smiley" )
        .font(Font.system(size: 20, weight: .regular))
        .onTapGesture { configuration.isOn.toggle() }
    }
  }
}

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

func endEditing() {
  UIApplication.shared.endEditing()
}

struct MultiTextField: UIViewRepresentable {
  
  @Binding var text: String
  @EnvironmentObject var obj : observed
  var onDone: (() -> Void)?
  
  func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
    let view = UITextView()
    view.delegate = context.coordinator
    view.isEditable = true
    view.isSelectable = true
    view.isUserInteractionEnabled = true
    view.isScrollEnabled = true
    view.backgroundColor = .clear
    
    view.font = .systemFont(ofSize: 17)
    view.text = "Type the bet here"
    view.textColor = UIColor.offblack03.withAlphaComponent(0.35)
    
    self.obj.size = view.contentSize.height
    
    if nil != onDone {
      view.returnKeyType = .done
    }
    
    view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    
    return view
  }
  func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
    if uiView.text != self.text {
      uiView.text = self.text
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return MultiTextField.Coordinator(text: $text, parent1: self, onDone: onDone)
  }
  
  
  class Coordinator : NSObject,UITextViewDelegate{
    var text: Binding<String>
    var parent : MultiTextField
    var onDone: (() -> Void)?
    
    init(text: Binding<String>, parent1 : MultiTextField, onDone: (() -> Void)? = nil) {
      self.text = text
      parent = parent1
      self.onDone = onDone
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      
      textView.textColor = .offblack03
    }
    func textViewDidChange(_ textView: UITextView) {
      text.wrappedValue = textView.text
      self.parent.obj.size = textView.contentSize.height
    }
  }
}

class observed : ObservableObject {
  @Published var size : CGFloat = 0
}

struct MultiTextField1: View {
  
  private var placeholder: String
  private var onCommit: (() -> Void)?
  @State private var viewHeight: CGFloat = 25 //start with one line
  @State private var shouldShowPlaceholder = false
  @Binding private var text: String
  @EnvironmentObject var obj : observed
  
  private var internalText: Binding<String> {
    Binding<String>(get: { self.text } ) {
      self.text = $0
      self.shouldShowPlaceholder = $0.isEmpty
    }
  }
  
  var body: some View {
    VStack() {
      RoundedRectangle(cornerRadius: 15)
        .stroke(Color.offWhite02, lineWidth: 5)
        .shadow(color: Color.offGray01.opacity(1), radius: 4, x: 5, y: 5)
        .frame(width: 290, height: self.obj.size < 100 ? self.obj.size + 15  : 120)
        .clipShape(
          RoundedRectangle(cornerRadius: 18)
        )
        .shadow(color: Color.white, radius: 4, x: -3.3, y: -3.3)
        .frame(width: 290, height: self.obj.size < 100 ? self.obj.size + 15 : 120)
        .clipShape(
          RoundedRectangle(cornerRadius: 18)
        )
        .background(Color.offWhite02)
        .cornerRadius(15)
        .frame(width: 290, height: self.obj.size < 100 ? self.obj.size + 15 : 120)
        
        .overlay(
          MultiTextField(text: self.internalText, onDone: onCommit)
            .frame(width: 265, height: self.obj.size < 100 ? self.obj.size : 100)
            .padding(10)
            .cornerRadius(15)
            .background(placeholderView, alignment: .leading)
        )
    }.padding()
  }
  
  var placeholderView: some View {
    Group {
      if shouldShowPlaceholder {
        Text(placeholder).foregroundColor(.gray)
          .padding(.leading, 10)
          .font(Font.system(size: 17))
      }
    }
  }
  
  init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
    self.placeholder = placeholder
    self.onCommit = onCommit
    self._text = text
    self._shouldShowPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
  }
  
}

struct MultiTextField2: View {
  
  private var placeholder: String
  private var onCommit: (() -> Void)?
  @State private var viewHeight: CGFloat = 25 //start with one line
  @State private var shouldShowPlaceholder = false
  @Binding private var text: String
  
  private var internalText: Binding<String> {
    Binding<String>(get: { self.text } ) {
      self.text = $0
      self.shouldShowPlaceholder = $0.isEmpty
    }
  }
  
  var body: some View {
    VStack() {
      RoundedRectangle(cornerRadius: 18)
        .stroke(Color.offWhite02, lineWidth: 5)
        .shadow(color: Color.offGray01.opacity(1), radius: 4, x: 5, y: 5)
        .frame(width: 300, height: 140)
        .clipShape(
          RoundedRectangle(cornerRadius: 18)
        )
        .shadow(color: Color.white, radius: 4, x: -3.3, y: -3.3)
        .frame(width: 300, height: 130)
        .clipShape(
          RoundedRectangle(cornerRadius: 18)
        )
        .background(Color.offWhite02)
        .cornerRadius(15)
        .frame(width: 300, height: 130)
        
        .overlay(
          MultiTextField(text: self.internalText, onDone: onCommit)
            .frame(width: 280, height: 110)
            .padding(10)
            .cornerRadius(15)
        )
    }.padding()
  }
  
  var placeholderView: some View {
    Group {
      if shouldShowPlaceholder {
        Text(placeholder).foregroundColor(.gray)
          .padding(.leading, 10)
          .font(Font.system(size: 17))
      }
    }
  }
  
  init (_ placeholder: String = "Enter bet here:", text: Binding<String>, onCommit: (() -> Void)? = nil) {
    self.placeholder = placeholder
    self.onCommit = onCommit
    self._text = text
    self._shouldShowPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
  }
  
}
