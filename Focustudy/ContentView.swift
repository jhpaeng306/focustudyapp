//
//  ContentView.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var workSession: WorkSession = WorkSession()
    
    
    

    var body: some View {
        VStack {
            FaceControllerRepresentable()
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
