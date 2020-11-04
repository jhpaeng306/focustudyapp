//
//  FaceRecView.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/24.
//

import SwiftUI

struct FaceRecView: View {
    @State private var isPresented = false
    
    var body: some View {
        FaceViewRep()
    }
}

struct FaceRecView_Previews: PreviewProvider {
    static var previews: some View {
        FaceRecView()
    }
}
