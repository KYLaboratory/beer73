//
//  ResultViewController.swift
//  beer73
//
//  Created by akihito on 2014/11/21.
//  Copyright (c) 2014年 KYlab. All rights reserved.
//

import UIKit

class ResultViewController : UIViewController {
    
    //var cameraImage : UIImage!
    var score : Int32 =  -1
    
    // 画像を設定する.
    var cameraImage = UIImage(named: "beer.JPG")

    // ImageViewを.定義する.
    //var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIImageViewを生成する.
        var myImageView = UIImageView()
        
        // myImageViewのimageにmyImageを設定する.
        myImageView.image = cameraImage
        
        // frameの値を設定する.
        myImageView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        
        self.view.addSubview(myImageView)
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
