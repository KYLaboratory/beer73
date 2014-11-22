//
//  ViewController.swift
//  beer73
//
//  Created by akihito on 2014/11/21.
//  Copyright (c) 2014年 KYlab. All rights reserved.
// 777000


import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput : AVCaptureStillImageOutput!
    
    var myImage : UIImage?
    var score : Int32 = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // セッションの作成.
        mySession = AVCaptureSession()
        
        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()
        
        // バックカメラをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as AVCaptureDevice
            }
        }
        
        // バックカメラからVideoInputを取得.
        let videoInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as AVCaptureDeviceInput
        
        // セッションに追加.
        mySession.addInput(videoInput)
        
        // 出力先を生成.
        myImageOutput = AVCaptureStillImageOutput()
        
        // セッションに追加.
        mySession.addOutput(myImageOutput)
        
        // 画像を表示するレイヤーを生成.
        let myVideoLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as AVCaptureVideoPreviewLayer
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Viewに追加.
        self.view.layer.addSublayer(myVideoLayer)
        
        // セッション開始.
        mySession.startRunning()
        
        // UIボタンを作成.
        let myButton = UIButton(frame: CGRectMake(0,0,120,50))
        myButton.backgroundColor = UIColor.redColor();
        myButton.layer.masksToBounds = true
        myButton.setTitle("撮影", forState: .Normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // UIボタンをViewに追加.
        self.view.addSubview(myButton);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if mySession.running {
            mySession.stopRunning()
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
    
    func showAlert() {
        if let gotModernAlert : AnyClass = NSClassFromString("UIAlertController") {
            // UIAlertControllerを作成する.
            let myAlert = UIAlertController(title: "認識エラー", message: "ビールが見えません！", preferredStyle: .Alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "撮り直す", style: .Default) { action in
                println("Action OK!!")
            }
            
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            self.presentViewController(myAlert, animated: true, completion: nil)
        } else {
            let alertView : UIAlertView = UIAlertView(title: "認識エラー", message: "ビールが見えません！", delegate: nil, cancelButtonTitle: "撮り直す")
            alertView.show()
        }
    }
    
    // ボタンイベント.
    func onClickMyButton(sender: UIButton){
        // ビデオ出力に接続.
        let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        // 接続から画像を取得.
        myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection, completionHandler: {(imageDataBuffer, error) -> Void in
            
            // 取得したImageのDataBufferをJpegに変換.
            let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            
            // JpegからUIIMageを作成.
            self.myImage = UIImage(data: myImageData)
            
            self.score = ScoreCalculator.calcScore(self.myImage)
            
            // アルバムに追加.
            //UIImageWriteToSavedPhotosAlbum(myImage, self, nil, nil)
            self.score = 100
            
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
    
    @IBAction func unwindSegueToCamera(segue : UIStoryboardSegue){
        
    }
}

