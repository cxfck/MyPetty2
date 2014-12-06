//
//  ExchangeViewController.m
//  MyPetty
//
//  Created by miaocuilin on 14/12/5.
//  Copyright (c) 2014年 AidiGame. All rights reserved.
//

#import "ExchangeViewController.h"
#import "ExchangeCollectionViewCell.h"
@interface ExchangeViewController ()

@end

@implementation ExchangeViewController
//-(void)dealloc
//{
//    [super dealloc];
//    [collection release];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBg];
    [self createCollectionView];
    [self createFakeNavigation];
    [self createBottom];
}
-(void)createBg
{
    UIImageView * imageView = [MyControl createImageViewWithFrame:[UIScreen mainScreen].bounds ImageName:@"blurBg.png"];
    [self.view addSubview:imageView];
}
-(void)createFakeNavigation
{
    navView = [MyControl createViewWithFrame:CGRectMake(0, 0, 320, 64)];
    [self.view addSubview:navView];
    
    UIView * alphaView = [MyControl createViewWithFrame:CGRectMake(0, 0, 320, 64)];
    alphaView.alpha = 0.2;
    alphaView.backgroundColor = ORANGE;
    [navView addSubview:alphaView];
    
    UIImageView * backImageView = [MyControl createImageViewWithFrame:CGRectMake(17, 32, 10, 17) ImageName:@"leftArrow.png"];
    [navView addSubview:backImageView];
    
    UIButton * backBtn = [MyControl createButtonWithFrame:CGRectMake(10, 25, 40, 30) ImageName:@"" Target:self Action:@selector(backBtnClick) Title:nil];
    backBtn.showsTouchWhenHighlighted = YES;
    [navView addSubview:backBtn];
    
    UILabel * titleLabel = [MyControl createLabelWithFrame:CGRectMake(60, 64-20-15, 200, 20) Font:17 Text:@"兑换"];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    
    exBtn = [MyControl createButtonWithFrame:CGRectMake(self.view.frame.size.width-170/2*0.9-10, backImageView.frame.origin.y-4, 170/2*0.9, 54/2*0.9) ImageName:@"exchange_cateBtn.png" Target:self Action:@selector(exBtnClick:) Title:@"种类"];
    exBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [navView addSubview:exBtn];
    
    //小三角
    UIImageView * triangle = [MyControl createImageViewWithFrame:CGRectMake(116/2, (exBtn.frame.size.height-8)/2.0, 10, 8) ImageName:@"5-3.png"];
    [exBtn addSubview:triangle];
}
-(void)createBottom
{
    bottomBg = [MyControl createViewWithFrame:CGRectMake(0, self.view.frame.size.height-161+51, self.view.frame.size.width, 161)];
//    bottomBg.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:bottomBg];
    
    bottomImage = [MyControl createImageViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 96/2.0+51) ImageName:@""];
    bottomImage.image = [[UIImage imageNamed:@"exchange_bottomBg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    [bottomBg addSubview:bottomImage];
    
    UIImageView * foodNumBg = [MyControl createImageViewWithFrame:CGRectMake(12, 3, 312/2, 78/2) ImageName:@"exchange_foodNumBg.png"];
    [bottomImage addSubview:foodNumBg];
    
    UIImageView * orangeFood = [MyControl createImageViewWithFrame:CGRectMake(15, (78/2-30)/2.0, 30, 30) ImageName:@"exchange_orangeFood.png"];
    [foodNumBg addSubview:orangeFood];
    
    UILabel * foodNum = [MyControl createLabelWithFrame:CGRectMake(orangeFood.frame.origin.x+30+5, 0, 90, 78/2.0) Font:20 Text:[USER objectForKey:@"food"]];
    foodNum.textColor = BGCOLOR;
    [foodNumBg addSubview:foodNum];
    
    //
    UIImageView * petBg = [MyControl createImageViewWithFrame:CGRectMake(self.view.frame.size.width-105, bottomImage.frame.origin.y-76/2, 105, 176/2) ImageName:@"exchange_petBg.png"];
    [bottomBg addSubview:petBg];
    
    upButton = [MyControl createButtonWithFrame:CGRectMake(petBg.frame.origin.x+105/2.0-63/4.0, 1, 63/2.0, 59/2.0) ImageName:@"exchange_up.png" Target:self Action:@selector(upButtonClick:) Title:nil];
    [upButton setBackgroundImage:[UIImage imageNamed:@"exchange_down.png"] forState:UIControlStateSelected];
    [bottomBg addSubview:upButton];
    
    headBtn = [MyControl createButtonWithFrame:CGRectMake(petBg.frame.origin.x+26.5, petBg.frame.origin.y+12, 52, 52) ImageName:@"" Target:self Action:@selector(headBtnClick) Title:nil];
    headBtn.layer.cornerRadius = 26;
    headBtn.layer.masksToBounds = YES;
    [bottomBg addSubview:headBtn];
    [headBtn setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", PETTXURL, [USER objectForKey:@"a_tx"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPetHead.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (image) {
            [headBtn setBackgroundImage:[MyControl returnSquareImageWithImage:image] forState:UIControlStateNormal];
        }
    }];
    
    UIImageView * leftArrow = [MyControl createImageViewWithFrame:CGRectMake(8, 64, 9, 15.5) ImageName:@"leftArrow.png"];
    [bottomImage addSubview:leftArrow];
    
    UIImageView * rightArrow = [MyControl createImageViewWithFrame:CGRectMake(self.view.frame.size.width-8-9, 64, 9, 15.5) ImageName:@"rightArrow.png"];
    [bottomImage addSubview:rightArrow];
    
    leftArrowBtn = [MyControl createButtonWithFrame:CGRectMake(leftArrow.frame.origin.x-5, leftArrow.frame.origin.y-10, leftArrow.frame.size.width+10, leftArrow.frame.size.height+20) ImageName:@"" Target:self Action:@selector(leftClick) Title:nil];
//    leftArrowBtn.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [bottomImage addSubview:leftArrowBtn];
    
    rightArrowBtn = [MyControl createButtonWithFrame:CGRectMake(rightArrow.frame.origin.x-5, rightArrow.frame.origin.y-10, rightArrow.frame.size.width+10, rightArrow.frame.size.height+20) ImageName:@"" Target:self Action:@selector(rightClick) Title:nil];
//    rightArrowBtn.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [bottomImage addSubview:rightArrowBtn];
    
//    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
}
-(void)leftClick
{
    NSLog(@"left");
}
-(void)rightClick
{
    NSLog(@"right");
}
-(void)headBtnClick
{
    [self upButtonClick:upButton];
}
-(void)upButtonClick:(UIButton *)btn
{
    CGRect rect = bottomBg.frame;
    if (!btn.selected) {
        //上
        [UIView animateWithDuration:0.2 animations:^{
            bottomBg.frame = CGRectMake(rect.origin.x, self.view.frame.size.height-161, rect.size.width, rect.size.height);
        }];
    }else{
        //下
        [UIView animateWithDuration:0.2 animations:^{
            bottomBg.frame = CGRectMake(rect.origin.x, self.view.frame.size.height-161+51, rect.size.width, rect.size.height);
        }];
    }
    
    btn.selected = !btn.selected;
}
#pragma mark -
-(void)createCollectionView
{
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(276/2, 180);
    
    collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-96/2) collectionViewLayout:flow];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor clearColor];
    [collection registerClass:[ExchangeCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    [self.view addSubview:collection];
    [flow release];
//    [collection release];
}
#pragma mark - collectionDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10+2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"collection";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.row >= 10) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
    }
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
#pragma mark - collectionDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    float a = (self.view.frame.size.width/2.0-276/2)/2.0;
    return UIEdgeInsetsMake(5, a, 5, a);
}
#pragma mark - collectionDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row);
}


#pragma mark -
-(void)exBtnClick:(UIButton *)btn
{
    if (dropDown == nil) {
        CGFloat f = 200;
        navView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64+110);
        dropDown = [[NIDropDown alloc] showDropDown:btn :&f :@[@"所有", @"猫粮", @"狗粮"]];

//        [dropDown setDefaultCellType];
        [dropDown setCellTextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:15] BgColor:[UIColor colorWithRed:246/255.0 green:168/255.0 blue:146/255.0 alpha:0.6] lineColor:[UIColor brownColor]];
        dropDown.delegate = self;
    }else{
        [dropDown hideDropDown:btn];
        [self rel];
    }
}

#pragma mark - delegate
-(void)niDropDownDelegateMethod:(NIDropDown *)sender
{
    if (sender == dropDown) {
        [self rel];
    }
}
-(void)didSelected:(NIDropDown *)sender Line:(int)Line Words:(NSString *)Words
{
    NSLog(@"%d--%@", Line, Words);
}
-(void)rel
{
    navView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
    [dropDown release];
    dropDown = nil;
}
-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
