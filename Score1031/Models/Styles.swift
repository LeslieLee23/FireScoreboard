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

struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?
    @State private var viewHeight: CGFloat = 40 //start with one line
    @State private var shouldShowPlaceholder = false
    @Binding private var text: String
    
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.shouldShowPlaceholder = $0.isEmpty
        }
    }

    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $viewHeight, onDone: onCommit)
            .frame(minHeight: viewHeight, maxHeight: viewHeight)
            .background(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View {
        Group {
            if shouldShowPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
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


private struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
//        if uiView.window != nil, !uiView.isFirstResponder {
//            uiView.becomeFirstResponder()
//        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    private static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // call in next render cycle.
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
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
