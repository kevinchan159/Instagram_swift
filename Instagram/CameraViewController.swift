//
//  CameraViewController.swift
//  Instagram
//
//  Created by Kevin Chan on 9/3/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var captureSession: AVCaptureSession!
    var captureDevice: AVCaptureDevice?
    var cameraView: UIView!
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Camera"
        cameraView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(cameraView)
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPreset1920x1080
        
        var camera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var input = AVCaptureDeviceInput()
        
        do {
            input = try(AVCaptureDeviceInput(device: camera))
        } catch {
            print("error")
            return
        }
        
        if captureSession.canAddInput(input) {
            captureSession?.addInput(input)
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                cameraView.layer.addSublayer(previewLayer!)
                captureSession.startRunning()
            }
        }
        
        previewLayer?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)


        
    }
    

    
}

