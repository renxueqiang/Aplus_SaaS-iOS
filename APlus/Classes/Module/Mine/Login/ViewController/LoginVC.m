//
//  LoginVC.m
//  APlus
//
//  Created by 李慧娟 on 17/11/3.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "LoginVC.h"
#import "BYActionSheetView.h"
#import "AgencyUserPermisstionUtil.h"
#import "CustomActionSheet.h"
#import "CommonWebView.h"
#import "NotificationNameDefine.h"
#import "LogOffUtil.h"
#import "DascomUtil.h"

#import "PermissionApi.h"
#import "LoginEntity.h"
#import "DepartmentInfoEntity.h"
#import "PersonalInfoEntity.h"

#import "LoginBJPresenter.h"
#import "LoginNJPresenter.h"
#import "LoginTJPresenter.h"
#import "LoginSZPresenter.h"
#import "LoginAMPresenter.h"
#import "LoginGZPresenter.h"
#import "LoginCQPresenter.h"
#import "LoginCSPresenter.h"

@interface LoginVC()<BYActionSheetViewDelegate,UIPickerViewDataSource,
UIPickerViewDelegate,doneSelect,LoginViewProtocol>
{
    LoginBasePresenter *_loginPresenter;
    HKLoginApi *_loginApi;
    HKCommonApi *_cityCfgApi;
    AgencyUserInfoApi *_userInfoApi;
    DepartmentInfoEntity *_departmentEntity;
    GetPersonalApi *_getPersonalApi;

    __weak IBOutlet UITextField *_hostAccountTextfield;
    __weak IBOutlet UITextField *_hostPasswordTextfield;
    __weak IBOutlet UIButton *_loginBtn;
    __weak IBOutlet UILabel *_curAppVerson;
    UIPickerView *_mainPickerView;

    NSInteger selectedUserIndex;
    NSMutableArray *_departArray;
}

@end

@implementation LoginVC


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initView];
    [self initArray];

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(textChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:nil];

    NSString *curAppVerson = [[NSUserDefaults standardUserDefaults] stringForKey:CurrentAppVerson];
    _curAppVerson.text = curAppVerson;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - init

- (void)initPresenter
{
    if ([CityCodeVersion isBeiJing])
    {
        _loginPresenter = [[LoginBJPresenter alloc] initWithDelegate:self];
    }
    else if ([CityCodeVersion isTianJin])
    {
        _loginPresenter = [[LoginTJPresenter alloc] initWithDelegate:self];
    }
    else if ([CityCodeVersion isNanJing])
    {
        _loginPresenter = [[LoginNJPresenter alloc] initWithDelegate:self];
    }
    else if ([CityCodeVersion isShenZhen])
    {
        _loginPresenter = [[LoginSZPresenter alloc] initWithDelegate:self];
    }
    else if ([CityCodeVersion isAoMenHengQin])
    {
        _loginPresenter = [[LoginAMPresenter alloc] initWithDelegate:self];
    }
    else if ([CityCodeVersion isChongQing])
    {
        _loginPresenter = [[LoginCQPresenter alloc] initWithDelegate:self];
    }
    else if ([CityCodeVersion isGuangZhou])
    {
        _loginPresenter = [[LoginGZPresenter alloc] initWithDelegate:self];
    }
    else if ([CityCodeVersion isChangSha])
    {
        _loginPresenter = [[LoginCSPresenter alloc] initWithDelegate:self];
    }
    else
    {
        _loginPresenter = [[LoginBasePresenter alloc] initWithDelegate:self];
    }
}

- (void)initArray
{
    _departArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)initView
{
    _hostAccountTextfield.tag = 200;
    _hostPasswordTextfield.tag = 300;

    [self setTextfieldStyleWithItem:_hostAccountTextfield];
    [self setTextfieldStyleWithItem:_hostPasswordTextfield];
}

- (void)initShadowView
{
    _mainPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, APP_SCREEN_WIDTH, 180)];
    _mainPickerView.dataSource = self;
    _mainPickerView.delegate = self;

    CustomActionSheet *sheet = [[CustomActionSheet alloc] initWithView:_mainPickerView AndHeight:220];
    sheet.doneDelegate = self;
    [sheet showInView:self.view];
}

/// 获取虚拟号配置
- (void)initMsisdnMethod
{
    [_loginPresenter getMsisdnMethod];
}

#pragma mark - CustomMethod

/// 保存个人信息(sso返回)
- (void)savePersonalInformation:(LoginResultEntity *)result
{
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.cnName forKey:UserName];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.cnName forKey:APlusUserName];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.staffNo forKey:UserStaffNumber];
    [CommonMethod setUserdefaultWithValue:result.session forKey:HouseKeeperSession];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.cityCode forKey:CityCode];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.mobile forKey:UserStaffMobile];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.deptName forKey:UserDeptName];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.title forKey:UserTitle];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.agentUrl forKey:AgentUrl];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.domainAccount forKey:APlusDomainToken];
    [CommonMethod setUserdefaultWithValue:result.loginDomainUser.CompanyName forKey:UserCompanyName];
    [CommonMethod registPushWithState:YES];
}

// 保存个人信息(A+返回)
- (void)saveAPlusPersonalInformation:(PersonalInfoEntity *)staffInfoEntity
{
    [CommonMethod setUserdefaultWithValue:staffInfoEntity.employeeName forKey:APlusUserName];
    [CommonMethod setUserdefaultWithValue:staffInfoEntity.mobile forKey:APlusUserMobile];
    [CommonMethod setUserdefaultWithValue:staffInfoEntity.departmentName forKey:APlusUserDepartName];
    [CommonMethod setUserdefaultWithValue:staffInfoEntity.position forKey:APlusUserRoleName];
    [CommonMethod setUserdefaultWithValue:staffInfoEntity.photoPath forKey:APlusUserPhotoPath];
    [CommonMethod setUserdefaultWithValue:staffInfoEntity.extendTel forKey:APlusUserExtendMobile];
}

#pragma mark - <doneSelect>

/// 选择部门后的操作
- (void)doneSelectItemMethod
{
    DepartmentInfoResultEntity *userInfo = _departmentEntity.result[selectedUserIndex];
    [AgencyUserPermisstionUtil saveUserInfo:userInfo];
    [CommonMethod setUserdefaultWithValue:userInfo.identify.uName forKey:APlusUserName];
    [CommonMethod setUserdefaultWithValue:userInfo.identify.uName forKey:APlusUserName];

    [[self sharedAppDelegate] changeDiscoverRootVCIsLogin:NO];
    [_departArray removeAllObjects];

    // 获取虚拟号配置
    [self initMsisdnMethod];
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:nil];
}

#pragma mark - BtnClick
/// 查看密码
- (IBAction)lookPasswordClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    if (btn.isSelected)
    {
        _hostPasswordTextfield.secureTextEntry = NO;
        [btn setImage:[UIImage imageNamed:@"pop_btn_eye_open"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"pop_btn_eye_close"] forState:UIControlStateNormal];
        _hostPasswordTextfield.secureTextEntry = YES;
    }
}

/// 点击“帮助中心”
- (IBAction)clickHelpCenterMethod:(id)sender
{
    // 帮助中心
    CommonWebView *commonWebView = [[CommonWebView alloc]initWithNibName:@"CommonWebView"
                                                                  bundle:nil];
    commonWebView.pageSourceUrl = [[BaseApiDomainUtil getApiDomain] getCommonHelpURL];

    [self.navigationController pushViewController:commonWebView
                                         animated:YES];
}

/// 点击"登录"
- (IBAction)clickLoginBtn:(id)sender
{
    if (_hostAccountTextfield.text.length <= 0 || _hostPasswordTextfield.text.length <= 0)
    {
        showMsg(@"请输入账户或密码 ");
        return;
    }

    _loginBtn.userInteractionEnabled = NO;
    [_hostAccountTextfield resignFirstResponder];
    [_hostPasswordTextfield resignFirstResponder];

    [self showLoadingView:@"登录中..."];

    _loginApi = [HKLoginApi new];
    _loginApi.account = _hostAccountTextfield.text;
    _loginApi.pwd =_hostPasswordTextfield.text;
     [_manager sendRequest:_loginApi];
}

#pragma mark - TextChanged

- (void)textChanged:(NSNotification *)text
{
    UITextField *accountTextField = (UITextField *)[self.view viewWithTag:200];

    NSString *textStr = [accountTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    accountTextField.text = textStr;
}

#pragma mark - <SetTextfieldStyle>

- (void)setTextfieldStyleWithItem:(UITextField *)textfield
{
    // 设置placeholder的颜色，其中的_placeholderLabel.textColor是系统自带的，可以直接使用
    [textfield setValue:[UIColor colorWithRed:203.0/255.0
                                        green:203.0/255.0
                                         blue:203.0/255.0
                                        alpha:1.0]
             forKeyPath:@"_placeholderLabel.textColor"];

    [textfield setValue:[UIFont fontWithName:FontName
                                        size:14.0]
             forKeyPath:@"_placeholderLabel.font"];
}


#pragma mark - <PickerViewDelegate>

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _departArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *cusPicLabel = view ? (UILabel *) view : [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 20.0f)];

    NSString *cusStr = [_departArray objectAtIndex:row];
    cusPicLabel.text = cusStr;
    [cusPicLabel setFont:[UIFont systemFontOfSize:18.0]];
    [cusPicLabel setTextAlignment:NSTextAlignmentCenter];
    cusPicLabel.backgroundColor = [UIColor clearColor];

    return cusPicLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedUserIndex = row;
}

#pragma mark - <ResponseDelegate>

- (void)dealData:(CentaResponse *)resData
{
    [super dealData:resData];

    Class modelClass = [resData.api getRespClass];

    _loginBtn.userInteractionEnabled = YES;

    if ([modelClass isEqual:[LoginEntity class]])
    {
        LoginEntity *loginEntity = resData.data;
        LoginResultEntity *result = loginEntity.result;
        NSLog(@"%@",result);

        // 验证员工城市，目前只支持天津，深圳，北京，南京，横琴澳门, 广州, 重庆, 长沙, 东莞, 惠州
        NSArray *cityCodeArr = @[@"022", @"0755", @"010", @"025", @"853", @"020", @"023", @"0731", @"0571", @"0769", @"0752"];
        NSString *nowCityCode = result.loginDomainUser.cityCode;
        if (![cityCodeArr containsObject:nowCityCode])
        {
            [self hideLoadingView];
            showMsg(@"所在城市未开放中原管家");
            return;
        }

        // 存储登录用户信息至本地缓存
        NSString *userName = [NSString nilToEmptyWithStr:result.loginDomainUser.cnName];
        [CommonMethod setUserdefaultWithValue:userName
                                       forKey:UserName];
        [CommonMethod setUserdefaultWithValue:userName
                                       forKey:APlusUserName];

        NSString *staffNumber = [NSString nilToEmptyWithStr:result.loginDomainUser.staffNo];
        [CommonMethod setUserdefaultWithValue:staffNumber
                                       forKey:UserStaffNumber];

        NSString *houseKeeperSession = [NSString nilToEmptyWithStr:result.session];
        [CommonMethod setUserdefaultWithValue:houseKeeperSession
                                       forKey:HouseKeeperSession];

        NSString *cityCode = [NSString nilToEmptyWithStr:result.loginDomainUser.cityCode];
        [CommonMethod setUserdefaultWithValue:cityCode
                                       forKey:CityCode];

        NSString *userStaffMobile = [NSString nilToEmptyWithStr:result.loginDomainUser.mobile];
        [CommonMethod setUserdefaultWithValue:userStaffMobile
                                       forKey:UserStaffMobile];

        NSString *userDeptName = [NSString nilToEmptyWithStr:result.loginDomainUser.deptName];
        [CommonMethod setUserdefaultWithValue:userDeptName
                                       forKey:UserDeptName];

        NSString *userTitle = [NSString nilToEmptyWithStr:result.loginDomainUser.title];
        [CommonMethod setUserdefaultWithValue:userTitle
                                       forKey:UserTitle];

        NSString *agentUrl = [NSString nilToEmptyWithStr:result.loginDomainUser.agentUrl];
        [CommonMethod setUserdefaultWithValue:agentUrl
                                       forKey:AgentUrl];

        NSString *aplusDomainToken = [NSString nilToEmptyWithStr:result.loginDomainUser.domainAccount];
        [CommonMethod setUserdefaultWithValue:aplusDomainToken
                                       forKey:APlusDomainToken];

        NSString *userCompanyName = [NSString nilToEmptyWithStr:result.loginDomainUser.CompanyName];
        [CommonMethod setUserdefaultWithValue:userCompanyName
                                       forKey:UserCompanyName];

        [CommonMethod registPushWithState:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLoginSuccess];

        // 请求城市配置
        _cityCfgApi = [HKCommonApi new];
        _cityCfgApi.configType = @"2";
        _cityCfgApi.length = @"20";
        [_manager sendRequest:_cityCfgApi];

    }

    if ([modelClass isEqual:[CityConfigEntity class]])
    {
        // 获取城市域名及保存
        CityConfigEntity *cityConfigEntity = resData.data;
        [[BaseApiDomainUtil getApiDomain] saveApiDomainInfo:cityConfigEntity];

        // 登录管家成功后，从agency接口获取用户权限
        NSString *staff = [CommonMethod getUserdefaultWithKey:UserStaffNumber];
        _userInfoApi = [AgencyUserInfoApi new];
        _userInfoApi.staffNo = @[staff];
        [_manager sendRequest:_userInfoApi];
    }

    if ([modelClass isEqual:[DepartmentInfoEntity class]])
    {
        [self hideLoadingView];
        _departmentEntity = resData.data;

        if (_departmentEntity.result.count == 0)
        {
            showMsg(@"账号或密码错误!");
            // 忽略本次登录的 域名Url / 用户信息
            [LogOffUtil clearUserInfoFromLocal];
            return;
        }

        // 保存帐号，为验证A+密码提供帐号
        NSString *account = _hostAccountTextfield.text;
        [CommonMethod setUserdefaultWithValue:account forKey:Account];
        [self initPresenter];

        if (_departmentEntity.result.count == 1)
        {
            DepartmentInfoResultEntity *userInfo = _departmentEntity.result[0];

            // 存储用户信息
            [AgencyUserPermisstionUtil saveUserInfo:userInfo];

            // 用户不需登录
            [[self sharedAppDelegate] changeDiscoverRootVCIsLogin:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:nil];

            NSString *userCityCode = [CommonMethod getUserdefaultWithKey:CityCode];
            NSString *staffNo = [CommonMethod getUserdefaultWithKey:UserStaffNumber];
            _getPersonalApi = [[GetPersonalApi alloc] init];
            _getPersonalApi.staffNo = staffNo;
            _getPersonalApi.cityCode = userCityCode;
            [_manager sendRequest:_getPersonalApi];

#warning text
            // 获取虚拟号配置
//            [self initMsisdnMethod];
        }
        else
        {
            [_departArray removeAllObjects];
            for (int i = 0; i < _departmentEntity.result.count; i++)
            {
                DepartmentInfoResultEntity * entity=_departmentEntity.result[i];
                [_departArray addObject:entity.identify.departName];
            }
            [self initShadowView];
        }
    }

    if ([modelClass isEqual:[PersonalInfoEntity class]])
    {
        PersonalInfoEntity *staffInfoEntity = resData.data;
        [self saveAPlusPersonalInformation:staffInfoEntity];
    }
}

- (void)respFail:(CentaResponse *)error
{
    _loginBtn.userInteractionEnabled = YES;
    [LogOffUtil clearUserInfoFromLocal];

    [super respFail:error];
}

@end



