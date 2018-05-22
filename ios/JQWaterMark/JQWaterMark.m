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
        _markView.hidden = YES;
    });
    
}
RCT_EXPORT_METHOD(showWaterMakr){
    
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _markView.hidden = NO;
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
            if (_markView == nil) {
                // UI更新代码
                UIViewController *controller = (UIViewController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
                
                UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kScreenHeight-44-64), NO, [UIScreen mainScreen].scale);
                UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                _markView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-40-64)];
                UIImage *image = [self getWaterMarkImage:blank andTitle:name andMarkFont:[UIFont systemFontOfSize:[mark_font integerValue]] andMarkColor:[self colorWithHexString:mark_color] andHorizontalSpace:[horizontal_apace floatValue] andverticalSpace:[vertical_space floatValue] andTransformRotation:[cg_transform_rotation floatValue]];
                _markView.image = image;
                
                [controller.view addSubview:_markView];
            }
            //          controller.view.subviews[0].layer.backgroundColor = [UIColor clearColor].CGColor;// 如果需要背景透明加上下面这句
            
            /*
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
             */
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
                           alpha:.1f];
}

#define HORIZONTAL_SPACE 130//水平间距
#define VERTICAL_SPACE 150//竖直间距
#define CG_TRANSFORM_ROTATION (M_PI_2 / 3)//旋转角度(正旋45度 || 反旋45度)
/**
 根据目标图片制作一个盖水印的图片
 
 @param originalImage 源图片
 @param title 水印文字
 @param markFont 水印文字font(如果不传默认为23)
 @param markColor 水印文字颜色(如果不传递默认为源图片的对比色)
 @return 返回盖水印的图片
 */
- (UIImage *)getWaterMarkImage: (UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor andHorizontalSpace:(float)horizontal_apace andverticalSpace:(float)vertical_space andTransformRotation:(float)transform_rotation{
    
    UIFont *font = markFont;
    if (font == nil) {
        font = [UIFont systemFontOfSize:14];
    }
    UIColor *color = markColor;
    if (color == nil) {
        color = [self mostColor:originalImage];
    }
    //原始image的宽高
    CGFloat viewWidth = originalImage.size.width;
    CGFloat viewHeight = originalImage.size.height;
    //为了防止图片失真，绘制区域宽高和原始图片宽高一样
    //    UIGraphicsBeginImageContext(CGSizeMake(viewWidth, viewHeight));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(viewWidth, viewHeight), NO, [UIScreen mainScreen].scale);
    //先将原始image绘制上
    [originalImage drawInRect:CGRectMake(0, 0, viewWidth, viewHeight)];
    //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
    CGFloat sqrtLength = sqrt(viewWidth*viewWidth + viewHeight*viewHeight);
    //文字的属性
    NSDictionary *attr = @{
                           //设置字体大小
                           NSFontAttributeName: font,
                           //设置文字颜色
                           NSForegroundColorAttributeName :color,
                           };
    NSString* mark = title;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:mark attributes:attr];
    //绘制文字的宽高
    CGFloat strWidth = attrStr.size.width;
    CGFloat strHeight = attrStr.size.height;
    
    //开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(viewWidth/2, viewHeight/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(transform_rotation));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-viewWidth/2, -viewHeight/2));
    
    //计算需要绘制的列数和行数
    int horCount = sqrtLength / (strWidth + HORIZONTAL_SPACE) + 1;
    int verCount = sqrtLength / (strHeight + VERTICAL_SPACE) + 1;
    
    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength-viewWidth)/2;
    CGFloat orignY = -(sqrtLength-viewHeight)/2;
    
    //在每列绘制时X坐标叠加
    CGFloat tempOrignX = orignX;
    //在每行绘制时Y坐标叠加
    CGFloat tempOrignY = orignY;
    for (int i = 0; i < horCount * verCount; i++) {
        [mark drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attr];
        if (i % horCount == 0 && i != 0) {
            tempOrignX = orignX;
            tempOrignY += (strHeight + VERTICAL_SPACE);
        }else{
            tempOrignX += (strWidth + HORIZONTAL_SPACE);
        }
    }
    //根据上下文制作成图片
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRestoreGState(context);
    return finalImg;
}

//根据图片获取图片的主色调
-(UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

@end


