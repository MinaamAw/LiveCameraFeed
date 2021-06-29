//
//  ViewController.swift
//  RealTimeDetection
//
//  Created by Minaam Ahmed Awan on 29/06/2021.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // Start a Capture Session:
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addCameraInput()
        self.addPreviewLayer()
        self.captureSession.startRunning()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.view.bounds
    }
        
    
    // Capture Input:
    private func addCameraInput() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        self.captureSession.addInput(deviceInput)
    }
    
    
    // Display Preview On Screen:
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(session: self.captureSession)
        
        return preview
    }()
    
    
    // Add Preview to ViewController:
    private func addPreviewLayer() {
        self.view.layer.addSublayer(self.previewLayer)
    }
    
    
    //
    private func addVideoOutput() {
        self.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        self.captureSession.addOutput(self.videoOutput)
    }
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        print("Frame Received", Date())
    }
    
}
