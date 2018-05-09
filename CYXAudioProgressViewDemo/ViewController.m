//
//  ViewController.m
//  CYXAudioProgressViewDemo
//
//  Created by 超级腕电商 on 2018/5/9.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "ViewController.h"
#import "CYXAudioProgressView.h"
@interface ViewController ()
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) CYXAudioProgressView *loopProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.loopProgressView.frame =CGRectMake(0, 100, self.view.frame.size.width, 150);
    [self.loopProgressView initLayers];
    [self.view addSubview:self.loopProgressView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loopProgressView setAnimationPersentage:0.5];
    });
    
    self.slider.frame = CGRectMake(30, self.view.frame.size.height-60, self.view.frame.size.width-30*2, 20);
    [self.view addSubview:self.slider];
}
#pragma mark Actions
-(void)sliderValueChanged:(UISlider *)slider{
    self.loopProgressView.persentage = slider.value;
}

#pragma mark ---G
-(CYXAudioProgressView*)loopProgressView{
    if(!_loopProgressView){
        _loopProgressView = [[CYXAudioProgressView alloc] init];
        
    }
    return _loopProgressView;
}
-(UISlider*)slider{
    if(!_slider){
        _slider = [[UISlider alloc] init];
        _slider.tintColor = [UIColor blueColor];
        _slider.value = 0.5;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}


@end
