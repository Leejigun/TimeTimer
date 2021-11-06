//
//  TimerFaceView.swift
//  TimeTimer
//
//  Created by bimo.ez on 2021/11/07.
//

import SwiftUI

struct TimerFaceView: View {
    
    @Binding var to: CGFloat
    @Binding var count: Int
    @Binding var maxCount: Int
    
    var body: some View {
        GeometryReader { geometryProxy in
            VStack {
                // 타이머 화면
                ZStack {
                    Group {
                        Circle()
                            .trim(from: 0, to: 1)
                            .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap:  .round))
                        
                        Circle()
                            .trim(from: 0, to: self.to)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap:  .round))
                    }
                    .padding(.all, 20)
                    .rotationEffect(Angle(degrees: 270))
                    
                    VStack {
                        Text("\(self.count)")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                        
                        Text("of \(self.maxCount)")
                            .font(.title)
                    }
                }
            }
        }
    }
}
