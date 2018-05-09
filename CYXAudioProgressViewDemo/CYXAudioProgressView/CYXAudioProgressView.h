//
//  CYXAudioProgressView.h
//  CYXAudioProgressViewDemo
//
//  Created by 超级腕电商 on 2018/5/9.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYXAudioProgressView : UIView
//无动画设置 进度
@property (assign, nonatomic) CGFloat persentage;
//有动画设置 进度 0~1
-(void)setAnimationPersentage:(CGFloat)persentage;
/**
 初始化layer 在完成frame赋值后调用一下
 */
-(void)initLayers;
@end
