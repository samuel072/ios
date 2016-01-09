//
//  BlockUIAlertView.h
//  CmsTopMediaCloud
//
//  Created by PengLinmao on 15/4/21.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertBlock)(NSInteger);

@interface BlockUIAlertView : UIAlertView
@property(nonatomic, copy) AlertBlock block;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
        clickButton:(AlertBlock)_block
  otherButtonTitles:(NSString *)otherButtonTitles;

- (id)initWithVersionUpdate:(NSString *)title
                  message:(NSString *)message
        cancelButtonTitle:(NSString *)cancelButtonTitle
              clickButton:(AlertBlock)_block
        otherButtonTitles:(NSString *)otherButtonTitles,...;
@end
