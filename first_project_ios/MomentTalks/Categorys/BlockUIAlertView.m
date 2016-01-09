//
//  BlockUIAlertView.m
//  CmsTopMediaCloud
//
//  Created by PengLinmao on 15/4/21.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import "BlockUIAlertView.h"

@implementation BlockUIAlertView

@synthesize block;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
        clickButton:(AlertBlock)_block
  otherButtonTitles:(NSString *)otherButtonTitles {

    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];

    if (self) {
        self.block = _block;
    }

    return self;
}

- (id)initWithVersionUpdate:(NSString *)title
                    message:(NSString *)message
          cancelButtonTitle:(NSString *)cancelButtonTitle
                clickButton:(AlertBlock)_block
          otherButtonTitles:(NSString *)otherButtonTitles, ... {

    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:@"升级", nil];

    if (self) {
        self.block = _block;
    }

    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.block(buttonIndex);
}

@end
