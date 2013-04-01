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
    _startAtLoginController = [[StartAtLoginController alloc] initWithIdentifier:@"com.whimsy.PlainJaneHelperApp"];
    [_startAtLoginMenuItem setState:(_startAtLoginController.enabled ? NSOnState : NSOffState)];
    
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
    
    if (![_startAtLoginController enabled])
    {
        [_mainWindow makeKeyAndOrderFront:self];
        [NSApp activateIgnoringOtherApps:YES];
    }
}

- (IBAction)hideMainWindow:(id)sender
{
    [_mainWindow close];
}

- (IBAction)closeApp:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
}

-(void)showAbout:(id)sender
{
    [[NSApplication sharedApplication] orderFrontStandardAboutPanel:self];
}

- (IBAction)startAtLoginChecked:(id)sender
{
    [self startAtLogin:_startAtLoginMenuItem];
}

-(void)startAtLogin:(id)sender
{
    NSMenuItem *item = sender;
    [_startAtLoginController setStartAtLogin:[self swizzleState:item]];
}

- (IBAction)enablePlainPastes:(id)sender
{
    NSMenuItem *item = sender;
    _enabled = [self swizzleState:item];
}

-(BOOL)swizzleState:(NSMenuItem*)item
{
    if (item.state == NSOnState)
    {
        [item setState:NSOffState];
    }
    else if (item.state == NSOffState)
    {
        [item setState:NSOnState];
    }
    return (item.state == NSOnState);
}

@end