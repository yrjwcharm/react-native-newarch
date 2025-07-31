#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTViewManager.h>
#import "RCTSvgaPlayer.h"

@interface RCTSvgaPlayerManager : RCTViewManager
@end

@implementation RCTSvgaPlayerManager
// 这里导出的名字要和 HostComponent导出的组件名字一致
RCT_EXPORT_MODULE(RNSvgaPlayer)

RCT_EXPORT_VIEW_PROPERTY(source, NSString)
RCT_EXPORT_VIEW_PROPERTY(autoPlay, bool);
RCT_EXPORT_VIEW_PROPERTY(clearsAfterStop, bool);
RCT_EXPORT_VIEW_PROPERTY(loops, int);
RCT_EXPORT_VIEW_PROPERTY(align, NSString);
RCT_EXPORT_VIEW_PROPERTY(onFinished, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFrameChanged, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onPercentageChanged, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onLoaded, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onError, RCTBubblingEventBlock);


+ (BOOL)requiresMainQueueSetup {
    return YES;
}
@end

