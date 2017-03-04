//
//  FishConfigurationCenter.m
//  FishChat
//
//  Created by 杨萧玉 on 2017/2/26.
//
//

#import "FishConfigurationCenter.h"

static NSString *DashengStepNumber = @"dashengStepNumber";

@implementation FishConfigurationCenter

- (void)dealloc
{
    [super dealloc];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static FishConfigurationCenter *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [FishConfigurationCenter new];
    });
    return _instance;
}

- (void)handleHongbao:(UISwitch *)sender
{
    self.hongbao = sender.isOn;
    [[self viewControllerOfResponder:sender] viewWillAppear:NO];
}

- (void)handleStepCount:(UITextField *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@(sender.text.integerValue) forKey:DashengStepNumber];
    self.stepCount = sender.text.integerValue;
}

- (NSInteger)stepCount{
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:DashengStepNumber]) {
        return [[NSUserDefaults standardUserDefaults] integerForKey:DashengStepNumber];
    }else{
        return 0;
    }
}

- (UIViewController *)viewControllerOfResponder:(UIResponder *)responder
{
    UIResponder *current = responder;
    while (current && ![current isKindOfClass:UIViewController.class]) {
        current = [current nextResponder];
    }
    return (UIViewController *)current;
}

@end
