//
//  FaceController.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/24.
//

import UIKit
import SwiftUI

// 1.
struct FaceController: UIViewControllerRepresentable {

    // 2.
    func makeUIViewController(context: Context) -> FaceDetectionViewController {
        return FaceDetectionViewController()
    }
    
    // 3.
    func updateUIViewController(_ uiViewController: FaceDetectionViewController, context: Context) {
        
    }
}
