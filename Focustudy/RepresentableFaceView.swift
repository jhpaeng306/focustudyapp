//
//  FaceViewRep.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/24.
//
import UIKit
import SwiftUI

struct RepresentableFaceView: UIViewRepresentable {
    var FaceCon: FaceDetectionViewController = FaceDetectionViewController()
    
    var FaceRec: FaceView = FaceCon.faceView
 
    func makeUIView(context: Context) -> FaceView {
        FaceRec
    }
 
    func updateUIView(_ uiView: UILabel, context: Context) {
        FaceRec = FaceCon.faceView
    }
}
