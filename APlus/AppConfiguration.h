//
//  AppConfiguration.h
//  APlus
//
//  Created by sujp on 2017/9/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#ifndef AppConfiguration_h
#define AppConfiguration_h

#define showMsg(msg) \
{UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];\
[alertView show];}


#pragma mark - Colors

// RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define UIColorFromHex(hex,alp)  [UIColor colorWithRed:(((hex & 0xFF0000) >> 16))/255.0 green:(((hex &0xFF00) >>8))/255.0 blue:((hex &0xFF))/255.0 alpha:alp]

#define AppBackgroundColor  [UIColor colorWithRed:244.0 / 255.0 green:244.0 / 255.0 blue:244.0 / 255.0 alpha:1.0f]
#define MainBlackColor      [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0f]
#define MainRedColor        [UIColor colorWithRed:255.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0f]
#define ColorWhite          [UIColor whiteColor]
#define MainGrayFontColor   [UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1.0f]

#pragma mark - Device information - 设备信息

#define MODEL_NAME                      [[UIDevice currentDevice] model]
#define MODEL_VERSION                   [[[UIDevice currentDevice] systemVersion] floatValue]
#define APP_SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define MainScreenBounds                [UIScreen mainScreen].bounds
#define MainViewBounds                  CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 64)

#pragma mark -  iphone X 适配相关

/// 是否是iPhone X
#define IS_iPhone_X             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) : NO)
/// 电池条高度
#define STATUS_BAR_HEIGHT       (IS_iPhone_X ? 44 : 20)
/// 底部安全区域高度
#define BOTTOM_SAFE_HEIGHT      34
/// 导航栏高度
#define APP_NAV_HEIGHT          (IS_iPhone_X ? 88 : 64)
/// 标签栏高度
#define APP_TAR_HEIGHT          (IS_iPhone_X ? 83 : 49)

#pragma mark - UIApplication

#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define KeyWindow [UIApplication sharedApplication].keyWindow

#pragma mark - FontName

#define BoldFontName                    @"Helvetica-Bold"
#define FontName                        @"Helvetica"


#pragma mark - WeakSelf/StrongSelf

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define StrongSelf(strongSelf) __strong __typeof(&*self) strongSelf = weakSelf;


#pragma mark - <SDK_AppKey/ID>
#define BaiduMobStatAppKey              @"1074e750fd"                               // 百度统计Appkey(正式)
#define BaiduMobStatChannelId           @"enterprise"                               // 百度统计id(正式)
#define BaiduMobStatChannelIdDev        @"dev"                                      // 百度统计id(测试)
#define IFlySpeechAppId                 @"560659c6"                                 // 科大讯飞AppId

#define UMAppKey                        @"56407a8867e58e775200063c"                 // 友盟分享appkey

#define BaiduMapAppKey                  @"G8nD03qDLtocEzhidVM2p3n3GQxKnQud"         // 百度地图appkey(测试)
//#define BaiduMapAppKey                  @"Ts9B57uEiQujvV476qnoHR22"                 // 百度地图appkey(正式)


#define WeiboAppKey                     @"2007513470"                               // 微博分享appkey
#define WeiboAppSecret                  @"05e78e3154d1304cde3de204352aac98"         // 微博分享appSecret

#define WeixinAppKey                    @"wxf613c651a0662647"                       // 微信分享appkey
#define WeixinAppSecret                 @"0c209850fee5f91a60a992ecdc54eda8"         // 微信分享appSecret

#define GrowingIOKey                    @"9a29759503aafcbb"                         // GrowingIO项目ID

#define RongCloudAppKey                 @"n19jmcy59f619"                            // 融云appkey(正式)
#define RongCloudAppSecret              @"178n2EQNgoipC"                            // 融云secret

#pragma mark - <FontName>

#define BoldFontName                    @"Helvetica-Bold"
#define FontName                        @"Helvetica"

#define BeijingInfoKey                  @"HiddenModule"                             // 北京资讯分享链接key


#pragma mark - <UserDefault_Key>

#define PersonalPushVC                  @"PersonalPushViewController"               // 个人中心跳转页面通知name
#define CustomHelpUrl                   @"CustomHelpUrl"                            // 客服帮助url
#define APlusDomainToken                @"AgencyDomainToken"                        // agency系统中的
#define HouseKeeperSession              @"HouseKeeperSession"                       // 移动A+API
#define UserLoginSuccess                @"UserLoginSuccess"                         // 用户是否登录成功
#define LastStaffNo                     @"LastUserStaffNumber"                      // 最后一次登录用户名
#define LastStaffCityCode               @"LasrUserCityCode"                         // 最后一次用户登录城市


#define CheckRoomNumberLimitTimes       @"CheckRoomNumberLimitTimes"                // 查看房号的限制次数
#define CurrentAppVerson                @"CurAppVerson"                             // 当前APP版本
#define SaveDateTime                    @"SaveDateTime"                             // APP当前使用的时间（用来限制单日功能）
#define RongCloudUserToken              @"UserToken"                                // 融云token
#define ShowWelcomePage                 @"ShowWelcomePage"                          // 欢迎页
#define ShowChatIcon                    @"ShowChatIcon"                             // 开启首页聊天入口
#define ShowImageOnlyWIFI               @"ShowImageOnlyWIFI"                        // 是否仅wifi网络显示图片
#define GetAgencyPhoneSuccess           @"GetAgencyPhoneSuccess"                    // 获取手机号成功
#define UpdateVersionUrl                @"UpdateVersionUrl"                         // 更新版本地址
#define UpdateContent                   @"UpdateContent"                            // 更新内容
#define EnableNotify                    @"EnableNotify"                             // 消息提醒开关
#define AllMessageRemind                @"AllMessageRemind"                         // 所有消息红点提示
#define OfficalMessageRemind            @"OfficalMessageRemind"                     // 官方消息红点提示
#define PropMessageRemind               @"PropMessageRemind"                        // 房源消息
#define CustomerMessageRemind           @"CustomerMessageRemind"                    // 客源消息
#define DealMessageRemind               @"DealMessageRemind"                        // 成交消息
#define PrivateMessageRemind            @"PrivateMessageRemind"                     // 我的私信
#define AddTakingSeeRemind              @"AddTakingSeeRemind"                       // 新增约看推送
#define UnreadNotification              @"UnreadNotification"                       // 消息未读通知name

#define ChangeTradingState              @"ChangeTradingState"                       // 房源状态更改
#define KeyListVCCallTime               @"CallKeyTelTime"                           // 拨打钥匙电话记录时间
#define CustomerInfoTelTime             @"CustomerInfoTelTime"                      // 拨打客户信息电话记录时间


#define AutoGestureLockTimeSpan         @"AutoGestureLockTimeSpan"                  // 手势自动锁定时间间隔
#define AutoPwdLockTimeSpan             1800                                        // 30分钟后密码锁定（30分＊60秒）
#define DefaultErrorTimes               5                                           // 默认A+密码验证错误次数限制
#define ErrorTimes                      @"ErrorTimes"                               // 错误次数
#define Account                         @"AccountName"                              // 登录帐号
#define PwdInputLength                  30                                          // 密码输入框长度

#define AllRoundListPhotoWidth          @"?width=200"                               // 通盘房源列表 首页实勘图宽度为200
#define PhotoDownWidth                  @"?width=800"                               // 浏览实勘大图 实勘图宽度为800
#define WaterMark                       @"&watermark=smallgroup_center"             // 加中原地产水印
#define TrustWaterMark                  @"&watermark=copyright"                     // 加委托审核水印

/**
 *  登录用户在集团人事系统中的信息
 */
#pragma mark - <UserInfo>
#define UserName                        @"UserName"                                 // 用户名
#define APlusUserName                   @"APlusUserName"                            // 员工姓名
#define APlusUserMobile                 @"APlusUserMobile"                          // 用户手机号
#define APlusUserExtendMobile           @"APlusUserExtendMobile"                    // 用户其他手机号
#define APlusUserDepartName             @"APlusUserDepartName"                      // 用户部门名称
#define APlusUserRoleName               @"APlusUserRoleName"                        // 用户角色名称
#define APlusUserPhotoPath              @"APlusUserPhotoPath"                       // 用户角色头像
#define UserStaffNumber                 @"UserStaffNumber"                          // 用户编号
#define CityCode                        @"CityCode"                                 // 城市编号
#define UserStaffMobile                 @"UserStaffMobile"                          // 用户电话
#define UserDeptName                    @"UserDeptName"                             // 用户部门
#define UserTitle                       @"UserTitle"                                // 用户职称
#define AgentUrl                        @"AgentUrl"                                 // 用户头像地址
#define UserCompanyName                 @"UserCompanyName"                          // 用户公司名称
#define IsLoginSuccess                  @"IsLoginSuccess"                           // 是否登陆成功
#define Msisdn                          @"msisdn"                                   // 得实达康报备号

#define KeyWord                         @"KeyWord"                                  // 通盘房源默认搜索条件
#define NameString                      @"NameString"                               // 通盘房源默认保存名字

/**
 *  登录用户业务设置参数
 */
#define DeptVirtualSwitch               @"DeptVirtualSwitch"                        // 部门虚拟号开关(北京)
#define VirtualCallSwitch               @"VirtualCallSwitch"                        // APPSetting虚拟号开关





#endif /* AppConfiguration_h */
