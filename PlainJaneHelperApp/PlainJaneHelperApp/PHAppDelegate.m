//
//  PHAppDelegate.m
//  PlainJaneHelperApp
//
//  Created by James Dumay on 9/03/13.
//  Copyright (c) 2013 James Dumay. All rights reserved.
//

#import "PHAppDelegate.h"

@implementation PHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/Plain Jane.app"];
    [[NSApplication sharedApplication] terminate:self];
}

@end
