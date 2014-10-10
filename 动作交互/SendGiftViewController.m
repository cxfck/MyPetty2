//
//  SendGiftViewController.m
//  MyPetty
//
//  Created by miaocuilin on 14-9-24.
//  Copyright (c) 2014年 AidiGame. All rights reserved.
//

#import "SendGiftViewController.h"
#import "GiftShopViewController.h"
#import "GiftShopModel.h"
@interface SendGiftViewController ()

@end

@implementation SendGiftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bagItemIdArray = [NSMutableArray arrayWithCapacity:0];
    self.bagItemNumArray = [NSMutableArray arrayWithCapacity:0];
    self.giftArray = [NSMutableArray arrayWithArray:[ControllerManager returnAllGiftsArray]];
    self.tempGiftArray = [NSMutableArray arrayWithArray:self.giftArray];
    
    [self backgroundView];
    [self loadBagData];
//    [self createUI];
}

- (void)backgroundView
{
    UIView *bgView = [MyControl createViewWithFrame:self.view.frame];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
}
#pragma mark - 背包数据
- (void)loadBagData
{
    StartLoading;
    NSString * sig = [MyMD5 md5:[NSString stringWithFormat:@"usr_id=%@dog&cat", [USER objectForKey:@"usr_id"]]];
    NSString * url = [NSString stringWithFormat:@"%@%@&sig=%@&SID=%@", USERGOODSLISTAPI, [USER objectForKey:@"usr_id"], sig, [ControllerManager getSID]];
//    NSLog(@"背包url:%@", url);
    httpDownloadBlock * request = [[httpDownloadBlock alloc] initWithUrlStr:url Block:^(BOOL isFinish, httpDownloadBlock * load) {
        if (isFinish) {
//            NSLog(@"背包物品数据：%@",load.dataDict);
            if ([[load.dataDict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                for (NSString * key in [[load.dataDict objectForKey:@"data"] allKeys]) {
                    [self.bagItemIdArray addObject:key];
                }
                //排序
                for (int i=0; i<self.bagItemIdArray.count; i++) {
                    for (int j=0; j<self.bagItemIdArray.count-i-1; j++) {
                        if ([self.bagItemIdArray[j] intValue] > [self.bagItemIdArray[j+1] intValue]) {
                            NSString * str1 = [NSString stringWithFormat:@"%@", self.bagItemIdArray[j]];
                            NSString * str2 = [NSString stringWithFormat:@"%@", self.bagItemIdArray[j+1]];
                            self.bagItemIdArray[j] = str2;
                            self.bagItemIdArray[j+1] = str1;
                        }
                    }
                }
                //
                for (NSString * str in self.bagItemIdArray) {
                    [self.bagItemNumArray addObject:[[load.dataDict objectForKey:@"data"] objectForKey:str]];
                }
                for(int i=0;i<self.bagItemIdArray.count;i++){
                    if ([self.bagItemNumArray[i] intValue] == 0) {
                        [self.bagItemIdArray removeObjectAtIndex:i];
                        [self.bagItemNumArray removeObjectAtIndex:i];
                        i--;
                    }
                }
            }
            
            //将背包中有的从所有物品中剔除
//            NSLog(@"%d", self.tempGiftArray.count);
            for (int i=0; i<self.tempGiftArray.count; i++) {
                for (int j=0; j<self.bagItemIdArray.count; j++) {
                    if ([[self.tempGiftArray[i] objectForKey:@"no"] isEqualToString:self.bagItemIdArray[j]]) {
                        [self.tempGiftArray removeObjectAtIndex:i];
                        i--;
                        break;
                    }
                }
            }
//            NSLog(@"%d", self.tempGiftArray.count);
            //
            LoadingSuccess;
            [self createBgView];
            [self createUI];
        }else{
            LoadingFailed;
        }
    }];
    [request release];
}
#pragma mark - 搭建页面
-(void)createBgView
{
    totalView = [MyControl createViewWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-212, 300, 425)];
    totalView.layer.cornerRadius = 10;
    totalView.layer.masksToBounds = YES;
    totalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:totalView];
    
    UIImageView *titleView = [MyControl createImageViewWithFrame:CGRectMake(0, 0, 300, 40) ImageName:@"title_bg.png"];
    [totalView addSubview:titleView];
    UILabel *titleLabel = [MyControl createLabelWithFrame:titleView.frame Font:16 Text:@"给Ta送个礼物吧"];
    if (self.receiver_name.length != 0) {
        titleLabel.text = [NSString stringWithFormat:@"给%@送个礼物吧", self.receiver_name];
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [totalView addSubview:titleLabel];
    
    UIImageView *closeImageView = [MyControl createImageViewWithFrame:CGRectMake(260, 10, 20, 20) ImageName:@"30-1.png"];
    [totalView addSubview:closeImageView];
    
    UIButton *closeButton = [MyControl createButtonWithFrame:CGRectMake(252.5, 2.5, 35, 35) ImageName:nil Target:self Action:@selector(closeGiftAction) Title:nil];
    closeButton.showsTouchWhenHighlighted = YES;
    [totalView addSubview:closeButton];
    
    giftPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 310+45, 300, 20)];
    giftPageControl.userInteractionEnabled = NO;
    giftPageControl.numberOfPages =ceilf(self.giftArray.count/9.0);
    giftPageControl.currentPageIndicatorTintColor = BGCOLOR;
    giftPageControl.pageIndicatorTintColor = [UIColor grayColor];
    [totalView addSubview:giftPageControl];
    [giftPageControl release];
    
    UIButton *giftButton = [MyControl createButtonWithFrame:CGRectMake(40, 335+45, 220, 40) ImageName:nil Target:self Action:@selector(goShopping) Title:@"去商城"];
    giftButton.showsTouchWhenHighlighted = YES;
    giftButton.backgroundColor = BGCOLOR;
    giftButton.layer.cornerRadius = 5;
    giftButton.layer.masksToBounds = YES;
    giftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [totalView addSubview:giftButton];
}
-(void)createUI
{

    /***************************/
    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 300, 385-60)];
    sv.delegate = self;
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    [totalView addSubview:sv];
    
    CGSize scrollViewSize = CGSizeMake(300 * ceilf(self.giftArray.count/9.0), sv.frame.size.height);
    [sv setContentSize:scrollViewSize];
    int h = 15;//水平间距
    int v = 10;//垂直间距
    
    for(int i=0;i<self.bagItemIdArray.count+self.tempGiftArray.count;i++){
//        if (i>=self.bagItemIdArray.count) {
//            flag = 0;
//            for (NSString * no in self.bagItemIdArray) {
//                [[self.giftArray[i] objectForKey:@"no"] isEqualToString:no];
//                flag = 1;
//                break;
//            }
//            if (flag == 1) {
//                continue;
//            }
//        }
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(h+i%3*(80+h)+300*(i/9), h+(i/3)%3*(90+v), 80, 90)];
        imageView.image = [UIImage imageNamed:@"product_bg.png"];
        [sv addSubview:imageView];
        [imageView release];
        
        UIImageView *productImageView = [MyControl createImageViewWithFrame:CGRectMake((imageView.frame.size.width-75)/2, 20, 75, 50) ImageName:[NSString stringWithFormat:@"%@.png",[self.giftArray[i] objectForKey:@"no"]]];
        [imageView addSubview:productImageView];
        
        UILabel * productLabel = [MyControl createLabelWithFrame:CGRectMake(0, 10, imageView.frame.size.width, 10) Font:10 Text:[self.giftArray[i] objectForKey:@"name"]];
        productLabel.textAlignment = NSTextAlignmentCenter;
        productLabel.font = [UIFont boldSystemFontOfSize:10];
        productLabel.textColor = [UIColor grayColor];
        [imageView addSubview:productLabel];
        
        UILabel *numberCoinLabel = [MyControl createLabelWithFrame:CGRectMake(38, 75, 50, 10) Font:13 Text:nil];
        numberCoinLabel.textColor =BGCOLOR;
        [imageView addSubview:numberCoinLabel];
        
        UIImageView *coinImageView = [MyControl createImageViewWithFrame:CGRectMake(20, 73, 13, 13) ImageName:@"gold.png"];
        [imageView addSubview:coinImageView];
        
        UILabel *leftCornerLabel1 =[MyControl createLabelWithFrame:CGRectMake(-3, 4, 20, 8) Font:7 Text:@"人气"];
        leftCornerLabel1.textAlignment = NSTextAlignmentCenter;
        leftCornerLabel1.font = [UIFont boldSystemFontOfSize:8];
        CGAffineTransform transform =  CGAffineTransformMakeRotation(-45.0 *M_PI / 180.0);
        leftCornerLabel1.transform = transform;
        
        UILabel *leftCornerLabel2 = [MyControl createLabelWithFrame:CGRectMake(0, 10, 25, 8) Font:9 Text:@"+50"];
        leftCornerLabel2.textAlignment = NSTextAlignmentCenter;
        leftCornerLabel2.transform = transform;
        [imageView addSubview:leftCornerLabel1];
        [imageView addSubview:leftCornerLabel2];
        
//        GiftShopModel *model = self.giftArray[i];
        if (i>=self.bagItemIdArray.count) {
            productImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [self.tempGiftArray[i-self.bagItemIdArray.count] objectForKey:@"no"]]];
            productLabel.text = [self.tempGiftArray[i-self.bagItemIdArray.count] objectForKey:@"name"];
            numberCoinLabel.text = [self.tempGiftArray[i-self.bagItemIdArray.count] objectForKey:@"price"];
            if ([[self.tempGiftArray[i-self.bagItemIdArray.count] objectForKey:@"add_rq"] rangeOfString:@"-"].location == NSNotFound) {
                leftCornerLabel2.text = [NSString stringWithFormat:@"+%@", [self.tempGiftArray[i-self.bagItemIdArray.count] objectForKey:@"add_rq"]];
            }else{
                leftCornerLabel2.text = [self.tempGiftArray[i-self.bagItemIdArray.count] objectForKey:@"add_rq"];
            }
            
        }else{
            productImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.bagItemIdArray[i]]];
            productLabel.text = [[ControllerManager returnGiftDictWithItemId:self.bagItemIdArray[i]] objectForKey:@"name"];
            numberCoinLabel.text = [NSString stringWithFormat:@"X %@", self.bagItemNumArray[i]];
            coinImageView.image = [UIImage imageNamed:@"giftIcon.png"];
            if ([[[ControllerManager returnGiftDictWithItemId:self.bagItemIdArray[i]] objectForKey:@"add_rq"] rangeOfString:@"-"].location == NSNotFound) {
                leftCornerLabel2.text = [NSString stringWithFormat:@"+%@", [[ControllerManager returnGiftDictWithItemId:self.bagItemIdArray[i]] objectForKey:@"add_rq"]];
            }else{
                leftCornerLabel2.text = [[ControllerManager returnGiftDictWithItemId:self.bagItemIdArray[i]] objectForKey:@"add_rq"];
            }
        }
        
//        NSLog(@"rq:%d",[[self.giftArray[i] objectForKey:@"add_rq"] intValue]);
        
        
        
        UIButton * button = [MyControl createButtonWithFrame:imageView.frame ImageName:nil Target:self Action:@selector(clickBtn:) Title:nil];
        [sv addSubview:button];
        button.tag = 1000+i;
    }
    /*****************************/
    
    
}
#pragma mark - 点击事件
-(void)goShopping
{
    NSLog(@"去商城");
    GiftShopViewController *vc = [[GiftShopViewController alloc] init];
    vc.isQuick = YES;
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
-(void)clickBtn:(UIButton *)btn;
{
    if (btn.tag-1000 >= self.bagItemIdArray.count) {
        //购买赠送
        NSLog(@"%@", [self.tempGiftArray[btn.tag-1000-self.bagItemIdArray.count] objectForKey:@"name"]);
        [self buyGiftWithItemId:[self.tempGiftArray[btn.tag-1000-self.bagItemIdArray.count] objectForKey:@"no"]];
    }else{
        //直接赠送
        NSLog(@"%@", [[ControllerManager returnGiftDictWithItemId:self.bagItemIdArray[btn.tag-1000]] objectForKey:@"name"]);
        [self sendGiftWithItemId:self.bagItemIdArray[btn.tag-1000] fromBag:YES];
    }
    
}
#pragma mark - 买礼物
-(void)buyGiftWithItemId:(NSString *)ItemId
{
    StartLoading;
    NSString *sig = [MyMD5 md5:[NSString stringWithFormat:@"item_id=%@&num=1dog&cat", ItemId]];
    NSString * url = [NSString stringWithFormat:@"%@%@&num=1&sig=%@&SID=%@",BUYSHOPGIFTAPI, ItemId, sig, [ControllerManager getSID]];
    NSLog(@"%@", url);
    httpDownloadBlock *request = [[httpDownloadBlock alloc] initWithUrlStr:url Block:^(BOOL isFinish, httpDownloadBlock *load) {
        if (isFinish) {
            //user_gold是NSNumber类型
            [USER setObject:[NSString stringWithFormat:@"%@",[[load.dataDict objectForKey:@"data"] objectForKey:@"user_gold"]] forKey:@"gold"];
            
            [self sendGiftWithItemId:ItemId fromBag:NO];
        }else{
            
        }
    }];
    [request release];
}

#pragma mark - 送礼物
-(void)sendGiftWithItemId:(NSString *)ItemId fromBag:(BOOL)fromBag
{
    StartLoading;
    NSString * url = nil;
    
    if (self.receiver_img_id) {
        NSString * sig = [MyMD5 md5:[NSString stringWithFormat:@"aid=%@&img_id=%@&item_id=%@dog&cat", self.receiver_aid, self.receiver_img_id, ItemId]];
        url = [NSString stringWithFormat:@"%@%@&img_id=%@&item_id=%@&sig=%@&SID=%@", SENDSHAKEGIFT, self.receiver_aid, self.receiver_img_id, ItemId, sig, [ControllerManager getSID]];
    }else{
        NSString * sig = [MyMD5 md5:[NSString stringWithFormat:@"aid=%@&item_id=%@dog&cat", self.receiver_aid, ItemId]];
        url = [NSString stringWithFormat:@"%@%@&item_id=%@&sig=%@&SID=%@", SENDSHAKEGIFT, self.receiver_aid,ItemId, sig, [ControllerManager getSID]];
    }
    
    NSLog(@"赠送url:%@",url);
    httpDownloadBlock *request  = [[httpDownloadBlock alloc] initWithUrlStr:url Block:^(BOOL isFinish, httpDownloadBlock * load) {
        if (isFinish) {
            if (fromBag) {
                for (int i=0; self.bagItemIdArray.count; i++) {
                    if ([self.bagItemIdArray[i] isEqualToString:ItemId]) {
                        int a = [self.bagItemNumArray[i] intValue]-1;
                        if (a == 0) {
                            //背包中移除
                            [self.bagItemIdArray removeObjectAtIndex:i];
                            [self.bagItemNumArray removeObjectAtIndex:i];
                            //重新赋值tempGiftArray
                            self.tempGiftArray = [NSMutableArray arrayWithArray:self.giftArray];
                            //将背包中有的从tempGiftArray中剔除
                            for (int i=0; i<self.tempGiftArray.count; i++) {
                                for (int j=0; j<self.bagItemIdArray.count; j++) {
                                    if ([[self.tempGiftArray[i] objectForKey:@"no"] isEqualToString:self.bagItemIdArray[j]]) {
                                        [self.tempGiftArray removeObjectAtIndex:i];
                                        i--;
                                        break;
                                    }
                                }
                            }
                            break;
                        }else{
                            self.bagItemNumArray[i] = [NSString stringWithFormat:@"%d", [self.bagItemNumArray[i] intValue]-1];
                            break;
                        }
                        
                    }
                }
                //刷新页面
                [sv removeFromSuperview];
                [self createUI];
                //
                [ControllerManager HUDText:[NSString stringWithFormat:@"恭喜您，赠送 %@ 成功!", [[ControllerManager returnGiftDictWithItemId:ItemId] objectForKey:@"name"]] showView:self.view yOffset:-60];
            }else{
                //非背包物品
                [ControllerManager HUDText:[NSString stringWithFormat:@"恭喜您，购买并赠送 %@ 成功!", [[ControllerManager returnGiftDictWithItemId:ItemId] objectForKey:@"name"]] showView:self.view yOffset:-60];
            }
            int newexp = [[[load.dataDict objectForKey:@"data"] objectForKey:@"exp"] intValue];
            int exp = [[USER objectForKey:@"exp"] intValue];
            [USER setObject:[[load.dataDict objectForKey:@"data"] objectForKey:@"exp"] forKey:@"exp"];
            if (exp != newexp && (newexp - exp)>0) {
                int index = newexp - exp;
                [ControllerManager HUDImageIcon:@"Star.png" showView:self.view yOffset:0 Number:index];
            }
            //送礼block
            self.hasSendGift();
            [MMProgressHUD dismissWithSuccess:@"赠送成功" title:nil afterDelay:0.1];
        }else{
            
        }
    }];
    [request release];
}
-(void)closeGiftAction
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
#pragma mark -
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    giftPageControl.currentPage = index;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
