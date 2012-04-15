//
//  TouchDelegate.h
//  Craqua
//
//  Created by Alex Lementuev on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TouchDelegate <NSObject>

- (void)onPointerPressedX:(int)x Y:(int)y;
- (void)onPointerDraggedX:(int)x Y:(int)y;
- (void)onPointerReleasedX:(int)x Y:(int)y;

@end

