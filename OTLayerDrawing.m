//
//  OTLayerDrawing.m
//  OTPieViewExam
//
//  Created by Hank0272 on 12/11/19.
//  Copyright (c) 2012年 Ortery Technology, Inc. All rights reserved.
//

#import "OTLayerDrawing.h"

@implementation OTLayerDrawing

@synthesize layer1, layer2;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setWantsLayer:YES];
        layer1 = [CALayer layer];
        layer1.name = @"Layer1";
        layer2 = [CALayer layer];
        layer2.name = @"Layer2";
        self.layer.frame = self.frame; //CGRectMake(0, 0, 320, 180);
        [layer2 setBackgroundColor:CGColorCreateFromNSColor([NSColor whiteColor], CGColorSpaceCreateDeviceRGB())];
        [self.layer addSublayer:layer2];
        self.layer.frame = CGRectMake(30, 60, 260, 160);
        [layer1 setBackgroundColor:CGColorCreateFromNSColor([NSColor lightGrayColor], CGColorSpaceCreateDeviceRGB())];
        [self.layer addSublayer:layer1];
        
        [layer1 setHidden:NO];
        [layer2 setHidden:NO];

    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

static CGFloat randomFloat()
{
    CGFloat f = (rand() % RAND_MAX) / (float)(RAND_MAX);
    return f;
}

static CGPoint randomPointInBounds(CGRect bounds)
{
	CGFloat x = randomFloat() * bounds.size.width + bounds.origin.x;
	CGFloat y = randomFloat() * bounds.size.height + bounds.origin.y;
	return CGPointMake(x, y);
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    //要如何接 Dictionary 的資料
    //要怎麼在之後存取到 layer
    NSLog(@"drawLayer");
//    [self backgroundLayer:context];
//    [self drawBorderLayer:context];
    if ([layer.name isEqualToString:layer1.name]) {
        NSLog(@"Layer1 enter");
    } else if ([layer.name isEqualToString:layer2.name]) {
        NSLog(@"Layer2 enter");
    }
    
    if (layer == layer1) {
        [self drawBorderLayer:context];
        NSLog(@"layer1 Layer");
    } else if (layer == layer2) {
        [self backgroundLayer:context];
        NSLog(@"layer2 Layer");
    }
    
}

- (void)drawBorderLayer:(CGContextRef)context
{
    //底框
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColor = CGColorCreateFromNSColor([NSColor blackColor], colorSpace);
    CGContextAddRect(context, CGRectMake(1 , 1, 260, 100));
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, borderColor); //線色
    CGContextStrokePath(context);
    CGContextClosePath(context);
//	CGContextRestoreGState(context);
}

- (void)backgroundLayer:(CGContextRef)context
{
    //背景
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColor = CGColorCreateFromNSColor([NSColor whiteColor], colorSpace);
    CGContextAddRect(context, CGRectMake(0, 0, 320, 180));
    CGContextSetFillColorWithColor(context, borderColor); //內容色
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, borderColor); //線色
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextClosePath(context);
    CGContextEOFillPath(context);
    
}


- (void)changeLayerPosition:(CALayer *)layer toPosition:(NSPoint)position
{
    NSLog(@"%@", layer.name);
    layer.position = position;
}

- (void)changeDisplayLayer:(CALayer *)layerA
{
    [layerA setNeedsDisplay];
    [layer1 setNeedsDisplay];
    [layer2 setNeedsDisplay];
}

CGColorRef CGColorCreateFromNSColor(NSColor *color, CGColorSpaceRef colorSpace)
{
    NSColor *deviceColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];
    CGFloat components[4];
    [deviceColor getRed:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
    
    return CGColorCreate (colorSpace, components);
}
@end
