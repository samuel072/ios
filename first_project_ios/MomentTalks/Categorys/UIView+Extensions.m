//
//  UIView+Extensions.m
//  17Snooker
//
//  Created by TangTao on 14-4-22.
//  Copyright (c) 2014年 LookMedia-China. All rights reserved.
//

@implementation UIView (Extensions)
- (float)x {
    return self.frame.origin.x;
}

- (float)yh {
    return self.frame.origin.y + self.frame.size.height;
}

- (float)xw {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYh:(float)yh {

}

- (void)setXw:(float)xw {
}

- (void)setX:(float)newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (float)y {
    return self.frame.origin.y;
}

- (void)setY:(float)newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (float)width {
    return self.frame.size.width;
}

- (void)setWidth:(float)newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (float)height {
    return self.frame.size.height;
}

- (void)setHeight:(float)newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}


- (void)clearView {
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}

- (void)removeViewWithTag:(NSInteger)viewTag {
    UIView *view = [self viewWithTag:viewTag];
    [view removeFromSuperview];
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

@end
