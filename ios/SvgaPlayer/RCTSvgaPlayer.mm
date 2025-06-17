
#import "RCTSvgaPlayer.h"

#import <react/renderer/components/RTNSvgaPlayerSpec/ComponentDescriptors.h>
#import <react/renderer/components/RTNSvgaPlayerSpec/EventEmitters.h>
#import <react/renderer/components/RTNSvgaPlayerSpec/Props.h>
#import <react/renderer/components/RTNSvgaPlayerSpec/RCTComponentViewHelpers.h>

#import "SVGAPlayer.h"
#import "SVGAParser.h"

using namespace facebook::react;

@interface RCTSvgaPlayer()  <RCTSvgaPlayerViewViewProtocol,SVGAPlayerDelegate>
@property(nonatomic, copy) NSString *currentState;
@end

@implementation RCTSvgaPlayer
  SVGAPlayer *aPlayer;
  
  -(instancetype)init{
    if(self = [super init]) {
      aPlayer = [[SVGAPlayer alloc] init];
      aPlayer.delegate = self;
      aPlayer.clipsToBounds = NO;
      aPlayer.contentMode = UIViewContentModeScaleAspectFit;
      [self addSubview:aPlayer];
    }
    return self;
  }

-(void)layoutSubviews
{
  [super layoutSubviews];
  aPlayer.frame = self.bounds;
}

-(void)updateProps:(const facebook::react::Props::Shared &)props oldProps:(const facebook::react::Props::Shared &)oldProps{
  const auto &oldViewProps = *std::static_pointer_cast<SvgaPlayerViewProps const>(_props);
   const auto &newViewProps = *std::static_pointer_cast<SvgaPlayerViewProps const>(props);
  if (oldViewProps.source != newViewProps.source) {
     NSString *urlString = [NSString stringWithCString:newViewProps.source.c_str() encoding:NSUTF8StringEncoding];
    [self loadWithSource:urlString];
  }else if(oldViewProps.currentState!=newViewProps.currentState){
    NSString *currentState = [NSString stringWithCString:newViewProps.currentState.c_str() encoding:NSUTF8StringEncoding];
    self.currentState = currentState;
    if ([currentState isEqualToString:@"start"]) {
               [aPlayer startAnimation];
           } else if ([currentState isEqualToString:@"pause"]) {
               [aPlayer pauseAnimation];
           } else if ([currentState isEqualToString:@"stop"]) {
               [aPlayer stopAnimation];
           } else if ([currentState isEqualToString:@"clear"]) {
               [aPlayer stopAnimation];
               [aPlayer clear];
           }
  }else if(oldViewProps.toFrame!=newViewProps.toFrame){
    float toFrame = newViewProps.toFrame;
    if (toFrame < 0) {
           return;
       }
       [aPlayer stepToFrame:toFrame andPlay:[self.currentState isEqualToString:@"play"]];
  }else if(oldViewProps.toPercentage!=newViewProps.toPercentage){
    float toPercent = newViewProps.toPercentage;
    if (toPercent < 0) {
           return;
       }
       [aPlayer stepToPercentage:toPercent  andPlay:[self.currentState isEqualToString:@"play"]];
  }
  [super updateProps:props oldProps:oldProps];
}
  
  - (void)loadWithSource:(NSString *)source {
      SVGAParser *parser = [[SVGAParser alloc] init];
      if ([source hasPrefix:@"http"] || [source hasPrefix:@"https"]) {
          [parser parseWithURL:[NSURL URLWithString:source]
               completionBlock:^(SVGAVideoEntity *_Nullable videoItem) {
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                   [aPlayer setVideoItem:videoItem];
                   [aPlayer startAnimation];
                 }];
               }
                  failureBlock:nil];
      } else {
          NSString *localPath = [[NSBundle mainBundle] pathForResource:source ofType:@"svga"];
          if (localPath != nil) {
              [parser parseWithData:[NSData dataWithContentsOfFile:localPath]
                           cacheKey:source
                    completionBlock:^(SVGAVideoEntity *_Nonnull videoItem) {
                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [aPlayer setVideoItem:videoItem];
                        [aPlayer startAnimation];
                      }];
                    }
                       failureBlock:nil];
          }
      }
  }
  
  - (void)load:(nonnull NSString *)source {
      [self loadWithSource:source];
  }
  
  - (void)pauseAnimation {
    
    [aPlayer pauseAnimation];
  }
  
  - (void)startAnimation {
    [aPlayer startAnimation];
  }
  
  - (void)stopAnimation {
    [aPlayer stopAnimation];
  }
// Event emitter convenience method
- (const SvgaPlayerViewEventEmitter &)eventEmitter
{
  return static_cast<const SvgaPlayerViewEventEmitter &>(*_eventEmitter);
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<SvgaPlayerViewComponentDescriptor>();
}

  - (void)handleCommand:(nonnull const NSString *)commandName args:(nonnull const NSArray *)args {
    if([commandName isEqualToString:@"load"]){
      [self load:args[0]];
    }else if([commandName isEqualToString:@"startAnimation"]){
      [self startAnimation];
    }else if([commandName isEqualToString:@"pauseAnimation"]){
      [self pauseAnimation];
    }else if([commandName isEqualToString:@"stopAnimation"]){
      [self stopAnimation];
    }
  }

@end
