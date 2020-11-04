//
//  WholeView.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/23.
//

import SwiftUI

struct WholeView: View {
    @ObservedObject var sessionTimer: SessionTimer
    
    var runningTime: Int
    var restingTime: Int
    
    
    init(runningtime: Int, restingtime: Int) {
        self.runningTime = runningtime
        self.restingTime = restingtime
        
        self.sessionTimer = SessionTimer(worktime: runningTime, resttime: restingTime)
        self.sessionTimer.startSession()
    }
    
    
    
    var body: some View {
        ZStack {
            if self.sessionTimer.isWork {
                self.sessionTimer.FaceResult
            } else {
                Text("\(sessionTimer.FaceResult.returnStudyData().last!.focusScore)")
            }
            VStack {
                Text(self.sessionTimer.printTime())
                Spacer()
                Button(action: {
                    self.sessionTimer.endSession()
                    
                }) {
                    if self.sessionTimer.isWork {
                        Text("Stop")
                    } else {
                        Text("Start")
                    }
                    
                }
                
            }
        }
        
        
        
    }
    
}

struct WholeView_Previews: PreviewProvider {
    static var previews: some View {
        WholeView(runningtime: 1500, restingtime: 300)
    }
}
