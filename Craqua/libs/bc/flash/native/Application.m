//
//  Application.m
//  Craqua
//
//  Created by Alex Lementuev on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Application.h"

static Application* instance;

@interface Application (Private)

- (void)onTick;

@end

@implementation Application

- (id)init
{
    self = [super init];
    if (self)
    {
        instance = self;
    }
    return self;
}

- (void)dealloc
{
    instance = nil;
    [super dealloc];
}

- (void)onTick
{
}

- (void)start
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0f target:self selector:@selector(onTick) userInfo:nil repeats:YES];
}

- (void)stop
{
    [timer invalidate];
    timer = nil;
}

- (void)suspend
{
    ASSERT(!suspended);
    suspended = true;
}

- (void)resume
{
    ASSERT(suspended);
    suspended = false;
}

- (BOOL)isSuspended
{
    return suspended;
}

#pragma mark - TouchDelegate

- (void)onPointerPressedX:(int)x Y:(int)y
{
    
}

- (void)onPointerDraggedX:(int)x Y:(int)y
{
    
}

- (void)onPointerReleasedX:(int)x Y:(int)y
{
    
}

#pragma mark - Instance

+ (Application *)sharedInstance
{
    ASSERT(!instance);
    return instance;
}

@end
