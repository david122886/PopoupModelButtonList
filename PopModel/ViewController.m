//
//  ViewController.m
//  PopModel
//
//  Created by xxsy-ima001 on 14-6-3.
//  Copyright (c) 2014年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "ViewController.h"
#import "PopupModelButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)sss:(id)sender {

    [PopupModelButton popInViewController:self setButtonItemTitles:@[@"a",@"b"] withItemWidth:100 withPopupFinish:nil withDismissed:^(int selectedIndex) {
        NSLog(@"selecetedAtIndex:%d",selectedIndex);
    } withCancel:^{
        NSLog(@"cancel");
        NSLog(@"%@",[self.view subviews]);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
