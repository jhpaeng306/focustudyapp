//
//  StartSessionView.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/10/14.
//

import SwiftUI

struct StartSessionView: View {
    
    @State var runningTime: Int
    @State var SetNum: Int = 0
    
    var restingTime: Int
    
    let timeInterval = ["15", "16", "17","18", "19", "20","21", "22", "23","24", "25", "26","27","28", "29", "30"]
    let Interval = ["0", "1", "2", "3","4", "5", "6","7", "8", "9","10", "11", "12","13","14", "15", "16"]
    
    @State private var runningTimeIndex: Int
    @State private var IntervalIndex: Int = 1
    
    @State private var pickerVisible: Bool = false
    @State private var intervalpickerVisible: Bool = false
    
    @State var isStarted: Int = 0
    
    init(RunningTime: Int, RestingTime: Int) {
        _runningTime = State(initialValue: RunningTime)
        self.restingTime = RestingTime
        _runningTimeIndex = State(initialValue: RunningTime / 60 - 15)
    }
    
    var body: some View {
        VStack {
            if isStarted == 0 {
                if pickerVisible {
                    Picker(selection: $runningTimeIndex, label: Text("Running time")) {
                        ForEach(0 ..< timeInterval.count) {
                            Text(self.timeInterval[$0])
                        }
                    }.onTapGesture {
                        self.pickerVisible.toggle()
                        self.runningTime = 60*(Int(runningTimeIndex) + 15)
                    }
                }
                else if intervalpickerVisible {
                    Picker(selection: $IntervalIndex, label: Text("Interval number")) {
                        ForEach(0 ..< Interval.count) {
                            Text(self.Interval[$0])
                        }
                    }.onTapGesture {
                        self.intervalpickerVisible.toggle()
                    }
                }
                else {
                    VStack {
                        Button(action: {
                            self.pickerVisible.toggle()
                        }) {
                            Text("\(self.runningTime/60)")
                        }
                        Button(action: {
                            self.intervalpickerVisible.toggle()
                        }) {
                            Text("\(self.IntervalIndex)")
                        }
                        Button(action: {
                            self.isStarted = 1
                        }) {
                            Text("Start")
                        }
                    }
                }
                
            }
            else if isStarted == 1 {
                ZStack {
                    WholeView(runningtime: self.runningTime, restingtime: self.restingTime)
                    Button(action: {
                        self.isStarted = 2
                    }) {
                        Text("End")
                    }
                }
                
            }
            else {
                Button(action: {
                    self.isStarted = 0
                }) {
                    Text("Restart")
                }
            }
        }.padding()
    }
}



struct StartSessionView_Previews: PreviewProvider {
    static var previews: some View {
        StartSessionView(RunningTime: 1620, RestingTime: 300)
    }
}
