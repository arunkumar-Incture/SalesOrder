
import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate,UITextFieldDelegate {
    
    //var captureDevice:AVCaptureDevice?
    var previewLayer:AVCaptureVideoPreviewLayer?
    var captureSession: AVCaptureSession!
    var strBarcode = NSString()
    @IBOutlet var lblOR: UILabel!
    
    @IBOutlet var txtBarcodeValue: UITextField!
    
    @IBOutlet var viewPostscan: UIView!
    
    @IBOutlet var lblBarcodeValue: UILabel!
    
    @IBOutlet var txtQty: UITextField!
    
    @IBOutlet var btnSave: UIButton!
    
    @IBOutlet var btnCancel: UIButton!
    
    @IBOutlet var btnQtyInfo: UIButton!
    
    @IBOutlet var lblQtyInfo: UILabel!
    
    
    var btnBackBarcode: UIButton!
    
    
    
    
    @IBAction func didActionSave(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didActionCancel(_ sender: Any) {
        viewPostscan.isHidden = true
        txtQty.resignFirstResponder()
        barcodescanInitiate()

        //self.barcodescanInitiate()
    }
    
    
    
    
    @IBAction func didActionHome(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Scanner"
        view.backgroundColor = .white
        lblQtyInfo.isHidden = true

        txtBarcodeValue.delegate = self
        txtQty.delegate = self

        lblOR.layer.cornerRadius = lblOR.frame.size.height/2.0
        lblOR.layer.masksToBounds = true
        lblOR.layer.borderWidth = 1.0
        lblOR.layer.backgroundColor = UIColor.black.cgColor
        
        //: X=20 Y=40 Width=280 Height=350
        //view.frame = CGRect(x: 60, y:160, width: 280, height: 200)
        //btnBackBarcode = UIButton()
        
       barcodescanInitiate()
    }
    
   
    
    @IBAction func didActionQtyInfo(_ sender: UIButton) {
       
     
        if ((sender as AnyObject).isSelected == true)
        {
            sender.isSelected = false;
            lblQtyInfo.isHidden = true
            lblQtyInfo.text = " Inventory stock: 200"
        }
        else
        {
            sender.isSelected = true;
            lblQtyInfo.isHidden = false
            lblQtyInfo.text = " Inventory stock: 200"
        }
    }
    
    
   @IBAction  func barcodescanInitiate(){
      //  view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
    
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
    
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
    
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
    
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            print(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }
    
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = CGRect(x: 0, y:140, width: self.view.frame.size.width, height: self.view.frame.size.height)
       // previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
    
        captureSession.startRunning()

    
    
    }
    
  
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
            previewLayer?.isHidden = false

        }
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
            self.dismiss(animated: true, completion: nil)
previewLayer?.isHidden = true
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        
        print("BARCODE--> \(code) ")
        strBarcode = code as NSString
        print("strBarcode--> \(strBarcode) ")

       viewPostscan.isHidden = false
        lblBarcodeValue.text = strBarcode as String
        self.view.addSubview(viewPostscan)
//        let alert = UIAlertController(title: "Found a Barcode!", message: code, preferredStyle: UIAlertControllerStyle.alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//       // show(alert, sender: self)
//self.present(alert, animated: false, completion: nil)
   //  self.navigationController?.popViewController(animated: true)

    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didActionSearch(_ sender: Any) {
        if !((txtBarcodeValue.text?.isEmpty)! )
        {
            txtBarcodeValue .resignFirstResponder()
            viewPostscan.isHidden = false
            strBarcode = txtBarcodeValue.text! as NSString
            lblBarcodeValue.text = strBarcode as String
            self.view.addSubview(viewPostscan)
        }
        else{
            txtBarcodeValue .resignFirstResponder()

            viewPostscan.isHidden = true

        }
       
  }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //Text field delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //  let a = lbStockINQTY.text as NSInteger
        //let b = lbStockOUTQTY.text as NSInteger
        print("Text field edit")
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        print("Text field should begin edit")

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        print("Text field did end edit")
        txtBarcodeValue.resignFirstResponder()
        txtQty.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtBarcodeValue.resignFirstResponder()
        txtQty.resignFirstResponder()
        return true

    }
    
//     func textFieldShouldReturn(textField: UITextField) -> Bool
//    {
//        txtBarcodeValue.resignFirstResponder()
//        txtQty.resignFirstResponder()
//        for textField in self.view.subviews where textField is UITextField {
//            textField.resignFirstResponder()
//        }
//
//
//        return true
//    }
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
