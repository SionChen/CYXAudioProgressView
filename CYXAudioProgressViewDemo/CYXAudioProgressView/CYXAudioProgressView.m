//
//  CYXAudioProgressView.m
//  CYXAudioProgressViewDemo
//
//  Created by 超级腕电商 on 2018/5/9.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "CYXAudioProgressView.h"
/*条条间隙*/
#define kDrawMargin 4
#define kDrawLineWidth 8
/*差值*/
#define differenceValue 51
@interface CYXAudioProgressView ()<CAAnimationDelegate>

/*条条 灰色路径*/
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
/*背景黄色*/
@property (nonatomic,strong) CAShapeLayer *backColorLayer;
@property (nonatomic,strong) CAShapeLayer *maskLayer;
@end
@implementation CYXAudioProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self.layer addSublayer:self.shapeLayer];
        [self.layer addSublayer:self.backColorLayer];
        self.persentage = 0.0;
    }
    return self;
}
#pragma mark ---Layers
/**
 初始化layer 在完成frame赋值后调用一下
 */
-(void)initLayers{
    [self initStrokeLayer];
    [self setBackColorLayer];
}
/*灰色路径*/
-(void)initStrokeLayer{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat maxWidth = self.frame.size.width;
    CGFloat drawHeight = self.frame.size.height;
    CGFloat x = 0.0;
    while (x+kDrawLineWidth<=maxWidth) {
        CGFloat random =5+ arc4random()%differenceValue;//差值在1-50 之间取
        NSLog(@"%f",random);
        [path moveToPoint:CGPointMake(x-kDrawLineWidth/2, random)];
        [path addLineToPoint:CGPointMake(x-kDrawLineWidth/2, drawHeight-random)];
        x+=kDrawLineWidth;
        x+=kDrawMargin;
    }
    self.shapeLayer.path = path.CGPath;
    self.backColorLayer.path = path.CGPath;
}
/*设置背景layer*/
-(void)setBackColorLayer{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    self.maskLayer.frame = self.bounds;
    self.maskLayer.lineWidth = self.frame.size.width;
    self.maskLayer.path= path.CGPath;
    self.backColorLayer.mask = self.maskLayer;
}

-(void)setAnimationPersentage:(CGFloat)persentage{
    CGFloat startPersentage = self.persentage;
    [self setPersentage:persentage];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:startPersentage];
    pathAnimation.toValue = [NSNumber numberWithFloat:persentage];
    pathAnimation.autoreverses = NO;
    pathAnimation.delegate = self;
    [self.maskLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}
/**
 *  在修改百分比的时候，修改彩色遮罩的大小
 *
 *  @param persentage 百分比
 */
- (void)setPersentage:(CGFloat)persentage {
    
    _persentage = persentage;
    self.maskLayer.strokeEnd = persentage;
}
#pragma mark ---G
-(CAShapeLayer*)shapeLayer{
    if(!_shapeLayer){
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.lineWidth = kDrawLineWidth;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
        _shapeLayer.lineCap = kCALineCapRound; // 设置线为圆角
        _shapeLayer.strokeColor = [UIColor grayColor].CGColor; // 路径颜色颜色
    }
    return _shapeLayer;
}
-(CAShapeLayer*)backColorLayer{
    if(!_backColorLayer){
        _backColorLayer = [[CAShapeLayer alloc] init];
        _backColorLayer.lineWidth = kDrawLineWidth;
        _backColorLayer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
        _backColorLayer.lineCap = kCALineCapRound; // 设置线为圆角
        _backColorLayer.strokeColor = [UIColor yellowColor].CGColor; // 路径颜色颜色
    }
    return _backColorLayer;
}
-(CAShapeLayer*)maskLayer{
    if(!_maskLayer){
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.strokeColor = [UIColor yellowColor].CGColor; // 路径颜色颜色
    }
    return _maskLayer;
}
@end
