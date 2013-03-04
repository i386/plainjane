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
    _enabled = YES;
    
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setIcon:[NSImage imageNamed:@"status-item-menu"] withAlternateIcon:[NSImage imageNamed:@"status-item-menu-alt"]];
    [_statusItem setHighlightMode:YES];
    [_statusItem setMenu:_statusMenu];
   
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *event) {
        
        //Return if disabled
        if (!_enabled) return;
        
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


- (IBAction)enablePlainPastes:(id)sender
{
    NSMenuItem *item = sender;
    
    if (item.state == NSOnState)
    {
        [item setState:NSOffState];
    }
    else if (item.state == NSOffState)
    {
        [item setState:NSOnState];
    }
    
    _enabled = item.state == NSOnState;
}

- (IBAction)quitApp:(id)sender
{
     [[NSApplication sharedApplication] terminate:self];
}
@end