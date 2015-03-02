//
//  ViewController.swift
//  beer73
//
//  Created by akihito on 2014/11/21.
//  Copyright (c) 2014年 KYlab. All rights reserved.
// 777000


import UIKit
import AVFoundation
import iAd

class CameraViewController: UIViewController {
    
    var mySession : AVCaptureSession!
    var myDevice : AVCaptureDevice!
    var myImageOutput : AVCaptureStillImageOutput!
    var myImage : UIImage?
    
    let photoButton = UIButton()
    
    let infoWindow = UIView()
    let infoOpenButton = UIButton.buttonWithType(UIButtonType.InfoDark) as UIButton
    let infoCloseButton = UIButton()
    
    var score : Int32 = -1 // -1はエラー
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySession = AVCaptureSession()
        
        let myVideoInput = getVideoInput()
        mySession.addInput(myVideoInput)
        
        myImageOutput = AVCaptureStillImageOutput()
        mySession.addOutput(myImageOutput)
        
        // 画像を表示するレイヤーを生成してviewに追加
        let myVideoLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as AVCaptureVideoPreviewLayer
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(myVideoLayer)
        
        mySession.startRunning()
        
        // 撮影ボタンを生成してviewに追加
        photoButton.frame = CGRectMake(0,0,120,50)
        photoButton.backgroundColor = UIColor.redColor()
        photoButton.layer.masksToBounds = true
        photoButton.setTitle("撮影", forState: .Normal)
        photoButton.layer.cornerRadius = 20.0
        photoButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-100)
        photoButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(photoButton)
        
        // 説明ボタンを追加
        infoOpenButton.layer.position = CGPoint(x: self.view.frame.width - 30, y: 45);
        infoOpenButton.addTarget(self, action: "onClickInfoButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(infoOpenButton)
        
        infoWindow.frame = CGRectMake(10, self.view.frame.height / 2 - 150, self.view.frame.width - 25, 250)
        infoWindow.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
        infoWindow.layer.masksToBounds = true
        infoWindow.layer.cornerRadius = 20.0
        infoWindow.layer.borderWidth = 2
        infoWindow.layer.borderColor = UIColor.whiteColor().CGColor
        
        infoCloseButton.frame = CGRectMake(0,0,120,50)
        infoCloseButton.backgroundColor = UIColor.orangeColor()
        infoCloseButton.setTitle("閉じる", forState: .Normal)
        infoCloseButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        infoCloseButton.layer.masksToBounds = true
        infoCloseButton.layer.cornerRadius = 20.0
        infoCloseButton.layer.position = CGPointMake(self.infoWindow.frame.width / 2, self.infoWindow.frame.height - 30)
        infoCloseButton.addTarget(self, action: "onClickInfoCloseButton:", forControlEvents: .TouchUpInside)
        self.infoWindow.addSubview(infoCloseButton)
        
        let infoTextView : UITextView = UITextView(frame: CGRectMake(10, 10, self.infoWindow.frame.width - 20, self.infoWindow.frame.height - 70))
        infoTextView.backgroundColor = UIColor.clearColor()
        infoTextView.text = "ビールを撮って、ビールと泡の７：３具合を判定しましょう！\nビールが画面いっぱいに大きく写るように、正面から、なるべく明るい場所で撮影してください。"
        infoTextView.font = UIFont.systemFontOfSize(CGFloat(20))
        infoTextView.textColor = UIColor.whiteColor()
        infoTextView.textAlignment = NSTextAlignment.Natural
        infoTextView.editable = false
        self.infoWindow.addSubview(infoTextView)
        
        self.canDisplayBannerAds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //if mySession.running {
        //  mySession.stopRunning()
        //`}
    }
    
    func getVideoInput() -> AVCaptureDeviceInput{
        // バックカメラをmyDeviceに格納.
        let devices = AVCaptureDevice.devices() // デバイス一覧の取得
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as AVCaptureDevice
            }
        }
        // バックカメラからVideoInputを取得.
        return AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as AVCaptureDeviceInput
    }
    
    func onClickMyButton(sender: UIButton){
        let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        // 接続から画像を取得.
        myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection, completionHandler: {(imageDataBuffer, error) -> Void in
            
            // 取得したImageのDataBufferをJpegに変換.
            let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            
            // JpegからUIIMageを作成.
            self.myImage = UIImage(data: myImageData)
            
            // for debug sumi
            // for debug sumi
            // for debug sumi
            //self.myImage = ScoreCalculator.getProcessImage(self.myImage);
            
            self.score = ScoreCalculator.calcScore(self.myImage)
            
            if self.score < 0
            {
                self.showAlert()
            }
            else
            {
                self.performSegueWithIdentifier("shutter",sender: nil)
            }
        })
    }
    
    func onClickInfoButton(sender: UIButton){
        infoOpenButton.enabled = false
        photoButton.enabled = false
        photoButton.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(infoWindow)
    }
    
    func onClickInfoCloseButton(sender: UIButton){
        infoWindow.removeFromSuperview()
        infoOpenButton.enabled = true
        photoButton.backgroundColor = UIColor.redColor()
        photoButton.enabled = true
    }
    
    func showAlert() {
        if let gotModernAlert : AnyClass = NSClassFromString("UIAlertController") {
            // for iOS8 and later
            let myAlert = UIAlertController(title: "認識エラー", message: "ビールが見えません！", preferredStyle: .Alert)
            let myOkAction = UIAlertAction(title: "撮り直す", style: .Default) { action in println("Action OK!!") }
            myAlert.addAction(myOkAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        } else {
            let alertView : UIAlertView = UIAlertView(title: "認識エラー", message: "ビールが見えません！", delegate: nil, cancelButtonTitle: "撮り直す")
            alertView.show()
        }
    }
    
    //画面遷移
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "shutter") {
            let resultViewControler: ResultViewController = segue.destinationViewController as ResultViewController
            resultViewControler.cameraImage = myImage
            resultViewControler.score = score
        }
    }
    
    @IBAction func unwindSegueToCamera(segue : UIStoryboardSegue){
        
    }
}

