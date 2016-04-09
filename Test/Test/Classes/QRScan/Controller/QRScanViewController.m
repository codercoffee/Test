//
//  QRScanViewController.m
//  二维码扫描
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "QRScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"

@interface QRScanViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureDevice *device;
    AVCaptureDeviceInput *input;
    AVCaptureMetadataOutput *output;
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *preview;

}

@property (nonatomic, strong) QRView *qrView;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation QRScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
/* 设置导航栏上面的内容 */
    self.title = @"扫一扫";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:kCOLOR(67, 43, 43, 1)}];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backButtonClick) image:@"ico_back" highLightedImage:@"ico_back"];
    
    
    // 默认配置
    [self defaultConfig];
    // 配置界面
    [self configUI];
    // 扫描区域布局
    [self updateLayout];
    
    // 提示
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"请扫描二维码";
    promptLabel.textColor = [KColor kColorWithHexString:@"f7c728"];
    promptLabel.font = [UIFont systemFontOfSize:17];
    CGSize promptSize = [KString kSizeOfText:promptLabel.text withFont:promptLabel.font];
    CGFloat promptLabelX = (SCREEN_WIDTH - promptSize.width) / 2;
    CGFloat promptLabelY = kScaleHeight(130);
    promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptSize.width, promptSize.height);
    [self.view addSubview:promptLabel];
    
}

/**
 *  默认配置
 */
- (void)defaultConfig
{
    #if !(TARGET_IPHONE_SIMULATOR)
    // 1. 实例化拍摄设备
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2. 设置输入设备
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3. 设置元数据输出
    output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 4. 添加拍摄会话
    session = [[AVCaptureSession alloc] init];
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    #endif
    
    // 5. 视频预览图层
    preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    preview.videoGravity =AVLayerVideoGravityResize;
    preview.frame = [UIScreen screenBounds];
    [self.view.layer insertSublayer:preview atIndex:0];
    
    // 6. 启动会话
    [session startRunning];
    
}

/**
 *  配置界面
 */
- (void)configUI
{
    [self.view addSubview:self.qrView];
}

/**
 *  扫描区域布局
 */
- (void)updateLayout
{
    _qrView.center = CGPointMake([UIScreen screenBounds].size.width / 2, [UIScreen screenBounds].size.height / 2);
    
    //修正扫描区域
    CGRect cropRect = CGRectMake((SCREEN_WIDTH - self.qrView.transparentArea.width) / 2,
                                 (SCREEN_HEIGHT - self.qrView.transparentArea.height) / 2,
                                 self.qrView.transparentArea.width,
                                 self.qrView.transparentArea.height);
    
    [output setRectOfInterest:CGRectMake(cropRect.origin.y / SCREEN_HEIGHT,
                                          cropRect.origin.x / SCREEN_WIDTH,
                                          cropRect.size.height / SCREEN_HEIGHT,
                                          cropRect.size.width / SCREEN_WIDTH)];
}


/**
 *  执行扫描完之后的代码，stringValue是扫描结果
 */
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    KLog(@"stringValue:%@", stringValue);
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_maskView removeFromSuperview];
        [session startRunning];
    });
    
    
    
    
    
    
    
    
    
}


#pragma mark - getter and setter
-(QRView *)qrView
{
    if (!_qrView)
    {
        CGRect screenRect = [UIScreen screenBounds];
        _qrView = [[QRView alloc] initWithFrame:screenRect];
        _qrView.transparentArea = CGSizeMake(200, 200);
        
        _qrView.backgroundColor = [UIColor clearColor];
    }
    return _qrView;
}

#pragma mark - actions

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 视图即将出现，视图即将消失
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![session isRunning])
    {
        [self defaultConfig];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [preview removeFromSuperlayer];
    [session stopRunning];
    [_maskView removeFromSuperview];
}


@end
