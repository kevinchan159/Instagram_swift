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
    
    var photoImageView: UIImageView!
    
    var feedViewController: FeedViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Camera"
        cameraView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(cameraView)
        
        photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImageView)
        photoImageView.isHidden = true
        
        photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPreset1920x1080
        
        var camera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var input: AVCaptureDeviceInput
        
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
    
    func takePhoto() {
        if let connection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo) {
            connection.videoOrientation = AVCaptureVideoOrientation.portrait
            stillImageOutput?.captureStillImageAsynchronously(from: connection, completionHandler: { (sampleBuffer, err) in
                if (err != nil) {
                    print(err)
                    return
                }
                
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let dataProvider = CGDataProvider(data: imageData as! CFData)
                let cgImage = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                let image = UIImage(cgImage: cgImage!, scale: 1.0, orientation: UIImageOrientation.right)
                
                self.photoImageView.image = image
                self.photoImageView.isHidden = false
                
                self.feedViewController.photoArray.insert(image, at: 0)
                let indexPath = IndexPath(item: 0, section: 0)
                self.feedViewController.photoCollectionView.insertItems(at: [indexPath])
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: { 
                    self.photoImageView.isHidden = true
                })
                
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        takePhoto()
    }
    
    
}

