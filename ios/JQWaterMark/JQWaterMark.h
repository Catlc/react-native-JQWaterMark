//
//  JQWaterMark.h
//  JQWaterMark
//
//  Created by 李承 on 2018/5/4.
//  Copyright © 2018年 licheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>

@interface JQWaterMark : NSObject<RCTBridgeModule>

@property(nonatomic,strong)UIImageView *markView;

@end
