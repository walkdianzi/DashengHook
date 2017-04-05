# FishChat

Hook WeChat.app on non-jailbroken devices.

## Futures

- [x] 关闭『发现』页面的『朋友圈』、『购物』和『游戏』入口
- [x] 修改微信运动步数
- [x] 去除各种小红点提示
- [x] 阻止撤回消息
- [x] 自动抢红包

## 参考

[Make WeChat Great Again](http://yulingtianxia.com/blog/2017/02/28/Make-WeChat-Great-Again/)
[TweakForWeChatRedEnvelop](https://github.com/kasumar/TweakForWeChatRedEnvelop/blob/master/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop.xm)
[iOSAppHook](https://github.com/Urinx/iOSAppHook#%E4%BD%BF%E7%94%A8Reveal%E8%B0%83%E8%AF%95%E5%BE%AE%E4%BF%A1%E7%9A%84App%E7%95%8C%E9%9D%A2)

## 使用

安装mobiledevice（也可以使用iTools来安装ipa到手机上）
```
brew update
brew install mobiledevice
```

进入Shell目录执行：
```
./autoswimfi.sh wechat.ipa development.mobileprovision FishChat.dylib`
```

## 注意

- 证书需要包含有自己安装的设备，证书要注意是否过期，过期的话mobiledevice安装的时候会报错

- wechat.ipa需要是砸过壳的ipa包，自己不会的话，可以到PP助手或同步助手上面的越狱应用下载（不是正版应用）

- 执行脚本的时候电脑要断网，不知道为什么网上的教程都没有提，还是我哪里操作错了。我弄了好久，是刚好不小心断网了，就安装成功了，才发现的这个问题。

- 有时候会出现`!AMDeviceSecureInstallApplication`，一种情况是.mobileprovision的问题过期或者无效。还有就是有时候需要删除手机上已经安装过的那个软件才能重新安装重签名的版本。

- xcode运行的时候设备不要选择模拟器，选择Generic iOS Device，否则安装起来之后app会崩溃