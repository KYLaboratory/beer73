//
//  Camera.swift
//  beer73
//
//  Created by akihito on 2014/11/22.
//  Copyright (c) 2014年 KYlab. All rights reserved.
//

import AVFoundation

class Camera {
    
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput : AVCaptureStillImageOutput!
    
    init()
    {
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

    }
    
    deinit
    {
        
    }
    
    func captureImage() -> UIImage!
    {
        var myImage : UIImage!
        
        // ビデオ出力に接続.
        let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        // 接続から画像を取得.
        myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection,
            completionHandler:
            {
                (imageDataBuffer, error) -> Void in
                
                // 取得したImageのDataBufferをJpegに変換.
                let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
                
                // JpegからUIIMageを作成.
                myImage = UIImage(data: myImageData)!
            }
        )
        
        return myImage
    }
}