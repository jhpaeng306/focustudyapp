//
//  StudyDataStruct.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/10/03.
//

import Foundation

struct StudyDataStruct: Codable {
    //var startDate: Int
    //var startTime: Int
    //var timeInterval: Int
    
    
    
    var totalTime: Int
    var focusTime: Int
    var focusScore: Float
    
    init(TotalTime: Int, FocusTime: Int) {
        totalTime = TotalTime
        focusTime = FocusTime
        focusScore = (Float(FocusTime) / Float(TotalTime))
    }
    
}

