//
//  ContentView.swift
//  SwiftUIAnimationsMastery
//
//  Created by steven on 25.11.21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animateSize = false
    @State private var animateColor = false
    
    @State private var change1 = true
    @State private var change2 = true
    @State private var change3 = true
    @State private var change4 = true
    
    @State private var duration: Double = 2.0
    
    var body: some View {
        VStack() {
            VStack(spacing: 10) {
                AnimationView(animation: Animation.easeIn(duration: duration),
                              name: "easeIn",
                              change: change1,
                              animateSize: animateSize,
                              animateColor: animateColor)
                AnimationView(animation: Animation.easeInOut(duration: duration),
                              name: "easeInOut",
                              change: change2,
                              animateSize: animateSize,
                              animateColor: animateColor)
                AnimationView(animation: Animation.easeOut(duration: duration),
                              name: "easeOut",
                              change: change3,
                              animateSize: animateSize,
                              animateColor: animateColor)
                AnimationView(animation: Animation.linear(duration: duration),
                              name: "linear",
                              change: change4,
                              animateSize: animateSize,
                              animateColor: animateColor)
            }.padding(10)
            Button {
                change1.toggle()
                change2.toggle()
                change3.toggle()
                change4.toggle()
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(maxWidth: 30, maxHeight: 30)
            }.tint(.mint)
            .padding()
            
            HStack {
                Toggle(isOn: $animateSize) {
                    Text("Animate size")
                }.toggleStyle(.switch)
                    .tint(.mint)
                Spacer(minLength: 50)
                Toggle(isOn: $animateColor) {
                    Text("Animate color")
                }.toggleStyle(.switch)
                    .tint(.mint)
            }.padding()
            
            Slider(value: $duration, in: 0.5 ... 3)
                .tint(.mint)
                .padding()
            Text("Duration: \(duration)")
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AnimationView: View {
    let animation: Animation
    let name: String
    var change: Bool
    let animateSize: Bool
    let animateColor: Bool
    
    private static let circleWidth = CGFloat(50)
    private static let pad = CGFloat(10)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Circle()
                        .frame(maxWidth: size.width,
                               maxHeight: size.height)
                        .foregroundColor(color)
                        .offset(x: change ? 0 :
                                    geometry.size.width -
                                    AnimationView.circleWidth -
                                    2*AnimationView.pad)
                        .animation(animation, value: change)
                        .padding(AnimationView.pad)
                    Spacer()
                }
                // to avoid shrinking of HStack because of animation
                // of circle size
                .frame(maxWidth: geometry.size.width,
                       maxHeight: geometry.size.height)
                Text(name)
                    .font(.headline)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.mint)
            .cornerRadius(10)
        }
    }
    
    var size: (width: CGFloat, height: CGFloat) {
        get {
            if animateSize {
                let radius = change ? 10 : AnimationView.circleWidth
                return (radius, radius)
            }
            return (AnimationView.circleWidth, AnimationView.circleWidth)
        }
    }
    
    var color: Color {
        get {
            if animateColor {
                return change ? .yellow : .red
            }
            return .yellow
        }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView(animation: .easeIn,
                      name: "easeIn",
                      change: true,
                      animateSize: true,
                      animateColor: true)
    }
}
