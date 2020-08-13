//
//  TestView.swift
//  Score1031
//
//  Created by Danting Li on 8/11/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI
import RAMPaperSwitch
import UIKit

struct SplashView: View {
    
    var animationType: SplashShape.SplashAnimation
    @State private var prevColor: Color // Stores background color
    @ObservedObject var colorStore: ColorStore // Send new color updates
    @State var layers: [(Color,CGFloat)] = []
    
    init(animationType: SplashShape.SplashAnimation, color: Color) {
        self.animationType = animationType
        self._prevColor = State<Color>(initialValue: color)
        self.colorStore = ColorStore(color: color)
    }

    var body: some View {
        Rectangle()
            .foregroundColor(self.prevColor)
            .overlay(
                ZStack {
                    ForEach(layers.indices, id: \.self) { x in
                        SplashShape(progress: self.layers[x].1, animationType: self.animationType)
                            .foregroundColor(self.layers[x].0)
                    }

                }

                , alignment: .leading)
            .onReceive(self.colorStore.$color) { color in
                // Animate color update here
                self.layers.append((color, 0))

                withAnimation(.easeInOut(duration: 0.5)) {
                    self.layers[self.layers.count-1].1 = 1.0
                }
            }
    }


}

class ColorStore: ObservableObject {
    @Published var color: Color
    
    init(color: Color) {
        self.color = color
    }
}
