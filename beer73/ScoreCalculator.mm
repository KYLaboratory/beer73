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
    cv::Mat rgbImage;
    UIImageToMat(image, rgbImage);
    
    cv::Mat hsvImage;
    cv::cvtColor(rgbImage, hsvImage, CV_RGB2HSV);
    
    const int centerCol = (hsvImage.cols) / 2;
    cv::Mat centerImage = hsvImage.col(centerCol);
    
    int countbeer = 0;
    int countbubble = 0;
    for(int i = 0; i < centerImage.rows; i++){
        const double hue = centerImage.data[i * centerImage.step + 0] * 2.0;
        const double sat = centerImage.data[i * centerImage.step + 1] / 255.0;
        const double val = centerImage.data[i * centerImage.step + 2] / 255.0;
        
        if(20.0 <= hue && hue <= 60.0 && sat >= 0.35 && val >= 0.35){
            countbeer++;
        }
        else if(0.15 > sat && 0.5 < val){
            countbubble++;
        }
    }
    
    if(countbeer + countbubble == 0){
        return -1;
    }
    
    const double compbeer = (countbeer / (double)(countbeer + countbubble)) * 100;
    
    return std::max((int)((-1.0 / 9.0) * pow((compbeer - 70), 2.0) + 100), 0);
}
//test

@end