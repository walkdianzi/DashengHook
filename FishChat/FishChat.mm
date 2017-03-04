//
//  FishChat.mm
//  FishChat
//
//  Created by 杨萧玉 on 2017/2/22.
//  Copyright (c) 2017年 __MyCompanyName__. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import "CaptainHook.h"
#import <Cycript/Cycript.h>
#import <UIKit/UIKit.h>
#import "FishConfigurationCenter.h"

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()

#define CYCRIPT_PORT 8888

CHDeclareClass(UIApplication)
CHDeclareClass(MicroMessengerAppDelegate)
CHDeclareClass(CMessageMgr)
CHDeclareClass(CMessageWrap)
CHDeclareClass(WCRedEnvelopesLogicMgr)
CHDeclareClass(FindFriendEntryViewController)
CHDeclareClass(MMTabBarController)
CHDeclareClass(MMBadgeView)
CHDeclareClass(WCDeviceStepObject)
CHDeclareClass(NewMainFrameViewController)
CHDeclareClass(UIView)
CHDeclareClass(NSUserDefaults)
CHDeclareClass(NewSettingViewController)
CHDeclareClass(MMTableViewInfo)
CHDeclareClass(MMTableViewSectionInfo)
CHDeclareClass(MMTableViewCellInfo)
CHDeclareClass(MMTableView)
CHDeclareClass(UIViewController)
CHDeclareClass(UILabel)
CHDeclareClass(HongBaoRes)
CHDeclareClass(WXPBGeneratedMessage)

@interface WCPayInfoItem: NSObject

@property(retain, nonatomic) NSString *m_c2cNativeUrl;

@end

@interface CMessageWrap : NSObject // 微信消息
@property (retain, nonatomic) WCPayInfoItem *m_oWCPayInfoItem;
@property (assign, nonatomic) NSUInteger m_uiMesLocalID;
@property (retain, nonatomic) NSString* m_nsFromUsr; // 发信人，可能是群或个人
@property (retain, nonatomic) NSString* m_nsToUsr; // 收信人
@property (assign, nonatomic) NSUInteger m_uiStatus;
@property (retain, nonatomic) NSString* m_nsContent; // 消息内容
@property (retain, nonatomic) NSString* m_nsRealChatUsr; // 群消息的发信人，具体是群里的哪个人
@property (nonatomic) NSUInteger m_uiMessageType;
@property (nonatomic) long long m_n64MesSvrID;
@property (nonatomic) NSUInteger m_uiCreateTime;
@property (retain, nonatomic) NSString *m_nsDesc;
@property (retain, nonatomic) NSString *m_nsAppExtInfo;
@property (nonatomic) NSUInteger m_uiAppDataSize;
@property (nonatomic) NSUInteger m_uiAppMsgInnerType;
@property (retain, nonatomic) NSString *m_nsShareOpenUrl;
@property (retain, nonatomic) NSString *m_nsShareOriginUrl;
@property (retain, nonatomic) NSString *m_nsJsAppId;
@property (retain, nonatomic) NSString *m_nsPrePublishId;
@property (retain, nonatomic) NSString *m_nsAppID;
@property (retain, nonatomic) NSString *m_nsAppName;
@property (retain, nonatomic) NSString *m_nsThumbUrl;
@property (retain, nonatomic) NSString *m_nsAppMediaUrl;
@property (retain, nonatomic) NSData *m_dtThumbnail;
@property (retain, nonatomic) NSString *m_nsTitle;
@property (retain, nonatomic) NSString *m_nsMsgSource;
- (instancetype)initWithMsgType:(int)msgType;
+ (UIImage *)getMsgImg:(CMessageWrap *)arg1;
+ (NSData *)getMsgImgData:(CMessageWrap *)arg1;
+ (NSString *)getPathOfMsgImg:(CMessageWrap *)arg1;
- (UIImage *)GetImg;
- (BOOL)IsImgMsg;
- (BOOL)IsAtMe;
+ (void)GetPathOfAppThumb:(NSString *)senderID LocalID:(NSUInteger)mesLocalID retStrPath:(NSString **)pathBuffer;
@end

@interface CContactMgr : NSObject
- (id)getSelfContact;
- (id)getContactByName:(id)arg1;
@end

@interface CContact: NSObject
@property(retain, nonatomic) NSString *m_nsUsrName;
@property(retain, nonatomic) NSString *m_nsHeadImgUrl;
@property(retain, nonatomic) NSString *m_nsNickName;


- (id)getContactDisplayName;
@end

@interface WCBizUtil : NSObject

+ (id)dictionaryWithDecodedComponets:(id)arg1 separator:(id)arg2;

@end

@interface WCRedEnvelopesLogicMgr: NSObject
- (void)OpenRedEnvelopesRequest:(id)params;
- (void)ReceiverQueryRedEnvelopesRequest:(id)arg1;
@end

@interface MMServiceCenter : NSObject
+ (instancetype)defaultCenter;
- (id)getService:(Class)service;
@end

@interface WXPBGeneratedMessage : NSObject
{
    int _has_bits_[3];
    int _serializedSize;
    struct PBClassInfo *_classInfo;
    id *_ivarValueDict;
}

+ (id)parseFromData:(id)arg1;
- (_Bool)hasProperty:(int)arg1;
- (unsigned int)continueFlag;
- (id)baseResponse;
- (void)setBaseRequest:(id)arg1;
- (void)writeValueToCodedOutputDataNoTag:(struct CodedOutputData *)arg1 value:(id)arg2 fieldType:(unsigned char)arg3;
- (void)writeValueToCodedOutputData:(struct CodedOutputData *)arg1 value:(id)arg2 fieldNumber:(int)arg3 fieldType:(unsigned char)arg4;
- (void)writeToCodedOutputData:(struct CodedOutputData *)arg1;
- (int)computeValueSizeNoTag:(id)arg1 fieldType:(unsigned char)arg2;
- (int)computeValueSize:(id)arg1 fieldNumber:(int)arg2 fieldType:(unsigned char)arg3;
- (int)serializedSize;
- (id)serializedData;
- (_Bool)isInitialized;
- (_Bool)isMessageInitialized:(id)arg1;
- (id)readValueFromCodedInputData:(struct CodedInputData *)arg1 fieldType:(unsigned char)arg2;
- (id)mergeFromCodedInputData:(struct CodedInputData *)arg1;
- (id)mergeFromData:(id)arg1;
- (id)valueAtIndex:(int)arg1;
- (void)setValue:(id)arg1 atIndex:(int)arg2;
- (int)indexOfPropertyWithSetter:(const char *)arg1;
- (int)indexOfPropertyWithGetter:(const char *)arg1;
- (void)dealloc;
- (id)init;

@end


@class BaseResponse, NSString, SKBuiltinBuffer_t;

@interface HongBaoRes : WXPBGeneratedMessage{
}

+ (void)initialize;

// Remaining properties
@property(retain, nonatomic) BaseResponse *baseResponse; // @dynamic baseResponse;
@property(nonatomic) int cgiCmdid; // @dynamic cgiCmdid;
@property(retain, nonatomic) NSString *errorMsg; // @dynamic errorMsg;
@property(nonatomic) int errorType; // @dynamic errorType;
@property(retain, nonatomic) NSString *platMsg; // @dynamic platMsg;
@property(nonatomic) int platRet; // @dynamic platRet;
@property(retain, nonatomic) SKBuiltinBuffer_t *retText; // @dynamic retText;

@end


/*--------------------------------------------------------------------------------------------*/

// 监听 Cycript 8888 端口
CHOptimizedMethod2(self, void, MicroMessengerAppDelegate, application, UIApplication *, application, didFinishLaunchingWithOptions, NSDictionary *, options)
{
    CHSuper2(MicroMessengerAppDelegate, application, application, didFinishLaunchingWithOptions, options);
    
    NSLog(@"## Start Cycript ##");
    CYListenServer(CYCRIPT_PORT);
}

// 阻止撤回消息
CHOptimizedMethod1(self, void, CMessageMgr, onRevokeMsg, id, msg)
{
    [FishConfigurationCenter sharedInstance].revokeMsg = YES;
    CHSuper1(CMessageMgr, onRevokeMsg, msg);
}

CHDeclareMethod3(void, CMessageMgr, DelMsg, id, arg1, MsgList, id, arg2, DelAll, BOOL, arg3)
{
    if ([FishConfigurationCenter sharedInstance].revokeMsg) {
        [FishConfigurationCenter sharedInstance].revokeMsg = NO;
    }
    else {
        CHSuper3(CMessageMgr, DelMsg, arg1, MsgList, arg2, DelAll, arg3);
    }
}

#pragma mark- 抢红包

CHOptimizedMethod1(self, void, WCRedEnvelopesLogicMgr, OpenRedEnvelopesRequest, id, arg1){
    
    CHSuper1(WCRedEnvelopesLogicMgr, OpenRedEnvelopesRequest, arg1);
    NSLog(@"dashengfishchat RedEnvelopes %@",arg1);
}

CHOptimizedMethod2(self, void, WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, id, arg1, Request, id, arg2)
{
    
    CHSuper2(WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, arg1, Request, arg2);
    if ([NSStringFromClass([arg1 class]) isEqualToString:@"HongBaoRes"])
    {
        HongBaoRes* hbRes = arg1;
        //NSLog(@"666666666666666666666666666666666666666666666666");
        //NSLog(@"HongBaoRes, retText=%@, buffer=%@", [hbRes retText], [[hbRes retText] buffer]);
        NSData* data = [[hbRes retText] buffer];
        if (nil != data && 0 < [data length])
        {
            NSError* error = nil;
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments//kNilOptions
                                                           error:&error];
            if (nil != error)
            {
                NSLog(@"HongBaoRes, json-error=%@", [error localizedDescription]);
            }
            else if (nil != jsonObj)
            {
                if ([NSJSONSerialization isValidJSONObject:jsonObj])
                {
                    //NSLog(@"HongBaoRes, jsonObj[class=%@]=%@", [jsonObj class], jsonObj);
                    if ([jsonObj isKindOfClass:[NSDictionary class]])
                    {
                        id idTemp = jsonObj[@"timingIdentifier"];
                        NSLog(@"dashengfishchat timingIdentifier[class=%@]=%@", [idTemp class], idTemp);
                        if (idTemp)
                        {
                            [FishConfigurationCenter sharedInstance].timingIdentifier = idTemp;
                            if ([FishConfigurationCenter sharedInstance].timingIdentifier && [FishConfigurationCenter sharedInstance].hongbaoParams && [FishConfigurationCenter sharedInstance].isHongbao) {
                                
                                [[FishConfigurationCenter sharedInstance].hongbaoParams setObject:[FishConfigurationCenter sharedInstance].timingIdentifier forKey:@"timingIdentifier"];
                                
                                WCRedEnvelopesLogicMgr *logicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("WCRedEnvelopesLogicMgr") class]];
                                [logicMgr OpenRedEnvelopesRequest:[FishConfigurationCenter sharedInstance].hongbaoParams];
                                
                                [FishConfigurationCenter sharedInstance].timingIdentifier = nil;
                                [FishConfigurationCenter sharedInstance].hongbaoParams = nil;
                            }
                        }
                    }
                }
            }
        }
    }
}

CHOptimizedMethod2(self, void, CMessageMgr, AsyncOnAddMsg, id, arg1, MsgWrap, id, arg2)
{
    CMessageWrap *wrap = arg2;
    CHSuper2(CMessageMgr, AsyncOnAddMsg, arg1, MsgWrap, arg2);
    NSLog(@"dashengfishchat %@ %ld",wrap,(long)wrap.m_uiMessageType);
    switch(wrap.m_uiMessageType) {
        case 49: { // AppNode
            
            CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
            CContact *selfContact = [contactManager getSelfContact];
            
            BOOL isMesasgeFromMe = NO;
            if ([wrap.m_nsFromUsr isEqualToString:selfContact.m_nsUsrName]) {
                isMesasgeFromMe = YES;
                NSLog(@"dashengfishchat YES %@",selfContact.m_nsUsrName);
            }
            NSString *nativeUrl = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];
            NSLog(@"dashengfishchat nativeUrl %@  %@  %@  %@",nativeUrl,wrap.m_nsContent, wrap.m_nsToUsr, wrap.m_nsFromUsr);
            if ([wrap.m_nsContent rangeOfString:@"wxpay://"].location != NSNotFound) { // 红包
                if ([wrap.m_nsFromUsr rangeOfString:@"@chatroom"].location != NSNotFound ||
                    (isMesasgeFromMe && [wrap.m_nsToUsr rangeOfString:@"@chatroom"].location != NSNotFound)) { // 群组红包或群组里自己发的红包
                    
                    NSString *nativeUrl = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];
                    nativeUrl = [nativeUrl substringFromIndex:[@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length]];
                    
                    NSDictionary *nativeUrlDict = [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:nativeUrl separator:@"&"];
                    
                    NSLog(@"dashengfishchat nativeUrlDict %@",nativeUrlDict);
                    
                    /** 构造参数 */
                    NSMutableDictionary *params = [@{} mutableCopy];
                    [params setObject:nativeUrlDict[@"msgtype"] forKey:@"msgType"];
                    [params setObject:nativeUrlDict[@"sendid"] forKey:@"sendId"];
                    [params setObject:nativeUrlDict[@"channelid"] forKey:@"channelId"];
                    [params setObject:[selfContact getContactDisplayName] forKey:@"nickName"];
                    [params setObject:[selfContact m_nsHeadImgUrl] forKey:@"headImg"];
                    [params setObject:[[wrap m_oWCPayInfoItem] m_c2cNativeUrl] forKey:@"nativeUrl"];
                    [params setObject:wrap.m_nsToUsr forKey:@"sessionUserName"];
                    
                    [FishConfigurationCenter sharedInstance].hongbaoParams = params;
                    WCRedEnvelopesLogicMgr *logicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("WCRedEnvelopesLogicMgr") class]];
                    [logicMgr ReceiverQueryRedEnvelopesRequest:[FishConfigurationCenter sharedInstance].hongbaoParams];
                }
            }
            return;
            break;
        }
        default:
            break;
    }
}

// 关闭朋友圈入口
CHOptimizedMethod2(self, CGFloat, FindFriendEntryViewController, tableView, UITableView *, tableView, heightForRowAtIndexPath, NSIndexPath *, indexPath)
{
    NSIndexPath *timelineIndexPath = [self valueForKeyPath:@"m_WCTimeLineIndexPath"];
    if ([indexPath isEqual: timelineIndexPath] || indexPath.section == 2) {
        NSLog(@"## Hide Time Line Entry ##");
        return 0;
    }
    return CHSuper2(FindFriendEntryViewController, tableView, tableView, heightForRowAtIndexPath, indexPath);
}

CHOptimizedMethod2(self, UITableViewCell *, FindFriendEntryViewController, tableView, UITableView *, tableView, cellForRowAtIndexPath, NSIndexPath *, indexPath)
{
    NSIndexPath *timelineIndexPath = [self valueForKeyPath:@"m_WCTimeLineIndexPath"];
    UITableViewCell *cell = CHSuper2(FindFriendEntryViewController, tableView, tableView, cellForRowAtIndexPath, indexPath);
    if ([indexPath isEqual: timelineIndexPath] || indexPath.section == 2) {
        NSLog(@"## Hide Time Line Entry ##");
        cell.hidden = YES;
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
        }
    }
    return cell;
}

CHOptimizedMethod1(self, void, FindFriendEntryViewController, viewDidAppear, BOOL, animated)
{
    CHSuper1(FindFriendEntryViewController, viewDidAppear, animated);
    [self performSelector:@selector(reloadData)];
}

// 去掉 TabBar 小红点

CHOptimizedMethod2(self, void, MMTabBarController, setTabBarBadgeImage, id, arg1, forIndex, unsigned int, arg2)
{
    if (arg2 != 2 && arg2 != 3) {
        CHSuper2(MMTabBarController, setTabBarBadgeImage, arg1, forIndex, arg2);
    }
}

CHOptimizedMethod2(self, void, MMTabBarController, setTabBarBadgeString, id, arg1, forIndex, unsigned int, arg2)
{
    if (arg2 != 2 && arg2 != 3) {
        CHSuper2(MMTabBarController, setTabBarBadgeString, arg1, forIndex, arg2);
    }
}

CHOptimizedMethod2(self, void, MMTabBarController, setTabBarBadgeValue, id, arg1, forIndex, unsigned int, arg2)
{
    if (arg2 != 2 && arg2 != 3) {
        CHSuper2(MMTabBarController, setTabBarBadgeValue, arg1, forIndex, arg2);
    }
}

// 去掉各种小红点

CHOptimizedMethod1(self, void, UIView, didAddSubview, UIView *, subview)
{
    if ([subview isKindOfClass:NSClassFromString(@"MMBadgeView")]) {
        subview.hidden = YES;
    }
}

// 微信运动步数

CHOptimizedMethod0(self, unsigned int, WCDeviceStepObject, m7StepCount)
{
    return (int)[FishConfigurationCenter sharedInstance].stepCount + CHSuper0(WCDeviceStepObject, m7StepCount);
}

// 设置

CHDeclareMethod0(void, NewSettingViewController, reloadTableData)
{
    CHSuper0(NewSettingViewController, reloadTableData);
    MMTableViewInfo *tableInfo = [self valueForKeyPath:@"m_tableViewInfo"];
    MMTableViewSectionInfo *sectionInfo = [objc_getClass("MMTableViewSectionInfo") sectionInfoDefaut];
    MMTableViewCellInfo *nightCellInfo = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(handleHongbao:) target:[FishConfigurationCenter sharedInstance] title:@"自动抢红包" on:[FishConfigurationCenter sharedInstance].isHongbao];
    [sectionInfo addCell:nightCellInfo];
    MMTableViewCellInfo *stepcountCellInfo = [objc_getClass("MMTableViewCellInfo") editorCellForSel:@selector(handleStepCount:) target:[FishConfigurationCenter sharedInstance] tip:@"请输入步数" focus:NO text:[NSString stringWithFormat:@"%ld", (long)[FishConfigurationCenter sharedInstance].stepCount]];
    [sectionInfo addCell:stepcountCellInfo];
    [tableInfo insertSection:sectionInfo At:0];
    MMTableView *tableView = [tableInfo getTableView];
    [tableView reloadData];
}


CHConstructor // code block that runs immediately upon load
{
	@autoreleasepool
	{
        CHLoadLateClass(MicroMessengerAppDelegate);  // load class (that will be "available later")
		CHHook2(MicroMessengerAppDelegate, application, didFinishLaunchingWithOptions); // register hook
        CHLoadLateClass(CMessageMgr);
        CHHook1(CMessageMgr, onRevokeMsg);
        CHHook2(CMessageMgr, AsyncOnAddMsg, MsgWrap);
        CHLoadLateClass(WCRedEnvelopesLogicMgr);
        CHHook1(WCRedEnvelopesLogicMgr, OpenRedEnvelopesRequest);
        CHHook2(WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, Request);
        CHLoadLateClass(FindFriendEntryViewController);
        CHHook2(FindFriendEntryViewController, tableView, heightForRowAtIndexPath);
        CHHook2(FindFriendEntryViewController, tableView, cellForRowAtIndexPath);
        CHHook1(FindFriendEntryViewController, viewDidAppear);
        CHLoadLateClass(MMTabBarController);
        CHHook2(MMTabBarController, setTabBarBadgeImage, forIndex);
        CHHook2(MMTabBarController, setTabBarBadgeString, forIndex);
        CHHook2(MMTabBarController, setTabBarBadgeValue, forIndex);
        CHLoadLateClass(WCDeviceStepObject);
        CHHook0(WCDeviceStepObject, m7StepCount);
        CHLoadLateClass(UIView);
        CHHook1(UIView, didAddSubview);
	}
}
