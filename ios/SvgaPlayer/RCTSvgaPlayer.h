//
//  RTCSvgaPlayer.h
//  AwesomeProject
//
//  Created by 闫瑞锋 on 2025/6/15.
//
#import <React/RCTViewComponentView.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTSvgaPlayer: RCTViewComponentView <UIGestureRecognizerDelegate>

- (instancetype)initWithBridge:(RCTBridge *)bridge;

@property(nonatomic, strong) NSString *source;
@property(nonatomic) float toFrame;
@property(nonatomic) float toPercentage;

@property(nonatomic, strong) NSString *currentState;


@end

NS_ASSUME_NONNULL_END
