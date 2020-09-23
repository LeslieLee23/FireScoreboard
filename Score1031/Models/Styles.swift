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
//  static let offWhite = Color(red: 223 / 255, green: 228 / 255, blue: 235 / 255)
  static let darkGray = Color(red: 70 / 255, green: 70 / 255, blue: 70 / 255)
  static let lightGray = Color(red: 206 / 255, green: 206 / 255, blue: 206 / 255)
  static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
  static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
  static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
  static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
  static let darkPurple = Color(red: 130 / 255, green: 0 / 255, blue: 174 / 255)

  static let offWhite = Color(red: 228 / 255, green: 232 / 255, blue: 240 / 255)
  static let lightOffWhite = Color(red: 240 / 255, green: 245 / 255, blue: 251 / 255)
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
  var player: Int = 5
  var selectedPlayer: Int = 6
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    
    Circle()
      .strokeBorder(player == selectedPlayer ? Color.purple : Color.grayCircle, lineWidth: 6.5)
      
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
 // var color: Color = .green
  var player: Int = 5
  var selectedPlayer: Int = 6
  
  func makeBody(configuration: Self.Configuration) -> some View {
    RoundedRectangle(cornerRadius: 13)
      .stroke(player == selectedPlayer ? Color.purple : Color.grayCircle, lineWidth: 7.5)
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
            Image(systemName: configuration.isOn ? "multiply.circle" : "pencil.circle")
              .font(Font.system(size: configuration.isOn ? 25 : 32))
              .foregroundColor(configuration.isOn ? .black : Color.darkPurple)
                .onTapGesture { configuration.isOn.toggle() }
        }
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
    view.textColor = UIColor.black.withAlphaComponent(0.35)

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
   //   textView.text = ""textView.text
      
      textView.textColor = .black
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
           .stroke(Color.offWhite, lineWidth: 5)
           .shadow(color: Color.black.opacity(0.2), radius: 4, x: 5, y: 5)
           .frame(width: 290, height: self.obj.size < 100 ? self.obj.size + 15  : 120)
           .clipShape(
             RoundedRectangle(cornerRadius: 15)
         )
           .shadow(color: Color.white, radius: 4, x: -3, y: -3)
           .frame(width: 290, height: self.obj.size < 100 ? self.obj.size + 15 : 120)
           .clipShape(
             RoundedRectangle(cornerRadius: 15)
         )
           .background(Color.offWhite)
           .cornerRadius(18)
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
          .stroke(Color.offWhite, lineWidth: 5)
          .shadow(color: Color.black.opacity(0.2), radius: 4, x: 5, y: 5)
          .frame(width: 300, height: 140)
          .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
          .shadow(color: Color.white, radius: 4, x: -3, y: -3)
          .frame(width: 300, height: 130)
          .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
          .background(Color.offWhite)
          .cornerRadius(18)
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
