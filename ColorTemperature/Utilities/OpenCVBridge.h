//
//  OpenCVBridge.h
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVBridge : NSObject

+ (UIImage *)adjustColorTemperature:(UIImage *)inputImage temperature:(double)temperature;

@end
