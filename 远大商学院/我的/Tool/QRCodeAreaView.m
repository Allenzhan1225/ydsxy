//
//  QRCodeAreaView.m
//  shikeApp
//
//  Created by 淘发现4 on 16/1/7.
//  Copyright © 2016年 淘发现1. All rights reserved.
//

#import "QRCodeAreaView.h"
#import "UIViewExt.h"

@interface QRCodeAreaView()

/**
 *  记录当前线条绘制的位置
 */
@property (nonatomic,assign) CGPoint position;

/**
 *  定时器
 */
@property (nonatomic,strong)NSTimer  *timer;

@end

@implementation QRCodeAreaView

- (void)drawRect:(CGRect)rect {
    CGPoint newPosition = self.position;
   
    static  BOOL flag = NO;
    //判断y到达底部，从新开始下降
    if (newPosition.y > rect.size.height) {
        newPosition.y = rect.size.height;
        flag = YES;
    }
    
    if (newPosition.y < 2) {
        newPosition.y = 1;
        flag = NO;
    }
    
    if (flag == NO) {
         newPosition.y += 1;
    }else{
        newPosition.y -= 1;
    }
    
    //重新赋值position
    self.position = newPosition;
    
    // 绘制图片
    //QRCode_ScanLine//line
    CGSize size = CGSizeMake(self.width, 3);
    UIImage *image = [UIImage imageNamed:@"QRCode_ScanLine"];
    image =  [self scaleToSize:image size:size];

    [image drawAtPoint:self.position];
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize
 {
         // 创建一个bitmap的context
    
         // 并把它设置成为当前正在使用的context
    
         UIGraphicsBeginImageContext(newsize);
    
         // 绘制改变大小的图片
    
        [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
         // 从当前context中创建一个改变大小后的图片
    
         UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
         // 使当前的context出堆栈
    
         UIGraphicsEndImageContext();
    
         // 返回新的改变大小后的图片
    
        return scaledImage;
     }

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //QRCode_ScanBox //QRCode_ScanLine
        UIImageView *areaView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QRCode_ScanBox"]];
        areaView.width = self.width;
        areaView.height = self.height;
        [self addSubview:areaView];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    }
    
    return self;
}

-(void)startAnimaion{
    [self.timer setFireDate:[NSDate date]];
}

-(void)stopAnimaion{
    [self.timer setFireDate:[NSDate distantFuture]];
}

@end
