//
//  SessionTimer.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/24.
//

import Foundation

class SessionTimer: ObservableObject {
    var runningTime: Int

    var workTime: Int
    var restTime: Int
    
    
    var minute: Int {
        return runningTime / 60
    }
    
    var second: Int {
        return runningTime % 60
    }

    @Published var timeLable: String
    
    @Published var isWork: Bool
    
    @Published var FaceResult: FaceControllerRepresentable
    
    init(worktime: Int, resttime: Int) {
        workTime = worktime
        restTime = resttime
        
        runningTime = worktime
        isWork = true
        
        FaceResult = FaceControllerRepresentable()
        
        timeLable = "\(runningTime / 60) : \(runningTime %  60)"
        
    }
    
    func setRunningTime(time: Int) {
        self.runningTime = time
    }
    
    var sessionTimer: Timer?
    
    func printTime() -> String {
        return timeLable
    }
    
    func startSession() {
        if self.isWork {
            self.FaceResult.startSession()
        }
        self.sessionTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    func endSession() {
        if self.isWork {
            self.FaceResult.endSession()
        }
        self.isWork = !self.isWork
        runningTime = self.isWork ? workTime : restTime
        if self.isWork {
            self.FaceResult.startSession()
        }
    }
    
    @objc func updateTimer() {
        self.timeLable = "\(self.minute) : \(self.second)"
        if self.runningTime != 0 {
            self.runningTime -= 1  // decrease counter timer
            
        } else {
            endSession()
        }
    }
}
