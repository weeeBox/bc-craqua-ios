//
//  GLCanvas.h
//  Craqua
//
//  Created by Alex Lementuev on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>

#import "bc.h"

@interface GLCanvas : UIView
{    
@private
    EAGLContext* eaglContext;
    GLuint renderBuffer;
    GLuint frameBuffer;
    
    GLint bufferWidth;
    GLint bufferHeight;
    
    id<TouchDelegate> touchDelegate;
}

@property (nonatomic, assign) id<TouchDelegate> touchDelegate;

- (void)show;
- (void)hide;

- (void)swapBuffers;

@end
