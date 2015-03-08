//
//  ScoreCalculator.m
//  beer73
//
//  Created by akihito on 2014/11/21.
//  Copyright (c) 2014年 KYlab. All rights reserved.
//

#import "beer73-Bridging-Header.h"
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

@implementation ScoreCalculator : NSObject

+(int)calcScore:(const UIImage*)image
{
    cv::Mat rgbImage, dstImg;
    UIImageToMat(image, rgbImage);
    
    /////
    /////
    /////
    
    //cv::GaussianBlur(rgbImage, dstImg, cv::Size(101,101), 80, 80);
    cv::GaussianBlur(rgbImage, dstImg, cv::Size(51,51), 80, 80);
    /////
    /////
    /////

    cv::Mat hsvImage;
    cv::cvtColor(dstImg, hsvImage, CV_RGB2HSV);
    
    int countbeer = 0;
    int countbubble = 0;
    //double countbeer2 = 0;
    //double countbubble2 = 0;
    double countbeer3 = 0;
    double countbubble3 = 0;

    int half_width = hsvImage.cols / 2; // iPhoneを縦向きに使ったときの、横方向の画素の中心の意味
    int half_height = hsvImage.rows / 2; // iPhoneを縦向きに使ったときの、縦方向の画素の中心の意味
    
    double hhue = 0;
    double hsat = 0;
    double hval = 0;
    int buff = 0;
    for(int j = half_height - buff; j <= half_height + buff; j++){
        for(int i = half_width - buff; i <= half_width + buff; i++){
            hhue += hsvImage.data[j * hsvImage.step + i + 0] * 2.0;
            hsat += hsvImage.data[j * hsvImage.step + i + 1] / 255.0;
            hval += hsvImage.data[j * hsvImage.step + i + 2] / 255.0;
        }
    }
    NSLog(@"hhue %lf hsat %lf hval %lf\n", hhue, hsat, hval);

    hhue = hhue / ((buff * 2 + 1) * (buff * 2 + 1));
    hsat = hsat / ((buff * 2 + 1) * (buff * 2 + 1));
    hval = hval / ((buff * 2 + 1) * (buff * 2 + 1));

    for(int j = 0; j < hsvImage.rows; j++){
        for(int i = 0; i < hsvImage.cols; i++){
            double hue = hsvImage.data[j * hsvImage.step + i + 0] * 2.0;
            double sat = hsvImage.data[j * hsvImage.step + i + 1] / 255.0;
            double val = hsvImage.data[j * hsvImage.step + i + 2] / 255.0;
        
            //if(20.0 <= hue && hue <= 60.0 && sat >= 0.35 && val >= 0.35){
            if( fabs(hhue - 10.0) <= hue && hue <= hhue + 10.0 && fabs(hsat - 0.1) <= sat && val >= fabs(hval - 0.1) ){
                countbeer++;
                // 画像中心付近のデータに重みをつける
                //countbeer2 += 1.0 - abs(i - half_width) / half_width;
                countbeer3 += 1.0 - sin(M_PI_2 * abs(i - half_width) / half_width);
            }else if(0.15 > sat && 0.7 < val){
                countbubble++;
                // 画像中心付近のデータに重みをつける
                //countbubble2 += 1.0 - abs(i - half_width) / half_width;
                countbubble3 += 1.0 - sin(M_PI_2 * abs(i - half_width) / half_width);
            }
        }
    }
    
    NSLog(@"hhue %lf hsat %lf hval %lf\n", hhue, hsat, hval);
    NSLog(@"beer %d bubble %d\n", countbeer, countbubble);
              
    //if(countbeer + countbubble == 0){
    //if(countbeer2 + countbubble2 == 0){
    if( countbeer3 + countbubble3 < 5000  // 計算に適した数の点数が得られていないとき
       || countbeer3 / countbubble3 < 0.5 // 比率があまりにも悪いときを排除
       || countbeer3 <= 500.0
       || countbubble3 <= 10.0){
        return -1;
    }
    
    //double compbeer = (countbeer / (double)(countbeer + countbubble)) * 100;
    //double compbeer2 = (countbeer2 / (double)(countbeer2 + countbubble2)) * 100;
    double compbeer3 = (countbeer3 / (double)(countbeer3 + countbubble3)) * 100;
    
    //NSLog(@"beer %d bubble %d score %lf\n", countbeer, countbubble, compbeer);
    //NSLog(@"beer %lf bubble %lf score %lf\n", countbeer2, countbubble2, compbeer2);
    NSLog(@"beer %lf bubble %lf score %lf\n", countbeer3, countbubble3, compbeer3);
    //NSLog(@"width %d height %d\n", rgbImage.cols, rgbImage.rows);
    
    //return std::max((int)((-1.0 / 9.0) * pow((compbeer - 70), 2.0) + 100), 0);
    //return std::max((int)((-1.0 / 9.0) * pow((compbeer2 - 70), 2.0) + 100), 0);
    return std::max((int)((-1.0 / 9.0) * pow((compbeer3 - 70), 2.0) + 100), 0);
}

// debug用関数
+(UIImage*)getProcessImage:(UIImage*)image
{
    cv::Mat rgbImage, dstImg, rotImg, rotImg2;
    UIImage *dstImage;
    
    CvSize2D32f size;
    size.width = 1080;
    size.height = 1920;
    
    UIImageToMat(image, rgbImage);
    
    /////
    /////
    /////
    /*
    // まずは、パターンマッチングで点数高いところを探してみる
    UIImage *bimg = [UIImage imageNamed:@"template.jpg"];
    cv::Mat beer_img, beer_scale_img;
    UIImageToMat(bimg, beer_img);
    
    // ビールの画像が小さいと問答無用でスコアが高くなるので、大きいスケールから順にスコアを計算する
    for (int i = 10; i > 0; i--) {
        double scale = i * 0.1;
        
        double scale_x = beer_img.cols * scale;
        double scale_y = beer_img.rows * scale;
        
        CvSize2D32f size;
        size.width = scale_x;
        size.height = scale_y;
        cv::resize(beer_img, beer_scale_img, size, cv::INTER_CUBIC);
        
        if (scale_x >= beer_scale_img.cols || scale_y >= beer_scale_img.rows) continue;
        
        //マッチング
        cv::Mat result_img;
        cv::matchTemplate(rgbImage, beer_scale_img, result_img, CV_TM_CCOEFF_NORMED);
        
        //スコア取得
        cv::Rect roi_rect(0, 0, beer_scale_img.cols, beer_scale_img.rows);
        cv::Point max_pt;
        double maxVal = -1.0;
        cv::minMaxLoc(result_img, NULL, &maxVal, NULL, &max_pt);
        
        if (maxVal >= 0) { //閾値0.55はだいたい良さそうな結果が出た値
            //サイズ設定
            roi_rect.x = max_pt.x;
            roi_rect.y = max_pt.y;
            
            //ポッキーの位置を矩形表示
            cv::rectangle(rgbImage, roi_rect, cv::Scalar(0,255,0), 2);
            break;
        }
    }*/
    
    cv::GaussianBlur(rgbImage, dstImg, cv::Size(51,51), 80, 80);
    cv::transpose(dstImg, rotImg);
    
    //cv::transpose(rgbImage, rotImg);
    cv::resize(rotImg, rotImg2, size, cv::INTER_CUBIC);
    /////
    /////
    /////
    
    dstImage = MatToUIImage(rotImg2); // debug
    
    return dstImage;
}

@end