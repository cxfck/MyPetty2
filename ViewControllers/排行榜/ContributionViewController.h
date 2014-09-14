//
//  ContributionViewController.h
//  MyPetty
//
//  Created by miaocuilin on 14-8-29.
//  Copyright (c) 2014年 AidiGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface ContributionViewController : UIViewController <NIDropDownDelegate,UITableViewDataSource,UITableViewDelegate
>
{
    UIImageView * bgImageView;
    UIView * navView;
    UIView * headerView;
    UIButton * raceBtn;
    UIButton * titleBtn;
    UIButton * findMeBtn;
    UIButton * arrow;
    BOOL isRaceShow;
    
    NIDropDown *dropDown2;
    
    UITableView * tv;
    UITableView * tv2;
    
    int myCurrentCountNum;
    int count;
    
    int myRanking;
}
@property (nonatomic,retain)NSMutableArray * titleArray;

@property (nonatomic,retain)NSMutableArray * myCountryRankArray;
@property (nonatomic,retain)NSMutableArray * contributionDataArray;

//@property (nonatomic,retain)NSMutableArray * usr_idsArray;
//@property (nonatomic,retain)NSMutableArray * myCountryArray;
@end
