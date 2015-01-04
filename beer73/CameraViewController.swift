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
        let myButton = UIButton(frame: CGRectMake(0,0,120,50))
        myButton.backgroundColor = UIColor.redColor()
        myButton.layer.masksToBounds = true
        myButton.setTitle("撮影", forState: .Normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-100)
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(myButton)
        
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

