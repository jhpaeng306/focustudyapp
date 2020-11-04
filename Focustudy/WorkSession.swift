//
//  WorkSession.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/23.
//

import Foundation


class WorkSession: ObservableObject {
    
    @Published var totalTime: Int
    @Published var focusTime: Int
    
    
    var focusScore: Float64 {
        return Float64(focusTime/totalTime)
    }
    
    
    
    init() {
        totalTime = 0
        focusTime = 0
    }
    
    func isFocused(isfocused: Bool) {
        totalTime += 1
        if isfocused {
            focusTime += 1
        }
    }
    
    func endWorkSession() {
        //
    }
    
    
}
