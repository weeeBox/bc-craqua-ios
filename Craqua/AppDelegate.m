//
//  AppDelegate.m
//  Craqua
//
//  Created by Alex Lementuev on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "GLCanvas.h"
#import "AppViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.statusBarHidden = YES;
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window makeKeyAndVisible];
    
    GLCanvas* view = [[GLCanvas alloc] initWithFrame:self.window.frame];
    
    AppViewController *controller = [[AppViewController alloc] init];
    controller.view = view;    
    self.window.rootViewController = controller;
    [self.window addSubview:view];
    [controller release];
    
    app = [[Application alloc] init];
    view.touchDelegate = app;
    
    [self.window addSubview:view];
    [view show];
    
    [app start];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [app suspend];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [app resume];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [app stop];
    [app release];
    app = nil;
}

@end
