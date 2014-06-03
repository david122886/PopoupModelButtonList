//
//  PopupModelButton.m
//  PopModel
//
//  Created by xxsy-ima001 on 14-6-3.
//  Copyright (c) 2014年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "PopupModelButton.h"

@interface PopupModelButton()
@property (nonatomic,strong) void (^popupFinishedBlock)();
@property (nonatomic,strong) void (^dismissedBlock)(int selectedIndex);
@property (nonatomic,strong) void (^cancelBlock)();
@property (weak, nonatomic) IBOutlet UIView *itemsBackView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButtonClicked:(id)sender;


@end

@implementation PopupModelButton
- (IBAction)backButtonClicked:(id)sender {
    [self setUserInteractionEnabled:NO];
    __weak PopupModelButton *weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        if (weakSelf) {
            if (weakSelf.cancelBlock) {
                weakSelf.cancelBlock();
            }
        }
        [weakSelf removeFromSuperview];
        [weakSelf setUserInteractionEnabled:YES];
        weakSelf.alpha = 1;
    }];
    
}

+(instancetype)defaultPopupModelButton{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PopupModelButton" owner:self options:nil];
    return array[0];
}

+(void)popInViewController:(UIViewController*)controller setButtonItemTitles:(NSArray*)itemTitles withItemWidth:(int)width withPopupFinish:(void (^)())finised withDismissed:(void (^)(int selectedIndex))dismiss withCancel:(void (^)())cancel{
    if (!itemTitles || itemTitles.count <= 0) {
        NSLog(@"PopupModelButton items count == 0");
        return;
    }
    if ([[controller.view.subviews lastObject] isKindOfClass:[PopupModelButton class]]) {
        NSLog(@"PopupModelButton is exist");
        return;
    }
    PopupModelButton *popupModel = [PopupModelButton defaultPopupModelButton];
    popupModel.popupFinishedBlock = finised;
    popupModel.dismissedBlock = dismiss;
    popupModel.frame = [[UIScreen mainScreen] bounds];
    popupModel.cancelBlock = cancel;
    popupModel.itemsBackView.layer.cornerRadius = 5;
    [popupModel setUserInteractionEnabled:NO];
    [controller.view addSubview:popupModel];
    int buttonOriginY = 0;
    int space = 0;
    for (int index = kStartIndex; index < itemTitles.count+kStartIndex; index++) {
        UIButton *item = [PopupModelButton createButtonItemWithIndex:index];
        [item setTitle:itemTitles[index - kStartIndex] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item addTarget:popupModel action:@selector(itemClicled:) forControlEvents:UIControlEventTouchUpInside];
        item.frame  = (CGRect){0,buttonOriginY,width,kbuttonHeight};
        buttonOriginY += kbuttonHeight + space;
        [popupModel.itemsBackView addSubview:item];
    }
    popupModel.itemsBackView.frame = (CGRect){0,0,width,buttonOriginY-space};
    popupModel.itemsBackView.backgroundColor = [UIColor lightGrayColor];
    popupModel.itemsBackView.center = (CGPoint){popupModel.frame.size.width/2,popupModel.frame.size.height/2};
    popupModel.itemsBackView.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        popupModel.itemsBackView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finised) {
            finised();
        }
        [popupModel setUserInteractionEnabled:YES];
    }];
}

-(void)itemClicled:(UIButton*)button{
    [self.superview setUserInteractionEnabled:NO];
    __weak PopupModelButton *weakSelf = self;
    [PopupModelButton imgAnimate:button finished:^{
        if (weakSelf) {
            if (weakSelf.dismissedBlock) {
                weakSelf.dismissedBlock(button.tag - kStartIndex);
            }
        }
        [weakSelf.superview setUserInteractionEnabled:YES];
        [weakSelf removeFromSuperview];
    }];
}

+(UIButton*)createButtonItemWithIndex:(int)index{
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor clearColor];
    button.tag = index;
    return button;
}

///设置动画
+(void)imgAnimate:(UIView*)view finished:(void(^)())finshedBlock{
    [view setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         
         
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.1 animations:
          ^(void){
              
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.05, 1.05);
              
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                   
                   
               } completion:^(BOOL finished){//do other thing
                   [view setUserInteractionEnabled:YES];
                   if (finshedBlock) {
                       finshedBlock();
                   }
               }];
          }];
     }];
    
    
}
@end
