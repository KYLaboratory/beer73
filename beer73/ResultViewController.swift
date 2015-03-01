//
//  ResultViewController.swift
//  beer73
//
//  Created by akihito on 2014/11/21.
//  Copyright (c) 2014年 KYlab. All rights reserved.
//

import UIKit
//import Spritekit
import Social

class ResultViewController : UIViewController {
    
    var cameraImage : UIImage!
    var score : Int32 =  -1
    
    var myProgressView : UIProgressView!
    var pernum : Float32 = 0.0;
    //var pernum : Int32 = 0;
    var beerShowFlag : Float32 = 0.0;
    var scoreShowFlag : Int32 = 1
    var countUp : Int32 = 0
    var countUp2 : Int32 = 0
    var myButtonBefore : UIButton!
    var myComposeView : SLComposeViewController!
    var myTwitterButton : UIButton!
    var myFacebookButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // timer 最初の引数でスピード決定する
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        ///////////////////////////
        //cameraImage = UIImage(named: "beer.JPG")
        //score = 85;
        
        // UIImageViewを生成する.
        var myImageView = UIImageView()
        myImageView.contentMode = UIViewContentMode.ScaleAspectFit
   
        // frameの値を設定する.
        myImageView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        
        // myImageViewのimageにmyImageを設定する.
        
        myImageView.image = cameraImage
        
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
        //myScaleDownView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        
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
        */
        // -----
        
        
        // ---------
        

        
        
        // 背景色を黄色にする.
        //self.view.backgroundColor = UIColor.yellowColor()
        
        // ProgressViewを作成する.
        //var myProgressView: UIProgressView = UIProgressView(frame: CGRectMake(0, 0, 200, 10))
        /*myProgressView = UIProgressView(frame: CGRectMake(0, 0, 200, 10))
        
        
        ******************************************************************************************************************
        スコアバー
        
        myProgressView.progressTintColor = UIColor.greenColor()
        myProgressView.trackTintColor = UIColor.whiteColor()
        
        // 座標を設定する.
        myProgressView.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height * 3/4)
        
        // バーの高さを設定する(横に1.0倍,縦に10.0倍).
        myProgressView.transform = CGAffineTransformMakeScale(1.0, 10.0)
        
        // 進捗具合を設定する(0.0~1.0).
        myProgressView.progress = 0.0
        
        // Viewに追加する.
        self.view.addSubview(myProgressView)*/
        
        /******************************************************************************************************************/
        
    }
    
    func update() {
        countUp++
        countUp2++
        
        if countUp <= 3{
        
        /******************************************************************************************************************/
        // Labelを作成.
        let myLabelbub: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height/3))
        
        // 背景色設定.
        myLabelbub.backgroundColor = UIColor.whiteColor()
        
        
        // 配置する座標を設定する.
        myLabelbub.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/6)
        
        
        // ViewにLabelを追加.
        self.view.addSubview(myLabelbub)
        
        /******************************************************************************************************************/
        
        
          // Labelを作成.
          let myLabelbeer: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        
          // 背景色設定.
          myLabelbeer.backgroundColor = UIColor.yellowColor()
        
        
          // 配置する座標を設定する.
          myLabelbeer.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height*4/5)
        
        
          // ViewにLabelを追加.
          self.view.addSubview(myLabelbeer)

        
        }
        
        
        /*
            /*******************************************************************************************/
            
            
            //let box:SKSpriteNode = SKSpriteNode(color:SKColor.blueColor(), size:CGSizeMake(200, 200))
            //box.position = CGPointMake(self.view.bounds.width/2.0, self.view.bounds.height/2.0)
            //addChild(box)
            
            let view:SKView = SKView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
            
            // PlaygroundのTimelineに表示
            
            
            // シーンを生成、背景を黒にしてビューに追加
            let scene:SKScene = SKScene(size: CGSizeMake(self.view.bounds.width, self.view.bounds.height))
            scene.backgroundColor = SKColor.blackColor();
            view.presentScene(scene)
            
            // 青い四角を追加
            let box:SKSpriteNode = SKSpriteNode(color:SKColor.blueColor(), size:CGSizeMake(200, 200))
            box.position = CGPointMake(self.view.bounds.width/2.0, self.view.bounds.height/2.0)
            scene.addChild(box)
            
         /*******************************************************************************************/
        */
        
        // Labelを作成.
        let myLabelcount: UILabel = UILabel(frame: CGRectMake(0,0,100,100))
        
        // 背景を白色にする.
        myLabelcount.backgroundColor = UIColor.whiteColor()
        
        // 枠を丸くする.
        myLabelcount.layer.masksToBounds = true
        
        // コーナーの半径.
        myLabelcount.layer.cornerRadius = 50.0
        
        // Labelに文字を代入.
        let scoretext = score
        myLabelcount.text = "3"
        
        myLabelcount.font = UIFont.systemFontOfSize(CGFloat(50))
        
        // 文字の色を黒にする.
        myLabelcount.textColor = UIColor.blackColor()
        
        // 文字の影の色をグレーにする.
        myLabelcount.shadowColor = UIColor.grayColor()
        
        // Textを中央寄せにする.
        myLabelcount.textAlignment = NSTextAlignment.Center
        
        // 配置する座標を設定する.
        myLabelcount.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        // Viewの背景色を青にする.
        //self.view.backgroundColor = UIColor.cyanColor()
        
        // ViewにLabelを追加.
        self.view.addSubview(myLabelcount)
        
            if countUp > 1{
                // Labelを作成.
                let myLabelcount: UILabel = UILabel(frame: CGRectMake(0,0,100,100))
                
                // 背景をオレンジ色にする.
                myLabelcount.backgroundColor = UIColor.whiteColor()
                
                // 枠を丸くする.
                myLabelcount.layer.masksToBounds = true
                
                // コーナーの半径.
                myLabelcount.layer.cornerRadius = 50.0
                
                // Labelに文字を代入.
                let scoretext = score
                myLabelcount.text = "2"
                
                myLabelcount.font = UIFont.systemFontOfSize(CGFloat(50))
                
                // 文字の色を白にする.
                myLabelcount.textColor = UIColor.blackColor()
                
                // 文字の影の色をグレーにする.
                myLabelcount.shadowColor = UIColor.grayColor()
                
                // Textを中央寄せにする.
                myLabelcount.textAlignment = NSTextAlignment.Center
                
                // 配置する座標を設定する.
                myLabelcount.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
                
                // Viewの背景色を青にする.
                //self.view.backgroundColor = UIColor.cyanColor()
                
                // ViewにLabelを追加.
                self.view.addSubview(myLabelcount)
            }
        if countUp > 2{
            // Labelを作成.
            let myLabelcount: UILabel = UILabel(frame: CGRectMake(0,0,100,100))
            
            // 背景をオレンジ色にする.
            myLabelcount.backgroundColor = UIColor.whiteColor()
            
            // 枠を丸くする.
            myLabelcount.layer.masksToBounds = true
            
            // コーナーの半径.
            myLabelcount.layer.cornerRadius = 50.0
            
            // Labelに文字を代入.
            let scoretext = score
            myLabelcount.text = "1"
            
            myLabelcount.font = UIFont.systemFontOfSize(CGFloat(50))
        
            // 文字の色を白にする.
            myLabelcount.textColor = UIColor.blackColor()
            
            // 文字の影の色をグレーにする.
            myLabelcount.shadowColor = UIColor.grayColor()
            
            // Textを中央寄せにする.
            myLabelcount.textAlignment = NSTextAlignment.Center
            
            // 配置する座標を設定する.
            myLabelcount.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
            
            // Viewの背景色を青にする.
            //self.view.backgroundColor = UIColor.cyanColor()
            
            // ViewにLabelを追加.
            self.view.addSubview(myLabelcount)
        }
        /**************************************************************************************************************/
        //}
        
        
        
        
      /*  self.TargetViewStrong.removeFromSuperview()
        
        // 非表示にするコード
        //self.TargetViewStrong.hidden = true
    } else {
    // 追加
    self.view.addSubview(self.TargetViewStrong)*/
    
    
        
        
        
        
        // バーにアニメーションを付ける.
        /*if( Float32(self.view.bounds.height*7/10) > pernum ){
            pernum += Float32(self.view.bounds.height*7/10);
            myLabel.(pernum, animated: true);
        }else{
        }*/
        
        if countUp > 3{
            var myImageView = UIImageView()
            myImageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            // frameの値を設定する.
            myImageView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
            
            // myImageViewのimageにmyImageを設定する.
            
            
            myImageView.image = cameraImage
            
            self.view.addSubview(myImageView)
            
            
            
            
            
            
           
            self.showScoreViews()
            scoreShowFlag *= -1
        }
        
        // Buttonポップアップ

        if countUp > 5 {
            self.showstump()
        }
        if countUp > 8 {
            self.showButtons()
        }
    }

    func showScoreViews(){
        self.showScoreLabel()
        self.showScoreBackView()
    }
    
    func showScoreLabel(){//オレンジ枠の点数表示
        // Labelを作成.
        let myLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
        
        // 背景をオレンジ色にする.
        myLabel.backgroundColor = UIColor.orangeColor()
        
        // 枠を丸くする.
        myLabel.layer.masksToBounds = true
        
        // コーナーの半径.
        myLabel.layer.cornerRadius = 10.0
        
        // Labelに文字を代入.
        let scoretext = score
        myLabel.text = "★★ \(scoretext) 点 ★★"
        
        // 文字の色を白にする.
        myLabel.textColor = UIColor.whiteColor()
        
        // 文字の影の色をグレーにする.
        myLabel.shadowColor = UIColor.grayColor()
        
        // Textを中央寄せにする.
        myLabel.textAlignment = NSTextAlignment.Center
        
        // 配置する座標を設定する.
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height-self.view.bounds.height/3)
        
        // Viewの背景色を青にする.
        //self.view.backgroundColor = UIColor.cyanColor()
        
        // ViewにLabelを追加.
        self.view.addSubview(myLabel)
    }
    
    /**************************************************************************/
    func showstump(){
        if score > 80 {
            var stumpImage : UIImage!
            stumpImage=UIImage(named: "stump1.png")
            // UIImageViewを生成する.
            var myImageView = UIImageView()
         
            // myImageViewのimageにmyImageを設定する.
            myImageView.image = stumpImage
        
            // frameの値を設定する.
            myImageView.frame = CGRectMake(0, 0, 200, 200)
        
            myImageView.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/3)
        
            self.view.addSubview(myImageView)
        
    
    /**************************************************************************/
    // Labelを作成.
            let myLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
    
    
            myLabel.backgroundColor = UIColor.clearColor()
    
    // Labelに文字を代入.
            
            myLabel.text = "職人"
            
            myLabel.font = UIFont.systemFontOfSize(CGFloat(50))
    
    // 文字の色を赤にする.
            myLabel.textColor = UIColor.redColor()
    
    // Textを中央寄せにする.
            myLabel.textAlignment = NSTextAlignment.Center
    
    // 配置する座標を設定する.
            myLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/3)
    
    
    // ViewにLabelを追加.
            self.view.addSubview(myLabel)
    
    
    /**************************************************************************/
        }
    }
    
    func showScoreBackView(){
        
        var syuchuImage : UIImage!
        if scoreShowFlag > 0 {
            syuchuImage = UIImage(named: "shuchu.png")
        }else{
            syuchuImage = UIImage(named: "shuchu2.png")
        }

        // UIImageViewを生成する.
        var myImageView = UIImageView()
        
        // myImageViewのimageにmyImageを設定する.
        myImageView.image = syuchuImage
        
        myImageView.alpha = 0.5
        
        // frameの値を設定する.
        myImageView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        
        self.view.addSubview(myImageView)
        
        // 削除
        // 現状、集中線以外のオブジェクトがたぶん１０個くらいある
        var subviews = self.view.subviews
        var count = 0
        for subview in subviews {
            subview.removeFromSuperview()
            count++

            if(subviews.count - 10 == count){
                break;
            }
        }
    }
    
    func showButtons(){
        
        
        /*********************************************************************************/
        // Labelを作成.
        let myLabel: UILabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width,70))
        
        // 背景色設定（ダークグレー）.
        myLabel.backgroundColor = UIColor.darkGrayColor()
        
        
        // 配置する座標を設定する.
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height-30)
        
        
        // ViewにLabelを追加.
        self.view.addSubview(myLabel)
        /************************************************************************************/
        
        
        
        // UIボタンを作成
        myButtonBefore = UIButton(frame: CGRectMake(0,0,90,50))
        myButtonBefore.backgroundColor = UIColor.redColor();
        myButtonBefore.layer.masksToBounds = true
        myButtonBefore.setTitle("撮影画面", forState: .Normal)
        myButtonBefore.layer.cornerRadius = 10.0
        myButtonBefore.layer.position = CGPoint(x: self.view.bounds.width/2-100 , y:self.view.bounds.height-30)
        myButtonBefore.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(myButtonBefore);
        
        /**************************************************************************************************/
        
        // Twitter用のUIButtonの生成.
        let hex: Int = 0x55ACEE
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var myColor: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1.0))
        
        // ボタン.
        /**************************************************************************************************/
        myTwitterButton = UIButton()
        myTwitterButton.frame = CGRectMake(0,0,90,50)
        myTwitterButton.backgroundColor = myColor
        myTwitterButton.layer.masksToBounds = true
        myTwitterButton.setTitle("Twitter", forState: UIControlState.Normal)
        myTwitterButton.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(20))
        myTwitterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myTwitterButton.layer.cornerRadius = 10.0
        myTwitterButton.layer.position = CGPoint(x: self.view.frame.width/2+100, y:self.view.bounds.height-30)
        myTwitterButton.tag = 1
        myTwitterButton.addTarget(self, action: "onPostToTwitter:", forControlEvents: .TouchUpInside)
        
        // buttonをviewに追加.
        self.view.addSubview(myTwitterButton)
        
        /**************************************************************************************************/

        // Facebook用のUIButtonの生成.
        myFacebookButton = UIButton(frame: CGRectMake(0, 0, 90, 50))
        myFacebookButton.backgroundColor = UIColor.blueColor()
        myFacebookButton.setTitle("Facebook", forState: UIControlState.Normal)
        myFacebookButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myFacebookButton.addTarget(self, action: "postToFacebook:", forControlEvents: UIControlEvents.TouchUpInside)
        myFacebookButton.layer.cornerRadius = 10.0
        myFacebookButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.bounds.height-30)
        
        // buttonをviewに追加.
        self.view.addSubview(myFacebookButton)
        /**************************************************************************************************/
    }
    
    func onClickMyButton(sender: UIButton){
        self.performSegueWithIdentifier("back_to_camera",sender: nil)
    }
    
    func onPostToTwitter(sender : AnyObject) {
        // SLComposeViewControllerのインスタンス化.
        // ServiceTypeをTwitterに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 投稿するテキストを指定.
        let scoretext = score
        myComposeView.setInitialText("このビールの出来栄えは\(scoretext)点です!!")
        
        // 投稿する画像を指定.
        myComposeView.addImage(cameraImage)
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
    // ボタンイベント.
    func postToFacebook(sender : AnyObject) {
        // postToTwitterと同様.
        // ServiceTypeをFacebookに指定
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        // 投稿するテキストを指定.
        let scoretext = score
        myComposeView.setInitialText("このビールの出来栄えは\(scoretext)点です!!")
        
        // 投稿する画像を指定.
        myComposeView.addImage(cameraImage)
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
