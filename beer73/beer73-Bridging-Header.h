//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScoreCalculator : NSObject
+(int)calcScore:(const UIImage*)image;
+(UIImage*)getProcessImage:(UIImage*)image;
@end
