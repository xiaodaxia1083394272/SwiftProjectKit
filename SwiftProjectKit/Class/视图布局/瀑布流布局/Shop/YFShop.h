//
//  YFShop.h
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/22.
//  Copyright © 2018年 HMRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFShop : NSObject

/** 宽度 */
@property (nonatomic, assign) CGFloat w;
/** 高度 */
@property (nonatomic, assign) CGFloat h;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 图片的url地址 */
@property (nonatomic, copy) NSString *img;

@end
