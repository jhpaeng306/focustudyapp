//
//  FaceControllerRepresentable.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/24.
//

import UIKit
import SwiftUI

struct FaceControllerRepresentable: UIViewControllerRepresentable {
    
    let FaceResult = FaceDetectionViewController()

    func makeUIViewController(context: Context) -> FaceDetectionViewController {
        
        return FaceResult
        
    }
    
    func updateUIViewController(_ FaceResult: FaceDetectionViewController, context: Context) {
        //print("\(Double(focusTime) / Double(totalTime)))")
        
    }
    
    func endSession() {
        FaceResult.endSession()
    }
    
    func startSession() {
        FaceResult.startSession()
    }
    
    func returnStudyData() -> [StudyDataStruct] {
        return FaceResult.StudydataArray()
    }
    
}

struct FaceControllerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
