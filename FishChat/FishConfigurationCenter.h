//
//  FishConfigurationCenter.h
//  FishChat
//
//  Created by 杨萧玉 on 2017/2/26.
//
//

#import <UIKit/UIKit.h>

@interface FishConfigurationCenter : NSObject

@property (nonatomic, getter = isHongbao) BOOL hongbao;
@property (nonatomic, strong)NSMutableDictionary *hongbaoParams;
@property (nonatomic, copy)NSString         *timingIdentifier;
@property (nonatomic) NSInteger stepCount;
@property (nonatomic, getter=onRevokeMsg) BOOL revokeMsg;

+ (instancetype)sharedInstance;

- (void)handleHongbao:(UISwitch *)sender;
- (void)handleStepCount:(UITextField *)sender;

@end
