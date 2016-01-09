//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKUserInfoViewController.h"
#import "YKUserInfoCell.h"
#import "YKUserHeadPicCell.h"
#import "AliOSS.h"
#import "YKUpdataNickNameViewController.h"


static const NSString *identifier = @"YKUserInfoCell";
static const NSString *YKUserHeadPicCellIdentifier = @"YKUserHeadPicCellIdentifier";

static const NSString *accessKey = @"p7lSD81ifjHJXayT";
static const NSString *secretKey = @"Q71j2cMi2pwHEMb55RPiOnCoRTASSw";
static const NSString *demoBucket = @"pic-zhengzai-tv";
static const NSString *uploadObjectKey = @"oiasjdi";
static const NSString *demoHostId = @"oss-cn-qingdao.aliyuncs.com";


@interface YKUserInfoViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, strong) NSArray *titleArray;

@end

@implementation YKUserInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.titleArray = @[@"头像", @"姓名", @"手机"];

    NSLog(@"[YKUserTools getUserInfo] = %@", [YKUserTools getUserInfo]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mainTableView reloadData];
}

- (void)showErrorAlertView {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@""
                                                   message:@"请在iphone的“设置-隐私-相机”选项中，允许访问你的相机。"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [aler show];
}

/**
* 跟新用户头像
*/
- (void)uplodaUserPicSuccessWithUrl:(NSString *)url {
    [YKApiRequestServer changeUserPicWithUrl:url
                                     success:^(YKUserModel *userModel) {
                                         [YKProgressHDTool reminderWithTitle:@"上传成功"];
                                         [self.mainTableView reloadData];
                                     }
                                     failure:^(NSString *error) {
                                         [YKProgressHDTool reminderWithTitle:@"上传失败"];
                                     }];
}

#pragma mark UIImagePickerControllerDelegate

- (void)loadImageWithType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //设置代理
    picker.delegate = self;
    //相机或者相册
    picker.sourceType = type;
    //是否允许编辑
    //NO,直接选取图片
    //YES，选取图片后截取正方形区域
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//在图片选择器重选择了返回按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//选取一张图片之后然后回到这里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //取得选取的这张图片，可以用来传值用
    [YKProgressHDTool showProgressHUD];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //把照片存储服务器上
    [AliOSS uploadImage:image
          usingCallBack:^(BOOL isSuccess, NSString *picUrl, NSError *error) {
              NSLog(@"picUrl = %@", picUrl);
              if (isSuccess) {
                  [self uplodaUserPicSuccessWithUrl:picUrl];
              } else {
                  [YKProgressHDTool hideProgressHUD];
                  [YKProgressHDTool reminderWithTitle:@"上传失败"];
              }
          }
   withProgressCallback:^(float pregress) {

   }];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //相机：0
    //从相册:1
    //判断手机是够支持相机
    switch (buttonIndex) {
        case 0: {

//            NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
//            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//            if (authStatus != AVAuthorizationStatusAuthorized) {
//                [self showErrorAlertView];
//                return;
//            }

            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self loadImageWithType:UIImagePickerControllerSourceTypeCamera];

            } else {
                NSLog(@"打开相机失败");
            }
        }

            break;
        case 1:
            //从相册
        {
//            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
//            if (author != ALAuthorizationStatusAuthorized) {
//                [self showErrorAlertView];
//                return;
//            }
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [self loadImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            else {
                NSLog(@"相册无法打开");
            }
        }

            break;

        default:
            break;
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 65;
    }
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选取图片"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"相机拍摄", @"从相册选取", nil];
        [actionSheet showInView:self.view];
    } else if (indexPath.row == 1) {
        YKUpdataNickNameViewController *updataNickNameViewController = [[YKUpdataNickNameViewController alloc] init];
        [self.navigationController pushViewController:updataNickNameViewController animated:YES];
    } else if (indexPath.row == 2) {

    } else if (indexPath.row == 3) {

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row != 0) {
        YKUserInfoCell *userInfoCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!userInfoCell) {
            userInfoCell = [[YKUserInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                 reuseIdentifier:identifier];
        }
        userInfoCell.title = self.titleArray[(NSUInteger) indexPath.row];
        if (indexPath.row == 1) {
            userInfoCell.info = [YKUserTools getUserInfo].userName;
        } else if (indexPath.row == 2) {
            userInfoCell.arrowIconImageView.hidden = YES;
            userInfoCell.info = [YKUserTools getUserInfo].mobile;
        }
        return userInfoCell;
    } else {
        YKUserHeadPicCell *headPicCell = [tableView dequeueReusableCellWithIdentifier:YKUserHeadPicCellIdentifier];
        if (!headPicCell) {
            headPicCell = [[YKUserHeadPicCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:YKUserHeadPicCellIdentifier];
        }
        headPicCell.title = self.titleArray[(NSUInteger) indexPath.row];
        headPicCell.headPicUrl = [YKUserTools getUserInfo].faceUrl;
        return headPicCell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

@end