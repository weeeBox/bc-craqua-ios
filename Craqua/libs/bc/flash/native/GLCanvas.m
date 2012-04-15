//
//  GLCanvas.m
//  Craqua
//
//  Created by Alex Lementuev on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GLCanvas.h"

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/ES1/glext.h>

@interface GLCanvas (Private)

- (EAGLContext *)createEAGLContext;
- (BOOL)createFrameBuffer;
- (void)destroyFrameBuffer;
- (void)setDefaultProjection;

@end

@implementation GLCanvas

@synthesize touchDelegate;

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        eaglLayer.opaque = true;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking,
                                        kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat, 
                                        nil];
        
        eaglContext = [self createEAGLContext];
        if (!eaglContext || ![EAGLContext setCurrentContext:eaglContext])
        {
            assert(false);
            [self release];
            return nil;
        }
    }
    return self;
}

- (void)show
{
    [EAGLContext setCurrentContext:eaglContext];
    [self destroyFrameBuffer];
    [self createFrameBuffer];    
}

- (void)hide
{
    [self destroyFrameBuffer];
}

- (void)swapBuffers
{
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer);
	[eaglContext presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL)createFrameBuffer
{
    glGenFramebuffersOES(1, &frameBuffer);
    glGenRenderbuffersOES(1, &renderBuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, frameBuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer);
    [eaglContext renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, renderBuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &bufferWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &bufferHeight);
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) 
	{
        return NO;
    }
	
	[self setDefaultProjection];
    
    glEnableClientState(GL_VERTEX_ARRAY);	
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
    return YES;
}

- (void)destroyFrameBuffer
{
    glDisableClientState(GL_VERTEX_ARRAY);	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    glDeleteFramebuffersOES(1, &frameBuffer);
    frameBuffer = 0;
    glDeleteRenderbuffersOES(1, &renderBuffer);
    renderBuffer = 0;
}

- (void)setDefaultProjection
{
    glViewport(0, 0, bufferWidth, bufferHeight);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrthof(0.0f, bufferWidth, bufferHeight, 0.0f, -1.0f, 1.0f);
    glMatrixMode(GL_MODELVIEW);		
}

- (EAGLContext *)createEAGLContext
{
    return [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
}

# pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint p = [touch locationInView:self];
        [touchDelegate onPointerPressedX:p.x Y:p.y];
        break;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint p = [touch locationInView:self];
        [touchDelegate onPointerDraggedX:p.x Y:p.y];
        break;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint p = [touch locationInView:self];
        [touchDelegate onPointerReleasedX:p.x Y:p.y];
        break;
    }
}

@end
