//
//  WorkSessionView.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/23.
//

import SwiftUI

struct WorkSessionView: View {
    
    @ObservedObject var workSession: WorkSession = WorkSession()
    
    
    init() {
        
    }
    
    var body: some View {
        VStack {
            Text("work")
        }
    }
}

struct WorkSessionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkSessionView()
    }
}
