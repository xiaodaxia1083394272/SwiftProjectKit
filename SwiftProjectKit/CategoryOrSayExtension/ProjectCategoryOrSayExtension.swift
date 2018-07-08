//
//  ProjectCategoryOrSayExtension.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/5/27.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import Foundation
import UIKit
//MARK:UIImage扩展
extension UIImage{
    func applyBlurWithRadius(blurRadius:CGFloat,tintColor:UIColor,saturationDeltaFactor:CGFloat,maskImage:UIImage?)-> UIImage?{
        // Check pre-conditions.
        if (self.size.width < 1 || self.size.height < 1) {
//            NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
            return nil;
        }
        if (self.cgImage == nil) {
//            NSLog (@"*** error: image must be backed by a CGImage: %@", self);
            return nil;
        }
        if ((maskImage != nil) && maskImage?.cgImage == nil) {
//            NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
            return nil;
        }
        
        let imageRect = CGRect(origin:.zero, size: self.size)
        let effectImage : UIImage  = self
        //pss_吐槽，这一段的数字算法，看得真的有一点点蛋疼，而且这一段魔性的转换也不知道行不行
        let hasBlur : Bool  = Float(blurRadius) > Float.ulpOfOne
        let hasSaturationChange : Bool = Float(fabs(saturationDeltaFactor - 1)) > Float.ulpOfOne
        /*
        if (hasBlur || hasSaturationChange) {
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
            let effectInContext:CGContext!  = UIGraphicsGetCurrentContext()
            
            CGContextScaleCTM(effectInContext, 1.0, -1.0);
            CGContext.scaleBy(effectInContext)
            CGContextTranslateCTM(effectInContext, 0, -self.size.height);
            CGContextDrawImage(effectInContext, imageRect, self.CGImage);
            
            vImage_Buffer effectInBuffer;
            effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
            effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
            effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
            effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
            
            UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
            CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
            vImage_Buffer effectOutBuffer;
            effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
            effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
            effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
            effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
            
            if (hasBlur) {
                // A description of how to compute the box kernel width from the Gaussian
                // radius (aka standard deviation) appears in the SVG spec:
                // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
                //
                // For larger values of 's' (s >= 2.0), an approximation can be used: Three
                // successive box-blurs build a piece-wise quadratic convolution kernel, which
                // approximates the Gaussian kernel to within roughly 3%.
                //
                // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
                //
                // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
                //
                CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
                NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
                if (radius % 2 != 1) {
                    radius += 1; // force radius to be odd so that the three box-blur methodology works.
                }
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
                vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            }
            BOOL effectImageBuffersAreSwapped = NO;
            if (hasSaturationChange) {
                CGFloat s = saturationDeltaFactor;
                CGFloat floatingPointSaturationMatrix[] = {
                    0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                    0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                    0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                    0,                    0,                    0,  1,
                };
                const int32_t divisor = 256;
                NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
                int16_t saturationMatrix[matrixSize];
                for (NSUInteger i = 0; i < matrixSize; ++i) {
                    saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
                }
                if (hasBlur) {
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                    effectImageBuffersAreSwapped = YES;
                }
                else {
                    vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                }
            }
            if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        // Set up output context.
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef outputContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(outputContext, 1.0, -1.0);
        CGContextTranslateCTM(outputContext, 0, -self.size.height);
        
        // Draw base image.
        CGContextDrawImage(outputContext, imageRect, self.CGImage);
        
        // Draw effect image.
        if (hasBlur) {
            CGContextSaveGState(outputContext);
            if (maskImage) {
                CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
            }
            CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
            CGContextRestoreGState(outputContext);
        }
        
        // Add in color tint.
        if (tintColor) {
            CGContextSaveGState(outputContext);
            CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
            CGContextFillRect(outputContext, imageRect);
            CGContextRestoreGState(outputContext);
        }
        
        // Output image is ready.
        UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return outputImage;*/
            return nil //pss_todo
    }
}
//MARK:UIImageView扩展
extension UIImageView{
    
    // 1.定义一个闭包类型
    //格式: typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
    /*pss_todo
    typealias YFBlurredImageCompletionBlock = () -> Void
    
    func setImageToBlur(image:UIImage,blurRadius:CGFloat,
                        completionBlock:@escaping YFBlurredImageCompletionBlock)
    {
        let blurredImage:UIImage!
        DispatchQueue.global().async {
            print("async do something\(Thread.current)")
            DispatchQueue.main.async {
                self.image = blurredImage
                if completionBlock != nil
                {
                    completionBlock()
                }
            }
        }
    }*/

}
//MARK:颜色扩展（分类）
extension UIColor {
    //颜色16进制
    
    //MARK:1>16进制颜色  "#00FF07"
    public class func hexCOLOR(_ hexString: String) -> UIColor{

        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        //swift4.0字符串的长度直接用count就行了
        if cString.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0X") {
//            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
            //直接转成NSString来截取从开始到2位会简单点
              cString =  (cString as NSString).substring(to:2)
        }
        if cString.hasPrefix("#") {
//            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
            cString =  (cString as NSString).substring(to:1)

        }
        if cString.count != 6 {
            return UIColor.black
        }

        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)

        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        //下面这个方法ios10以上才有
//        return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    }
    //MARK:2>返回随机颜色
    //pss_吐槽，方法分类方法，实例方法，没想到swift中属性也分类属性
    open class var randomColor:UIColor{
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

//MARK:字符串扩展（分类）
extension NSString {
    /*计算文字高度*/
//    - (CGFloat)heightWithFont:(UIFont *)font maxSize:(CGSize)maxSize
//    {
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
//    }
//    func heightWithFont(font : UIFont , maxSize : CGSize) ->CGFloat{
//
//        return NSString.boundingRect(<#T##NSString#>)
//    }
    
//    func getTextHeigh(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
//
//        let normalText: NSString = textStr as NSString
//        let size = CGSize(width: width, height: 1000)
//        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
//        let stringSize = normalText.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as? [String : Any], context:nil).size
//        return stringSize.height
//    }
    
}














