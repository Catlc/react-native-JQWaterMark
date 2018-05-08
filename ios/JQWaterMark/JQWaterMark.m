//
//  JQWaterMark.m
//  JQWaterMark
//
//  Created by 李承 on 2018/5/4.
//  Copyright © 2018年 licheng. All rights reserved.
//

#import "JQWaterMark.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation JQWaterMark


RCT_EXPORT_MODULE(JQWaterMark);

RCT_EXPORT_METHOD(hiddenWaterMakr){
    
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        [self findSubView:window.layer];
        
    });
    
}

RCT_EXPORT_METHOD(markWithName:(NSString *)name info:(NSDictionary *)info) {
    
    RCTLogInfo(@"%@: %@", name, info);
    
    //    int horizontal_apace = 130;
    //    int vertical_space = 130;
    //    float cg_transform_rotation = -0.5;
    //    int mark_font = 20;
    //    NSString *mark_color = @"#FF0000";
    
    if (name == nil) {
        name = @"久其金建";
    }
    
    NSString *horizontal_apace = info[@"horizontal_apace"]==nil?@"130":info[@"horizontal_apace"];
    NSString *vertical_space = info[@"vertical_space"]==nil?@"130":info[@"vertical_space"];
    NSString *cg_transform_rotation = info[@"cg_transform_rotation"]==nil?@"-0.5":info[@"cg_transform_rotation"];
    NSString *mark_font = info[@"mark_font"]==nil?@"20":info[@"mark_font"];
    NSString *mark_color = info[@"mark_color"]==nil?@"#FF0000":info[@"mark_color"];
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /*
             // UI更新代码
             UIViewController *controller = (UIViewController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
             
             UIGraphicsBeginImageContextWithOptions(CGSizeMake(controller.view.frame.size.width, controller.view.frame.size.height), NO, 1.0);
             UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
             UIGraphicsEndImageContext();
             
             UIImage *image = [self getWaterMarkImage:blank andTitle:@"久其金建" andMarkFont:[UIFont boldSystemFontOfSize:20] andMarkColor:[UIColor colorWithRed:0.97 green:0.81 blue:0.80 alpha:0.80]];
             controller.view.subviews[0].layer.contents = (id) image.CGImage;
             //          controller.view.subviews[0].layer.backgroundColor = [UIColor clearColor].CGColor;// 如果需要背景透明加上下面这句
             */
            
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            
            [self findSubView:window.layer];
            
            //create a text layer
            CATextLayer *textLayer = [CATextLayer layer];
            
            //            textLayer.frame = window.bounds;
            textLayer.frame = CGRectMake( - window.bounds.size.width/2, - window.bounds.size.height/2, window.bounds.size.width*2, window.bounds.size.height*2);
            
            //textLayer.position = CGPointMake(160, 410);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
            
            [window.layer addSublayer:textLayer];
            
            textLayer.backgroundColor=[UIColor clearColor].CGColor; //[UIColor redColor].CGColor;
            
            textLayer.foregroundColor = [self colorWithHexString:mark_color].CGColor;
            
            textLayer.wrapped = YES;
            textLayer.opacity = 0.18;
            textLayer.contentsScale = [UIScreen mainScreen].scale;
            textLayer.alignmentMode = kCAAlignmentCenter;
            textLayer.allowsFontSubpixelQuantization = YES;
            UIFont *font = [UIFont systemFontOfSize:[mark_font intValue]];
            
            CFStringRef fontName = (__bridge CFStringRef)font.fontName;
            CGFontRef fontRef = CGFontCreateWithFontName(fontName);
            textLayer.font = fontRef;
            textLayer.fontSize = font.pointSize;
            CGFontRelease(fontRef);
            
            textLayer.transform = CATransform3DMakeRotation([cg_transform_rotation floatValue], 0.0, 0.0, 1.0);
            
            //原始image的宽高
            CGFloat viewWidth = kScreenWidth*2;
            CGFloat viewHeight = kScreenHeight*2;
            
            
            //文字的属性
            NSDictionary *attr = @{
                                   //设置字体大小
                                   NSFontAttributeName:[UIFont boldSystemFontOfSize:[mark_font intValue]],
                                   //设置文字颜色
                                   NSForegroundColorAttributeName :[self colorWithHexString:mark_color],
                                   
                                   };
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:name attributes:attr];
            //绘制文字的宽高
            CGFloat strWidth = attrStr.size.width;
            CGFloat strHeight = attrStr.size.height;
            
            //计算需要绘制的列数和行数
            int horCount = viewWidth / (strWidth + [horizontal_apace intValue]) +1;
            int verCount = viewHeight / (strHeight + [vertical_space intValue]) +1;
            
            float q = 6;
            float blank = ([horizontal_apace intValue]/q);//一个空格 = 4px
            
            float p = 31;
            float num = ([vertical_space intValue]/p);//一个空格 = 31px
            
            
            NSString *spacing = [self getStr:@" " andmultiple:roundf(blank)];
            NSString *type = [self getStr:@"\n" andmultiple:roundf(num)+1];
            
            NSString *markStr = @"";
            
            for (int i = 0; i < horCount * verCount; i++) {
                
                NSString* mark = name;
                
                if (i % horCount == 0) {
                    
                    markStr =[markStr stringByAppendingString:type];
                    
                }
                markStr =  [markStr stringByAppendingString:mark];
                markStr =  [markStr stringByAppendingString:spacing];
                
                
            }
            NSLog(@"mark is %@",markStr);
            
            
            
            textLayer.string = markStr;
            
        });
        
    });
    
    
    
}
-(void)findSubView:(CALayer*)layer
{
    for (CALayer* subLayer in layer.sublayers)
    {
        
        if ([subLayer isKindOfClass:[CATextLayer class]]) {
            [subLayer removeFromSuperlayer];
        }
        [self findSubView:subLayer];
    }
}
- (NSString *)getStr:(NSString *)str andmultiple:(NSInteger)num
{
    NSString *markStr = @"";
    
    for (int i = 0; i < num; i++) {
        NSString* mark = str;
        markStr =  [markStr stringByAppendingString:mark];
        
    }
    return markStr;
}

- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    if ([stringToConvert hasPrefix:@"#"])
    {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    
    return [self colorWithRGBHex:hexNum];
}
- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}



@end
