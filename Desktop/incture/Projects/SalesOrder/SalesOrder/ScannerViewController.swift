//
//  ScannerViewController.swift
//  SalesOrder
//
//  Created by Arun Kumar on 17/05/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

//import UIKit
//import AVFoundation
//class CameraView: UIView {
//    override class var layerClass: AnyClass {
//        get {
//            return AVCaptureVideoPreviewLayer.self
//        }
//    }
//    override var layer: AVCaptureVideoPreviewLayer {
//        get {
//            return super.layer as! AVCaptureVideoPreviewLayer
//        }
//    }
//}
//class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//
//  var lblHeader = UILabel()
//
//    // Camera view
//    var cameraView: CameraView!
//    // AV capture session and dispatch queue
//    let session = AVCaptureSession()
//    let sessionQueue = DispatchQueue(label: AVCaptureSession.self.description(), attributes: [], target: nil)
//
//    override func loadView() {
//        cameraView = CameraView()
//        view = cameraView
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        lblHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 90)
//        lblHeader.backgroundColor = .red
//        self.view.addSubview(lblHeader)
//        session.beginConfiguration()
//        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
//        if (videoDevice != nil) {
//            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!)
//            if (videoDeviceInput != nil) {
//                if (session.canAddInput(videoDeviceInput!)) {
//                    session.addInput(videoDeviceInput!)
//                }
//            }
//            let metadataOutput = AVCaptureMetadataOutput()
//            if (session.canAddOutput(metadataOutput)) {
//                session.addOutput(metadataOutput)
//                metadataOutput.metadataObjectTypes = [
//                    AVMetadataObject.ObjectType.ean13,
//                    AVMetadataObject.ObjectType.qr
//                ]
//                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            }
//        }
//        session.commitConfiguration()
//        cameraView.layer.session = session
//        cameraView.layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        // Set initial camera orientation
//        let videoOrientation: AVCaptureVideoOrientation
//        switch UIApplication.shared.statusBarOrientation {
//        case .portrait:
//            videoOrientation = .portrait
//        case .portraitUpsideDown:
//            videoOrientation = .portraitUpsideDown
//        case .landscapeLeft:
//            videoOrientation = .landscapeLeft
//        case .landscapeRight:
//            videoOrientation = .landscapeRight
//        default:
//            videoOrientation = .portrait
//        }
//        cameraView.layer.connection?.videoOrientation = .portrait
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Start AV capture session
//        sessionQueue.async {
//            self.session.startRunning()
//        }
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Stop AV capture session
//        sessionQueue.async {
//            self.session.stopRunning()
//        }
//    }
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        // Update camera orientation
//        let videoOrientation: AVCaptureVideoOrientation
//        switch UIDevice.current.orientation {
//        case .portrait:
//            videoOrientation = .portrait
//        case .portraitUpsideDown:
//            videoOrientation = .portraitUpsideDown
//        case .landscapeLeft:
//            videoOrientation = .landscapeRight
//        case .landscapeRight:
//            videoOrientation = .landscapeLeft
//        default:
//            videoOrientation = .portrait
//        }
//        cameraView.layer.connection?.videoOrientation = .portrait
//    }
//    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
//        // Display barcode value
//        if (metadataObjects.count > 0 && metadataObjects.first is AVMetadataMachineReadableCodeObject) {
//            let scan = metadataObjects.first as! AVMetadataMachineReadableCodeObject
//
////            let alertController = UIAlertController(title: "Materialcode", message: scan.stringValue, preferredStyle: UIAlertControllerStyle.alert)
////            alertController.addTextField { (textField : UITextField!) -> Void in
////                textField.placeholder = "Materialcode"
////                alertController.addTextField { (textField : UITextField!) -> Void in
////                    textField.placeholder = "Qty"
////            }
////            let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { alert -> Void in
////                let firstTextField = alertController.textFields![0] as UITextField
////                let secondTextField = alertController.textFields![1] as UITextField
////                print(firstTextField)
////                print(secondTextField)
////
////            })
////            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
////                (action : UIAlertAction!) -> Void in })
////            alertController.addTextField { (textField : UITextField!) -> Void in
////                textField.placeholder = "Enter First Name"
////            }
////
////            alertController.addAction(saveAction)
////            alertController.addAction(cancelAction)
////
////            self.present(alertController, animated: true, completion: nil)
//
//            let alertController = UIAlertController(title: "Barcode Scanned", message: scan.stringValue, preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
//            present(alertController, animated: true, completion: nil)
//        }
//    }
//}
////}
//
//

//import UIKit
//import AVFoundation
//
//
//class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//    class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//        var captureSession: AVCaptureSession!
//        var previewLayer: AVCaptureVideoPreviewLayer!
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            view.backgroundColor = UIColor.black
//            captureSession = AVCaptureSession()
//
//            let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
//            let videoInput: AVCaptureDeviceInput
//
//            do {
//                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
//            } catch {
//                return
//            }
//
//            if (captureSession.canAddInput(videoInput)) {
//                captureSession.addInput(videoInput)
//            } else {
//                failed();
//                return;
//            }
//
//            let metadataOutput = AVCaptureMetadataOutput()
//
//            if (captureSession.canAddOutput(metadataOutput)) {
//                captureSession.addOutput(metadataOutput)
//
//                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//                metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.pdf417]
//            } else {
//                failed()
//                return
//            }
//
//            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
//            previewLayer.frame = view.layer.bounds;
//            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
//            view.layer.addSublayer(previewLayer);
//
//            captureSession.startRunning();
//        }
//
//        func failed() {
//            let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
//            captureSession = nil
//        }
//
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//
//            if (captureSession?.isRunning == false) {
//                captureSession.startRunning();
//            }
//        }
//
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//
//            if (captureSession?.isRunning == true) {
//                captureSession.stopRunning();
//            }
//        }
//
//     //   func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
//
//        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
//
//        {
//            captureSession.stopRunning()
//
//            if let metadataObject = metadataObjects.first {
//                let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
//
//                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//                found(code: readableObject.stringValue!);
//            }
//
//            dismiss(animated: true)
//        }
//
//        func found(code: String) {
//            print(code)
//        }
//
//        override var prefersStatusBarHidden: Bool {
//            return true
//        }
//
//        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//            return .portrait
//        }
//    }}
import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Scanner"
        view.backgroundColor = .white
        
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                let captureSession = AVCaptureSession()
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                print("Error Device Input")

            } catch {
                print("Error Device Input")
            }
            
        }
        
    }
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        if metadataObjects.count == 0 {
//            print("No Input Detected")
//            return
//        }
//        
//        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//        
//        guard let stringCodeValue = metadataObject.stringValue else { return }
//        // Create some label and assign returned string value to it
//     //   codeLabel.text = stringCodeValue
//        print(stringCodeValue)
//       
//        let alertController = UIAlertController(title: "Materialcode", message: stringCodeValue, preferredStyle: UIAlertControllerStyle.alert)
//    self.present(alertController, animated: true, completion: nil)
//
//        
//        // Perform further logic needed (ex. redirect to other ViewController)
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
