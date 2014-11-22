//
//  ResultViewController.swift
//  beer73
//
//  Created by akihito on 2014/11/21.
//  Copyright (c) 2014年 KYlab. All rights reserved.
//

import UIKit

class ResultViewController : UIViewController {
    
    var cameraImage : UIImage!
    var score : Int32 =  -1
    
    var myProgressView : UIProgressView!
    var pernum : Float32 = 0.0;
    
    // 画像を設定する.
    //var cameraImage = UIImage(named: "beer.JPG")

    // ImageViewを.定義する.
    //var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        cameraImage = UIImage(named: "beer.JPG")
        score = 85;
        
        // UIImageViewを生成する.
        var myImageView = UIImageView()
        
        // myImageViewのimageにmyImageを設定する.
        myImageView.image = cameraImage
   
        // frameの値を設定する.
        myImageView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        
        self.view.addSubview(myImageView)
  
        /*
        // -----
        // 画像を設定する.
        var myImage : UIImage!
        myImage = UIImage(named: "beer.JPG")
        
        // 画像を縮小する.
        let myScaleDownView: UIImageView = UIImageView(frame:  CGRect(x: 100, y: 30, width: 80, height: 80))
        
        // UIImageViewに画像を設定する.
        myScaleDownView.image = myImage
        
        // 縮小用(0.5倍)のアフィン行列を生成する.
        myScaleDownView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        
        // Viewに追加する.
        self.view.addSubview(myScaleDownView)
        
        
        // 画像を拡大する.
        let myScaleUpView: UIImageView = UIImageView(frame:  CGRect(x: 100, y: 120, width: 80, height: 80))
        
        // UIImageViewに画像を設定する.
        myScaleUpView.image = myImage
        
        // 縮小用(0.5倍)のアフィン行列を生成する.
        myScaleUpView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        
        // Viewに追加する.
        self.view.addSubview(myScaleUpView)
        
        
        // 画像を回転する.
        var myRotateView:UIImageView = UIImageView(frame: CGRect(x: 100, y: 250, width: 80, height: 80))
        
        // UIImageViewに画像を設定する.
        myRotateView.image = myImage
        
        // radianで回転角度を指定(30度)する.
        var angle:CGFloat = CGFloat((30.0 * M_PI) / 180.0)
        
        // 回転用のアフィン行列を生成する.
        myRotateView.transform = CGAffineTransformMakeRotation(angle)
        
        // Viewに張りつけ
        self.view.addSubview(myRotateView)
        
        
        
        // 画像を反転する.
        let myReverseView: UIImageView = UIImageView(frame:  CGRect(x: 100, y: 360, width: 80, height: 80))
        
        // 画像を設定する.
        myReverseView.image = myImage
        
        // 縮小用(0.5倍)のアフィン行列を生成する
        myReverseView.transform = CGAffineTransformScale(myReverseView.transform, -1.0, 1.0)
        
        // Viewに追加する.
        self.view.addSubview(myReverseView)
        
        // -----
        
        // Labelを作成.
        let myLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))

        // 背景をオレンジ色にする.
        myLabel.backgroundColor = UIColor.orangeColor()
        
        // 枠を丸くする.
        myLabel.layer.masksToBounds = true
        
        // コーナーの半径.
        myLabel.layer.cornerRadius = 20.0
        
        // Labelに文字を代入.
        let scoretext = score
        myLabel.text = "\(scoretext) 点 wwwww"
        
        // 文字の色を白にする.
        myLabel.textColor = UIColor.whiteColor()
        
        // 文字の影の色をグレーにする.
        myLabel.shadowColor = UIColor.grayColor()
        
        // Textを中央寄せにする.
        myLabel.textAlignment = NSTextAlignment.Center
        
        // 配置する座標を設定する.
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        
        // Viewの背景色を青にする.
        self.view.backgroundColor = UIColor.cyanColor()
        
        // ViewにLabelを追加.
        self.view.addSubview(myLabel)
        */
        
        // ---------
        
        // 背景色を黄色にする.
        //self.view.backgroundColor = UIColor.yellowColor()
        
        // ProgressViewを作成する.
        //var myProgressView: UIProgressView = UIProgressView(frame: CGRectMake(0, 0, 200, 10))
        myProgressView = UIProgressView(frame: CGRectMake(0, 0, 200, 10))
        myProgressView.progressTintColor = UIColor.greenColor()
        myProgressView.trackTintColor = UIColor.whiteColor()
        
        // 座標を設定する.
        myProgressView.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height * 3/4)
        
        // バーの高さを設定する(横に1.0倍,縦に10.0倍).
        myProgressView.transform = CGAffineTransformMakeScale(1.0, 10.0)
        
        // 進捗具合を設定する(0.0~1.0).
        myProgressView.progress = 0.0
        
        // Viewに追加する.
        self.view.addSubview(myProgressView)
        
    }
    
    
    func update() {
        // バーにアニメーションを付ける.
        if( Float32(score) * 0.01 > pernum ){
            pernum += Float32(score) * 0.01;
            myProgressView.setProgress(pernum, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
