//
//  OpenCVBridge.mm
//  ColorTemperature
//
//  Created by Julius Adetya on 05/03/25.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <UIKit/UIKit.h>

@interface OpenCVBridge : NSObject
+ (UIImage *)adjustColorTemperature:(UIImage *)inputImage temperature:(double)temperature;
@end

@implementation OpenCVBridge

// Helper function to convert UIImage to cv::Mat
cv::Mat UIImageToMat(UIImage *image) {
    CGImageRef imageRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imageRef);
    CGFloat height = CGImageGetHeight(imageRef);
    
    cv::Mat mat(height, width, CV_8UC4);
    CGContextRef contextRef = CGBitmapContextCreate(mat.data, width, height, 8, mat.step, CGImageGetColorSpace(imageRef), kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(contextRef);

    // Fix image orientation
    switch (image.imageOrientation) {
        case UIImageOrientationUp:
            break;
        case UIImageOrientationDown:
            cv::rotate(mat, mat, cv::ROTATE_180);
            break;
        case UIImageOrientationLeft:
            cv::rotate(mat, mat, cv::ROTATE_90_COUNTERCLOCKWISE);
            break;
        case UIImageOrientationRight:
            cv::rotate(mat, mat, cv::ROTATE_90_CLOCKWISE);
            break;
        case UIImageOrientationUpMirrored:
            cv::flip(mat, mat, 1);
            break;
        case UIImageOrientationDownMirrored:
            cv::flip(mat, mat, 1);
            cv::rotate(mat, mat, cv::ROTATE_180);
            break;
        case UIImageOrientationLeftMirrored:
            cv::flip(mat, mat, 1);
            cv::rotate(mat, mat, cv::ROTATE_90_COUNTERCLOCKWISE);
            break;
        case UIImageOrientationRightMirrored:
            cv::flip(mat, mat, 1);
            cv::rotate(mat, mat, cv::ROTATE_90_CLOCKWISE);
            break;
    }

    cv::cvtColor(mat, mat, cv::COLOR_RGBA2BGR);
    return mat;
}

// Helper function to convert cv::Mat to UIImage
UIImage *MatToUIImage(const cv::Mat &mat) {
    cv::Mat rgbMat;
    cv::cvtColor(mat, rgbMat, cv::COLOR_BGR2RGBA);
    
    NSData *data = [NSData dataWithBytes:rgbMat.data length:rgbMat.elemSize() * rgbMat.total()];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate((void *)data.bytes, rgbMat.cols, rgbMat.rows, 8, rgbMat.step, colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(imageRef);
    
    return [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
//    return image;
}

+ (UIImage *)adjustColorTemperature:(UIImage *)inputImage temperature:(double)temperature {
    cv::Mat mat = UIImageToMat(inputImage);
    
    // Split channels
    std::vector<cv::Mat> channels;
    cv::split(mat, channels);
    
    double scale = temperature / 100.0; // Normalize adjustment value
    
    if (scale > 0) {
        // Warmer: Increase red, decrease blue
        channels[2] = channels[2] + scale * 50; // Red channel
        channels[0] = channels[0] - scale * 30; // Blue channel
    } else {
        // Cooler: Increase blue, decrease red
        channels[0] = channels[0] - scale * 50; // Blue channel
        channels[2] = channels[2] + scale * 30; // Red channel
    }
    
    cv::merge(channels, mat);
    
    return MatToUIImage(mat);
}
@end
