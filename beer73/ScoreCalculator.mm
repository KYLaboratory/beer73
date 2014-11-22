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

+(int)calcScore:(UIImage*)image
{
    
    
    
    UIImage* correctImage = image;

    
    // UIImage -> cv::Mat
    cv::Mat mat;
    
    UIImageToMat(correctImage, mat);
    
    
    // （1）座標(0, 100)の画素値を取得する
    // ※atに渡すパラメーターは(y, x)の順である点に注意
    // ※Matのデータは（RGB表色系の場合）BGRの順に並んでいる点に注意
    double *sikisaiH=(double *)malloc(sizeof(double)*mat.rows);
    double *sikisaiS=(double *)malloc(sizeof(double)*mat.rows);
    double *sikisaiV=(double *)malloc(sizeof(double)*mat.rows);
    int hightcheck = (mat.cols)/2;
    double Hue,Saturation,Value;
    double aveH = 0;
    double aveS = 0;
    double aveV = 0;
    int countbeer=0;
    int countbubble=0;
    for(int j=0;j<mat.rows;j++){
        cv::Vec3b intensity = mat.at<cv::Vec3b>(j, hightcheck);
        uchar red = intensity.val[0];
        uchar green = intensity.val[1];
        uchar blue = intensity.val[2];
        
        int max;
        int min;
            
        // （2）画素値を表示する
        
        if(red<green){
            max=green;
            min=red;
            if(green<blue){
                max=blue;
            }
            else{
                if(blue<red){
                    min=blue;
                }
            }
        }
        else{
            max=red;
            min=green;
            if(red<blue){
                max=blue;
            }
            else{
                if(blue<green){
                    min=blue;
                }
            }
        }
        
        if(max==min){
            Hue=0;
        }
        else if(min==blue){
            Hue=60*((double)(green-red)/(max-min))+60;
        }
        else if(min==red){
            Hue=60*((double)(blue-green)/(max-min))+180;
        }
        else{
            Hue=60*((double)(red-blue)/(max-min))+300;
        }
        Saturation=(max-min)/255.0;
        Value=max/255.0;
        
        sikisaiH[j]=Hue;
        sikisaiS[j]=Saturation;
        sikisaiV[j]=Value;
        aveH=aveH+Hue;
        aveS=aveS+Saturation;
        aveV=aveV+Value;
        
    }
    aveH=aveH/mat.rows;
    aveS=aveS/mat.rows;
    aveV=aveV/mat.rows;
    
    
    for(int i=0;i<mat.rows;i++){
        if(20<=sikisaiH[i] && sikisaiH[i]<=60 && sikisaiS[i]>=0.35 && sikisaiV[i]>=0.35){
            countbeer=countbeer+1;
        }
        else if(0.15>sikisaiS[i] && 0.5<sikisaiV[i]){
            countbubble=countbubble+1;
        }
    }
    free(sikisaiS);
    free(sikisaiH);
    free(sikisaiV);
    
    if(countbeer+countbubble==0){
        return -1;
    }
    
    double compbeer=(countbeer/(double)(countbeer+countbubble))*100;
    
    if(compbeer>=40){
        return (-1/9.0)*(compbeer-70)*(compbeer-70)+100;
    }
    else{
        return 0;
    }
    
    
    

}

@end