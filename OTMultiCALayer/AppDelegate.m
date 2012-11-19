//
//  AppDelegate.m
//  OTMultiCALayer
//
//  Created by Hank0272 on 12/11/19.
//  Copyright (c) 2012年 Eric Yeh. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize otLayer;
- (void)dealloc
{
    [otLayer release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    otLayer = [[OTLayerDrawing alloc]init];
}

- (IBAction)reDrawAction:(id)sender
{
    [otLayer changeDisplayLayer:otLayer.layer2];
}
@end
