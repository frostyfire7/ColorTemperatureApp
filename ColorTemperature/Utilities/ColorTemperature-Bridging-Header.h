//
//  ColorTemperature-Bridging-Header.h
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

#ifndef ColorTemperature_Bridging_Header_h
#define ColorTemperature_Bridging_Header_h

#ifdef __cplusplus
#define CV_SUPPRESS_DEPRECATED_WARN
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#endif

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OpenCVBridge.h"

#endif
