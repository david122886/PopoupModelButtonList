//
//  PopupModelButton.h
//  PopModel
//
//  Created by xxsy-ima001 on 14-6-3.
//  Copyright (c) 2014年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kbuttonHeight 44
#define kStartIndex 78756
@interface PopupModelButton : UIView
+(instancetype)defaultPopupModelButton;
+(void) popInViewController:(UIViewController*)controller setButtonItemTitles:(NSArray*)itemTitles withItemWidth:(int)width withPopupFinish:(void (^)())finised withDismissed:(void (^)(int selectedIndex))dismiss withCancel:(void (^)())cancel;
@end
