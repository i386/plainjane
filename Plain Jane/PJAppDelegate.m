//
//  PJAppDelegate.m
//  Plain Jane
//
//  Created by James Dumay on 19/02/13.
//  Copyright (c) 2013 James Dumay. All rights reserved.
//

#import "PJAppDelegate.h"

@implementation PJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *event) {
        NSUInteger flags = [event modifierFlags];
        int altDown = flags & NSCommandKeyMask;
        
        //Command + V
        if (([event keyCode] == 9) && altDown) {
            NSPasteboard *pboard = [NSPasteboard generalPasteboard];
            
            NSString* value = [pboard stringForType:NSStringPboardType];
            
            if (value) {
                [pboard clearContents];
                [pboard setString:value forType:NSStringPboardType];
            }
        };
    }];
    
    [NSApp activateIgnoringOtherApps:YES];
}

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
    [_window makeKeyAndOrderFront:nil];
}

- (IBAction)hideMainWindow:(id)sender
{
    [_window close];
}

- (IBAction)closeApp:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
}


@end