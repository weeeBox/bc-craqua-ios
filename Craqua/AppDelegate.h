//
//  AppDelegate.h
//  Craqua
//
//  Created by Alex Lementuev on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Application.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
@private
    Application* app;
}

@property (strong, nonatomic) UIWindow *window;

@end
