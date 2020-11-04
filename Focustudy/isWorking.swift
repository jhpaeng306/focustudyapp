//
//  isWorking.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/23.
//

import Foundation

class isWorking: ObservableObject {
    @Published var isWork: Bool
    
    init() {
        self.isWork = true
    }
    
    func changetoFalse() {
        self.isWork = false
    }
    
    func changetoTrue() {
        self.isWork = true
    }
}
