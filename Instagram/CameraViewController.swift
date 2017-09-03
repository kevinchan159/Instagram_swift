//
//  CameraViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/3/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var captureDevice: AVCaptureDevice?
    var cameraView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPreset1920x1080
        
        var camera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var input = AVCaptureDeviceInput()
        
        do {
         input = try(AVCaptureDeviceInput(device: camera))
        } catch {
            return
        }
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
            
            let stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
                
                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                cameraView.layer.addSublayer(previewLayer!)
                captureSession.startRunning()
            }
        }
    }
    
}

