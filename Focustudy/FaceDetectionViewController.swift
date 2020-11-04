//
//  FaceDetectionViewController.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/24.
//

import AVFoundation
import UIKit
import Vision
import SwiftUI

class FaceDetectionViewController: UIViewController, ObservableObject {
  var sequenceHandler = VNSequenceRequestHandler()

  var faceView: FaceView = FaceView()
    
  
  var totalTime: Int = 0
  var focusTime: Int = 0
  
  let session = AVCaptureSession()
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  let dataOutputQueue = DispatchQueue(
    label: "video data queue",
    qos: .userInitiated,
    attributes: [],
    autoreleaseFrequency: .workItem)
  
  var maxX: CGFloat = 0.0
  var midY: CGFloat = 0.0
  var maxY: CGFloat = 0.0
    
    var StudyArray: [StudyDataStruct] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    configureCaptureSession()
    
    
    maxX = view.bounds.maxX
    midY = view.bounds.midY
    maxY = view.bounds.maxY
    
    
    view.addSubview(faceView)
    session.startRunning()
  }
  
}



// MARK: - Video Processing methods

extension FaceDetectionViewController {
  func configureCaptureSession() {
    // Define the capture device we want to use
    guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                               for: .video,
                                               position: .front) else {
      fatalError("No front video camera available")
    }
    
    // Connect the camera to the capture session input
    do {
      let cameraInput = try AVCaptureDeviceInput(device: camera)
      session.addInput(cameraInput)
    } catch {
      fatalError(error.localizedDescription)
    }
    
    // Create the video data output
    let videoOutput = AVCaptureVideoDataOutput()
    videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
    videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
    
    // Add the video output to the capture session
    session.addOutput(videoOutput)
    
    let videoConnection = videoOutput.connection(with: .video)
    videoConnection?.videoOrientation = .portrait
    
    // Configure the preview layer
    previewLayer = AVCaptureVideoPreviewLayer(session: session)
    previewLayer.videoGravity = .resizeAspectFill
    previewLayer.frame = view.bounds
    view.layer.insertSublayer(previewLayer, at: 0)
  }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate methods

extension FaceDetectionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // 1
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }

    // 2
    let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)

    // 3
    do {
      try sequenceHandler.perform(
        [detectFaceRequest],
        on: imageBuffer,
        orientation: .leftMirrored)
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension FaceDetectionViewController {
  func convert(rect: CGRect) -> CGRect {
    // 1
    let origin = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.origin)

    // 2
    let size = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.size.cgPoint)

    // 3
    return CGRect(origin: origin, size: size.cgSize)
  }

  // 1
  func landmark(point: CGPoint, to rect: CGRect) -> CGPoint {
    // 2
    let absolute = point.absolutePoint(in: rect)

    // 3
    let converted = previewLayer.layerPointConverted(fromCaptureDevicePoint: absolute)

    // 4
    return converted
  }

  func landmark(points: [CGPoint]?, to rect: CGRect) -> [CGPoint]? {
    guard let points = points else {
      return nil
    }

    return points.compactMap { landmark(point: $0, to: rect) }
  }
  
  func updateFaceView(for result: VNFaceObservation) {
    defer {
      DispatchQueue.main.async {
        self.faceView.setNeedsDisplay()
      }
    }
    

    let box = result.boundingBox
    faceView.boundingBox = convert(rect: box)

    guard let landmarks = result.landmarks else {
      return
    }

    if let leftEye = landmark(
      points: landmarks.leftEye?.normalizedPoints,
      to: result.boundingBox) {
      faceView.leftEye = leftEye
    }

    if let rightEye = landmark(
      points: landmarks.rightEye?.normalizedPoints,
      to: result.boundingBox) {
      faceView.rightEye = rightEye
    }

    if let leftEyebrow = landmark(
      points: landmarks.leftEyebrow?.normalizedPoints,
      to: result.boundingBox) {
      faceView.leftEyebrow = leftEyebrow
    }

    if let rightEyebrow = landmark(
      points: landmarks.rightEyebrow?.normalizedPoints,
      to: result.boundingBox) {
      faceView.rightEyebrow = rightEyebrow
    }

    if let nose = landmark(
      points: landmarks.nose?.normalizedPoints,
      to: result.boundingBox) {
      faceView.nose = nose
    }

    if let outerLips = landmark(
      points: landmarks.outerLips?.normalizedPoints,
      to: result.boundingBox) {
      faceView.outerLips = outerLips
    }

    if let innerLips = landmark(
      points: landmarks.innerLips?.normalizedPoints,
      to: result.boundingBox) {
      faceView.innerLips = innerLips
    }

    if let faceContour = landmark(
      points: landmarks.faceContour?.normalizedPoints,
      to: result.boundingBox) {
      faceView.faceContour = faceContour
    }
  }

  func detectedFace(request: VNRequest, error: Error?) {
    // 1
    totalTime += 1
    focusTime += 1
    //print("\(Double(focusTime) / Double(totalTime)))")
    
    guard
      let results = request.results as? [VNFaceObservation],
      let result = results.first
      else {
        // 2
        
        focusTime -= 1
        faceView.clear()
        return
    }

    updateFaceView(for: result)
    
  }
    
    func endSession() {
        print("\(Float(focusTime) / Float(totalTime))")
        
        StudyArray.append(StudyDataStruct(TotalTime: totalTime, FocusTime: focusTime))
        
        
    }
    func startSession() {
        focusTime = 0
        totalTime = 0
    }
    
    
    func StudydataArray() -> [StudyDataStruct] {
        return self.StudyArray
    }
    
    
}


