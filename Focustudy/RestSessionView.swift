//
//  RestSessionView.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/23.
//

import SwiftUI

struct RestSessionView: View {
    @ObservedObject var restSession: RestSession = RestSession()
    
    
    init() {

    }
    
    var body: some View {
        VStack {
            Text("rest")
        }
    }
}

struct RestSessionView_Previews: PreviewProvider {
    static var previews: some View {
        RestSessionView()
    }
}
