//
//  ContentView.swift
//  TimeTimer
//
//  Created by bimo.ez on 2021/11/06.
//

import SwiftUI
import NotificationCenter

struct ContentView: View {
    
    @State var start = false
    @State var to: CGFloat = 0
    @State var count: Int = 0
    @State var maxCount: Int = 15
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            TimerFaceView(to: $to, count: $count, maxCount: $maxCount)
                .frame(width: 280, height: 280)
            
            // 하단 버튼 그룹
            GeometryReader { geometryProxy in
                // 하단 버튼들
                HStack(spacing: 20) {
                    Button {
                        self.start.toggle()
                    } label: {
                        HStack {
                            Image(systemName: self.start ? "pause.fill" : "play.fill")
                            Text(self.start ? "Pause" : "Play")
                        }
                        .frame(width: geometryProxy.size.width / 2 - 10)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                    }
                    
                    Button {
                        self.count = 0
                    } label: {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Restart")
                        }
                        .frame(width: geometryProxy.size.width / 2 - 10)
                        .foregroundColor(Color.red)
                        .padding(.vertical)
                        .background(
                            Capsule()
                                .stroke(Color.red, lineWidth: 2)
                        )
                        .shadow(radius: 6)
                    }
                }
                .frame(width: geometryProxy.size.width)
            }
        }
        .onReceive(timer) { _ in
            if self.start {
                if count < maxCount {
                    count += 1
                    withAnimation(.easeIn(duration: 1)) {
                        self.to = min(CGFloat(self.count) / CGFloat(self.maxCount), 1)
                    }
                } else {
                    self.start.toggle()
                    notify()
                    withAnimation(.easeIn(duration: 1)) {
                        self.to = 0
                    }
                }
            }
        }
        .onAppear {
            requestNotiAuth()
        }
    }
}

extension ContentView {
    func requestNotiAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { _, _ in }
    }
    
    func notify() {
        let content = UNMutableNotificationContent()
        content.title = "Time Timer"
        content.body = "Timer Is Completed Successfully In Background!"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "TimeTimer", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
