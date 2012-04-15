//
//  Application.h
//  Craqua
//
//  Created by Alex Lementuev on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "bc.h"

@interface Application : NSObject<TouchDelegate>
{
@private
    BOOL running;
    BOOL suspended;
    
    NSTimer *timer;
}

- (void)start;
- (void)suspend;
- (void)resume;
- (void)stop;

- (BOOL)isSuspended;

+ (Application *)sharedInstance;

@end
