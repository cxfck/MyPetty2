//
//  TMQuiltView
//
//  Created by Bruno Virlet on 7/20/12.
//
//  Copyright (c) 2012 1000memories

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//


#import "TMPhotoQuiltViewCell.h"

const CGFloat kTMPhotoQuiltViewMargin = 0;

@implementation TMPhotoQuiltViewCell

//@synthesize photoView = _photoView;
//@synthesize titleLabel = _titleLabel;

- (void)dealloc {
//    [_photoView release], _photoView = nil;
//    [_titleLabel release], _titleLabel = nil;
    
    [super dealloc];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{
    _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-35)];
//    [MyControl createImageViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-35) ImageName:@""];
//    [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-35)];
    _photoView.clipsToBounds = YES;
    [self addSubview:_photoView];
    [_photoView release];
    
    self.titleLabel = [MyControl createLabelWithFrame:CGRectMake(4, self.frame.size.height - 18, self.frame.size.width-8, 0) Font:12 Text:nil];
//    self.titleLabel.numberOfLines = 1;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
//    self.titleLabel.adjustsFontSizeToFitWidth = NO;
    
    [self addSubview:self.titleLabel];
}

-(void)configUI:(PhotoModel *)model
{
    cmtHeight = model.cmtHeight;
    cmtWidth = model.cmtWidth;
    
<<<<<<< HEAD
    NSURL * URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGEURL, model.url]];
//    SDWebImageManager * manager = [SDWebImageManager sharedManager];
//    [manager downloadWithURL:URL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//        if (image) {
//            if (image.size.width>2000 || image.size.height>2000) {
//                _photoView.image = [UIImage imageWithData:[MyControl scaleToSize:image]];
//            }else{
//                _photoView.image = image;
//            }
//            
//        }else{
//            [_photoView setImage:[UIImage imageNamed:@"water_white.png"]];
//        }
//    }];
    [_photoView setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"water_white.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
<<<<<<< HEAD

//        if (image.size.width>3500 || image.size.height>3500) {
//            [self performSelectorInBackground:@selector(modifyImage:) withObject:image];
//        }

        
        if (image.size.width>2000 || image.size.height>2000) {
            [self performSelectorInBackground:@selector(modifyImage:) withObject:image];
=======
        if (image.size.width>2500 || image.size.height>2500) {
//            NSLog(@"waterflow pic size is %f--%f", image.size.width, image.size.height);
            [MyControl thumbnailWithImage:image ImageView:_photoView TargetLength:2500.0f];
//            [blockSelf receiveImage:image];
>>>>>>> dev-miao
        }
    }];
    
    
//    if (!cmtHeight) {
//        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-35);
//        self.titleLabel.frame = CGRectMake(4, self.frame.size.height - 18, self.frame.size.width-8, 0);
//    }else{
//        NSLog(@"%f--%f--%@", cmtHeight, cmtHeight-10-18, self.titleLabel.text);
//        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-cmtHeight);
//        self.titleLabel.frame = CGRectMake(4, self.frame.size.height - cmtHeight + 10, self.frame.size.width-8, cmtHeight-10-18);
//    }
    
//    if (!model.cmtHeight) {
//        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-35);
//    }else{
//        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-model.cmtHeight);
//        self.titleLabel.frame = CGRectMake(kTMPhotoQuiltViewMargin+4, self.bounds.size.height - 30 - kTMPhotoQuiltViewMargin, self.frame.size.width-8, 40);
//    }
    
//    NSLog(@"%@", self.titleLabel.text);
    
    //解析点赞者字符串，与[USER objectForKey:@"usr_id"]对比
//    if(![model.likers isKindOfClass:[NSNull class]]){
//        self.likersArray = [model.likers componentsSeparatedByString:@","];
//        
//        for(NSString * str in self.likersArray){
//            if ([str isEqualToString:[USER objectForKey:@"usr_id"]]) {
//                isLike = YES;
//                break;
//            }
//        }
//    }
//    NSLog(@"%@--%@", model.likers, self.likersArray);
    
//    if (isLike) {
//
//        self.heart.image = [UIImage imageNamed:@"11-2.png"];
//        self.heartButton.selected = YES;
//        isLike = NO;
//    }
=======
    NSURL * URL = [MyControl returnThumbImageURLwithName:model.url Width:[UIScreen mainScreen].bounds.size.width Height:0];

    [_photoView setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"water_white.png"]];
>>>>>>> dev-miao
}
<<<<<<< HEAD
-(void)modifyImage:(UIImage *)tempImage
{
//    if (tempImage.size.width>2000 || tempImage.size.height>2000) {

//        NSLog(@"********超过3500！********");
//        float w = tempImage.size.width;
//        float h = tempImage.size.height;
//        float p = 0;
//        if (w>h && tempImage.size.width>3500) {
//            p = 2000/w;
//        }else if(h>w && tempImage.size.height>3500){

        NSLog(@"********超过2000！********");
        float w = tempImage.size.width;
        float h = tempImage.size.height;
        float p = 0;
        if (w>h && tempImage.size.width>2000) {
            p = 2000/w;
        }else if(h>w && tempImage.size.height>2000){

            p = 2000/h;
        }
        w *= p;
        h *= p;
        NSLog(@"%f--%f", w, h);
//    tempImage.size.width/2.0, tempImage.size.height/2.0
        _photoView.image = [MyControl thumbnailWithImageWithoutScale:tempImage size:CGSizeMake(w, h)];
//    [tempImage release];
//        _photoView.image = tempImage;
//        tempImage = nil;
//    }
//    __block UIImage * tempImage = image;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if (tempImage) {
//            if (tempImage.size.width>2000 || tempImage.size.height>2000) {
//                tempImage = [[MyControl thumbnailWithImageWithoutScale:image size:CGSizeMake(tempImage.size.width/2.0, tempImage.size.height/2.0)] retain];
//                                float w = image.size.width;
//                                float h = image.size.height;
//                                float p = 0;
//                                if (w>h && image.size.width>2000) {
//                                    p = 2000/w;
//                                }else if(h>w && image.size.height>2000){
//                                    p = 2000/h;
//                                }
//                                w *= p;
//                                h *= p;
//                //                _photoView.image = [MyControl thumbnailWithImageWithoutScale:image size:CGSizeMake(w, h)];
//            }
//            //                else{
//            //                    _photoView.image = image;
//            //                }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _photoView.image = tempImage;
//        });
//    });
}
=======
>>>>>>> dev-miao


- (void)layoutSubviews {

    if (!cmtHeight) {
        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-35);
        self.titleLabel.frame = CGRectMake(4, self.frame.size.height - 18, self.frame.size.width-8, 0);
    }else{
//        NSLog(@"%f--%f--%@", cmtHeight, cmtHeight-10-18, self.titleLabel.text);
        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-cmtHeight);
        self.titleLabel.frame = CGRectMake(4, self.frame.size.height - cmtHeight + 10, self.frame.size.width-8, cmtHeight-10-18);
    }
//    self.titleLabel.frame = CGRectMake(kTMPhotoQuiltViewMargin+4, self.bounds.size.height - 30 - kTMPhotoQuiltViewMargin, self.frame.size.width-8, 7);
}

@end
