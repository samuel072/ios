//
//  XCProgressSlider.m
//  XCProgressSlider
//
//  Created by wxc on 14-7-11.
//  Copyright (c) 2014年 wxc. All rights reserved.
//

#import "XCProgressSlider.h"

const NSUInteger XCProgressSliderDragViewTag = 8891;

#define XCSliderThumbSize (10)

@interface XCProgressSlider () {
    UIImageView *_maxImageView;
    UIImageView *_minImageView;
    UIImageView *_thumbImageView;
    UIImageView *_progressImageView;

    UIView *_dragView;

    CGFloat _pWidth;
    CGFloat _thumbSize;
    CGFloat _dragSize;
}
@end

@implementation XCProgressSlider
@synthesize progress = _progress;
@synthesize value = _value;
@synthesize maximumTrackTintColor = _maximumTrackTintColor, minimumTrackTintColor = _minimumTrackTintColor, thumbTintColor = _thumbTintColor, progressTintColor = _progressTintColor;
@synthesize maximumTrackImage = _maximumTrackImage, minimumTrackImage = _minimumTrackImage, thumbImage = _thumbImage, progressImage = _progressImage;
@synthesize height = _height;
@synthesize delegate = _delegate;

- (void)dealloc {
    [_maximumTrackTintColor release];
    [_minimumTrackTintColor release];
    [_thumbTintColor release];
    [_progressTintColor release];
    [_maximumTrackImage release];
    [_minimumTrackImage release];
    [_thumbImage release];
    [_progressImage release];
    [super dealloc];
}


//- (id)init {
//    if (self = [super init]) {
//        _thumbSize = XCSliderThumbSize;
//        self.height = 4;
//        [self initView];
//        self.maximumTrackTintColor = [UIColor whiteColor];
//        self.progressTintColor = [UIColor grayColor];
//        self.minimumTrackTintColor = [UIColor redColor];
//        self.thumbTintColor = [UIColor whiteColor];
//        [self addPanGesture];
//    }
//
//    return  self;
//}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _thumbSize = XCSliderThumbSize;
        _dragSize = 30;
        self.height = 4;
        [self initView];
        self.maximumTrackTintColor = [UIColor whiteColor];
        self.progressTintColor = [UIColor grayColor];
        self.minimumTrackTintColor = [UIColor redColor];
        self.thumbTintColor = [UIColor whiteColor];
        [self addPanGesture];
    }
    return self;
}

- (void)addPanGesture {
    UIPanGestureRecognizer *recognizer;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(thumbSwipe:)];
    [_dragView addGestureRecognizer:recognizer];
    [recognizer release];
    _dragView.userInteractionEnabled = YES;
}

- (void)initView {
    _maxImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _maxImageView.backgroundColor = [UIColor whiteColor];
    _progressImageView = [[UIImageView alloc] init];
    _minImageView = [[UIImageView alloc] init];

    [self addSubview:_maxImageView];
    [self addSubview:_progressImageView];
    [self addSubview:_minImageView];
    [_maxImageView release];
    [_progressImageView release];
    [_minImageView release];

    _thumbImageView = [[UIImageView alloc] init];
    [self addSubview:_thumbImageView];
    [_thumbImageView release];

    _dragView = [[UIView alloc] init];
    _dragView.tag = XCProgressSliderDragViewTag;
    _dragView.backgroundColor = [UIColor clearColor];
    [self addSubview:_dragView];
    [_dragView release];


    [self loadFrame];
}

- (void)changeView {
    _maxImageView.frame = self.bounds;
    [self loadFrame];
}

- (void)loadFrame {
    _pWidth = self.frame.size.width - _thumbSize;

    CGFloat x = _thumbSize / 2;
    CGFloat y = self.frame.size.height / 2 - self.height / 2;

    _maxImageView.frame = CGRectMake(x, y, self.frame.size.width - _thumbSize / 2, self.height);
    _progressImageView.frame = CGRectMake(x, y, (_progress * self.frame.size.width), self.height);
    _minImageView.frame = CGRectMake(x, y, (_value * _pWidth), self.height);

    _thumbImageView.bounds = CGRectMake(0, 0, _thumbSize, _thumbSize);
    _dragView.bounds = CGRectMake(0, 0, _dragSize, _dragSize);
    _thumbImageView.center = CGPointMake((_value * _pWidth) + (_thumbSize / 2), self.frame.size.height / 2);
    _dragView.center = _thumbImageView.center;
}

- (void)thumbSwipe:(UIPanGestureRecognizer *)recognizer {
    if ([(UIPanGestureRecognizer *) recognizer state] == UIGestureRecognizerStateBegan) {
        if ([_delegate respondsToSelector:@selector(progressSliderDidStart:value:)]) {
            NSLog(@"...UIGestureRecognizerStateBegan...");
            [_delegate progressSliderDidStart:self value:_value];
        }
    }
    if ([(UIPanGestureRecognizer *) recognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint curPoint = [recognizer locationInView:self];
        if (curPoint.x < XCSliderThumbSize / 2 || curPoint.x > _pWidth + XCSliderThumbSize / 2) {
            return;
        }
        _thumbImageView.center = CGPointMake(curPoint.x, _thumbImageView.center.y);
        _dragView.center = _thumbImageView.center;
        _minImageView.frame = CGRectMake(_minImageView.frame.origin.x, _minImageView.frame.origin.y, _thumbImageView.center.x, _minImageView.frame.size.height);
        _value = [self transformXToValue:_thumbImageView.center.x];
        if ([_delegate respondsToSelector:@selector(progressSliderChange:value:)]) {
            [_delegate progressSliderChange:self value:_value];
        }
    }

    if ([(UIPanGestureRecognizer *) recognizer state] == UIGestureRecognizerStateEnded) {
        NSLog(@"...UIGestureRecognizerStateEnded...");

        if (_thumbImageView.center.x <= XCSliderThumbSize / 2) {
            _value = 0.0f;
            _thumbImageView.center = CGPointMake(XCSliderThumbSize / 2, _thumbImageView.center.y);
            _dragView.center = _thumbImageView.center;
        }
        else if (_thumbImageView.center.x >= _pWidth + XCSliderThumbSize / 2) {
            _value = 1.0f;
            _thumbImageView.center = CGPointMake(_pWidth + XCSliderThumbSize / 2, _thumbImageView.center.y);
            _dragView.center = _thumbImageView.center;
        }
        if ([_delegate respondsToSelector:@selector(progressSliderDidMoveEnd:value:)]) {
            [_delegate progressSliderDidMoveEnd:self value:_value];
        }
    }


}

#pragma mark -
#pragma mark color

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    if (_maximumTrackTintColor != maximumTrackTintColor) {
        [_maximumTrackTintColor release];
        _maximumTrackTintColor = [maximumTrackTintColor retain];

        _maxImageView.backgroundColor = _maximumTrackTintColor;
    }
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    if (_minimumTrackTintColor != minimumTrackTintColor) {
        [_minimumTrackTintColor release];
        _minimumTrackTintColor = [minimumTrackTintColor retain];

        _minImageView.backgroundColor = _minimumTrackTintColor;
    }
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    if (_progressTintColor != progressTintColor) {
        [_progressTintColor release];
        _progressTintColor = [progressTintColor retain];

        _progressImageView.backgroundColor = _progressTintColor;
    }
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    if (_thumbTintColor != thumbTintColor) {
        [_thumbTintColor release];
        _thumbTintColor = [thumbTintColor retain];

        _thumbImageView.image = [self drawDefImage:_thumbImageView.frame.size color:thumbTintColor];
    }
}

#pragma mark -
#pragma mark value

- (void)setProgress:(float)progress {
    if (_progress != progress) {
        _progress = progress;

        _progressImageView.frame = CGRectMake(_progressImageView.frame.origin.x, _progressImageView.frame.origin.y, [self transformValueToX:progress], _progressImageView.frame.size.height);

    }
}

- (void)setValue:(float)value {
    if (_value != value) {
        _value = value;
        float x = [self transformValueToX:value];
        _minImageView.frame = CGRectMake(_minImageView.frame.origin.x, _minImageView.frame.origin.y, x, _minImageView.frame.size.height);
        _thumbImageView.center = CGPointMake(x, _thumbImageView.center.y);
        _dragView.center = _thumbImageView.center;
    }
}

- (void)setHeight:(float)height {
    if (_height != height) {
        _height = height;
        [self loadFrame];
    }
}

#pragma mark -
#pragma mark setImage

- (void)setThumbImage:(UIImage *)thumbImage {
    if (_thumbImage != thumbImage) {
        [_thumbImage release];
        _thumbImage = [thumbImage retain];

        _thumbSize = thumbImage.size.width;
        _thumbImageView.image = _thumbImage;

        [self loadFrame];
    }
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
    if (_maximumTrackImage != maximumTrackImage) {
        [_maximumTrackImage release];
        _maximumTrackImage = [maximumTrackImage retain];

        _maxImageView.image = _maximumTrackImage;
    }
}

- (void)setProgressImage:(UIImage *)progressImage {
    if (_progressImage != progressImage) {
        [_progressImage release];
        _progressImage = [progressImage retain];

        _progressImageView.image = _progressImage;
    }
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
    if (_minimumTrackImage != minimumTrackImage) {
        [_minimumTrackImage release];
        _minimumTrackImage = [minimumTrackImage retain];

        _minImageView.image = _minimumTrackImage;
    }
}

#pragma mark -
#pragma mark kit

- (CGFloat)transformValueToX:(float)x {
    return (_pWidth * x) + XCSliderThumbSize / 2;
}

- (float)transformXToValue:(CGFloat)x {
    return (x - XCSliderThumbSize / 2) / _pWidth;
}

- (UIImage *)drawDefImage:(CGSize)size color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *p = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width / 2];
    [color setFill];
    [p fill];
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}
@end
